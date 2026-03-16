const { playlist_detail, song_url } = require('NeteaseCloudMusicApi');
const mysql = require('mysql2/promise');
const dotenv = require('dotenv');

dotenv.config();

// 数据库配置
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '123456',
  database: process.env.DB_NAME || 'whumusic',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
};

// 要导入的歌单 ID (例如: 网易云热歌榜 3778678)
const PLAYLIST_ID = '3778678';
const IMPORT_LIMIT = 20; // 限制导入数量，避免请求过多被封
const NETEASE_COOKIE = process.env.NETEASE_COOKIE || '';

async function importMusic() {
  let connection;
  try {
    console.log('🔌 连接数据库...');
    connection = await mysql.createConnection(dbConfig);
    console.log('✅ 数据库连接成功');

    console.log(`📥 开始获取网易云歌单 [${PLAYLIST_ID}] 详情...`);
    const playlistRes = await playlist_detail({
      id: PLAYLIST_ID,
      cookie: NETEASE_COOKIE
    });

    if (playlistRes.status !== 200) {
      throw new Error(`获取歌单失败: ${playlistRes.status}`);
    }

    const playlist = playlistRes.body.playlist;
    console.log(`🎵 歌单 "${playlist.name}" 获取成功...`);

    // 1. 插入/更新歌单信息
    const [playlistResult] = await connection.execute(
      `INSERT INTO playlists (name, cover_url, description, created_at) 
       VALUES (?, ?, ?, NOW()) 
       ON DUPLICATE KEY UPDATE name = VALUES(name), cover_url = VALUES(cover_url), description = VALUES(description)`,
      [playlist.name, playlist.coverImgUrl, playlist.description || '网易云导入']
    );
    const localPlaylistId = playlistResult.insertId || (await connection.execute('SELECT id FROM playlists WHERE name = ? LIMIT 1', [playlist.name]))[0][0].id;

    // 保证 songs 表存在 netease_id 字段（用于根据网易云ID获取最新播放链接）
    const [colRows] = await connection.execute(
      `SELECT 1 FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'songs' AND COLUMN_NAME = 'netease_id' LIMIT 1`
    );
    if (colRows.length === 0) {
      console.log('🛠️ 检测到 songs 表缺少 netease_id 字段，正在添加...');
      await connection.execute(`ALTER TABLE songs ADD COLUMN netease_id BIGINT NULL COMMENT '网易云歌曲ID'`);
      console.log('✅ 已添加 netease_id 字段');
    }

    // 2. 遍历歌曲导入
    // 为了支持分页获取新歌，我们需要一个偏移量机制，或者简单地增加获取数量并过滤已存在的
    // 简单起见，我们增加一个 offset 参数，或者在获取时多获取一些，然后过滤掉数据库中已存在的
    // 获取当前数据库中已有的歌曲数量
    const [countRows] = await connection.execute('SELECT COUNT(*) as count FROM songs');
    const currentCount = countRows[0].count;
    console.log(`📊 当前数据库已有歌曲数量: ${currentCount}`);

    // 我们从网易云获取更多歌曲，比如 currentCount + IMPORT_LIMIT
    // 但为了确保获取到新歌，我们最好使用 offset
    // 这里的逻辑是：我们希望每次运行脚本都能导入一些数据库里没有的新歌
    // 我们可以简单地设置一个较大的 limit，然后跳过已存在的
    
    // 或者，更智能一点：每次随机从热歌榜里挑，或者按顺序往下取
    // 这里我们采用：获取 offset = currentCount 的数据
    // 注意：网易云歌单接口其实是一次性返回所有 trackIds，然后我们可以根据 id 获取详情
    // 但 playlist_detail 返回的 tracks 通常只有前 N 首。
    // 如果要获取完整歌单，需要用 trackIds 列表再去调 song_detail。

    // 为了简单且有效：我们这次直接获取前 50 首，然后只插入那些数据库里没有的。
    // 如果前 20 首都在数据库里了，我们就往后找。
    
    const allTrackIds = playlist.trackIds.map(t => t.id);
    console.log(`📋 歌单共包含 ${allTrackIds.length} 首歌曲 ID`);
    
    
    let newImportCount = 0;
    const MAX_SCAN = 100; // 最多扫描前 100 首

    let candidateTracks = playlist.tracks;
    
    if (candidateTracks.length < MAX_SCAN && allTrackIds.length > candidateTracks.length) {
        // 需要额外获取详情
        const idsToFetch = allTrackIds.slice(candidateTracks.length, MAX_SCAN);
        if (idsToFetch.length > 0) {
             const { song_detail } = require('NeteaseCloudMusicApi');
             const detailRes = await song_detail({ ids: idsToFetch.join(','), cookie: NETEASE_COOKIE });
             if (detailRes.status === 200) {
                 candidateTracks = candidateTracks.concat(detailRes.body.songs);
             }
        }
    }
    
    console.log(`🔍 准备扫描前 ${candidateTracks.length} 首歌曲，目标导入 ${IMPORT_LIMIT} 首新歌...`);

    for (const track of candidateTracks) {
      if (newImportCount >= IMPORT_LIMIT) {
          console.log(`✅ 已达到单次导入上限 (${IMPORT_LIMIT} 首)，停止导入。`);
          break;
      }
    
      try {
        const [exists] = await connection.execute(
            'SELECT id FROM songs WHERE title = ? AND artist_name = ? LIMIT 1',
            [track.name, track.ar[0].name]
        );
        
        if (exists.length > 0) {
            // 更新网易云ID，确保后续可动态获取最新播放链接
            await connection.execute(
              'UPDATE songs SET netease_id = ? WHERE id = ?',
              [track.id, exists[0].id]
            );
            console.log(`⏭️  已存在，已更新网易云ID，跳过: ${track.name}`);
            continue;
        }

        console.log(`处理新歌: ${track.name} - ${track.ar[0].name}`);
        const urlRes = await song_url({
          id: track.id,
          br: 320000,
          cookie: NETEASE_COOKIE
        });

        const songUrl = urlRes.body.data[0]?.url;
        
        if (!songUrl) {
          console.warn(`⚠️ 歌曲 "${track.name}" 无有效播放链接，跳过。`);
          continue;
        }
        const artistName = track.ar[0].name;
        await connection.execute(
          `INSERT IGNORE INTO artists (name) VALUES (?)`,
          [artistName]
        );
        
        const [artistRows] = await connection.execute('SELECT id FROM artists WHERE name = ?', [artistName]);
        const artistId = artistRows[0].id;

        // 插入歌曲
        const [insertSong] = await connection.execute(
            `INSERT INTO songs (title, artist_id, artist_name, album_name, duration, cover_url, audio_url, netease_id, is_local) 
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, 0)`,
            [track.name, artistId, artistName, track.al.name, track.dt, track.al.picUrl, songUrl, track.id]
        );
        const songId = insertSong.insertId;

        // 关联到歌单
        await connection.execute(
          `INSERT IGNORE INTO playlist_songs (playlist_id, song_id) VALUES (?, ?)`,
          [localPlaylistId, songId]
        );
        
        newImportCount++;
        console.log(`✅ 成功导入第 ${newImportCount} 首: ${track.name}`);

      } catch (err) {
        console.error(`❌ 处理歌曲 ${track.name} 失败:`, err.message);
      }
    }

    console.log('✨ 导入完成！');

  } catch (error) {
    console.error('❌ 发生严重错误:', error);
  } finally {
    if (connection) await connection.end();
    process.exit();
  }
}

importMusic();
