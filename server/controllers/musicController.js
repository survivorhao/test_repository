const musicModel = require('../models/musicModel');
const { song_url, personalized, playlist_detail } = require('NeteaseCloudMusicApi');
const NETEASE_COOKIE = process.env.NETEASE_COOKIE || '';

// 获取歌曲列表
async function getList(req, res) {
  try {
    const songs = await musicModel.findAll();
    
    // 转换为前端需要的格式 (SongItemType)
    const formattedSongs = songs.map(song => ({
      id: song.id.toString(),
      name: song.title,
      author: song.artist_name || '未知歌手',
      img: song.cover_url,
      url: song.audio_url
    }));

    res.status(200).json({
      code: 200,
      message: '获取成功',
      data: formattedSongs
    });
  } catch (error) {
    console.error('获取歌曲列表错误:', error);
    res.status(500).json({
      code: 500,
      message: '服务器内部错误',
      data: null
    });
  }
}

// 获取歌曲详情
async function getDetail(req, res) {
  try {
    const { id } = req.params;
    const song = await musicModel.findById(id);

    if (!song) {
      return res.status(404).json({
        code: 404,
        message: '歌曲不存在',
        data: null
      });
    }

    res.status(200).json({
      code: 200,
      message: '获取成功',
      data: {
        id: song.id.toString(),
        name: song.title,
        author: song.artist_name,
        img: song.cover_url,
        url: song.audio_url
      }
    });
  } catch (error) {
    console.error('获取歌曲详情错误:', error);
    res.status(500).json({
      code: 500,
      message: '服务器内部错误',
      data: null
    });
  }
}

// 搜索歌曲
async function searchMusic(req, res) {
  try {
    const { keyword } = req.query;
    if (!keyword) {
      return res.status(400).json({
        code: 400,
        message: '请输入搜索关键字',
        data: null
      });
    }

    const songs = await musicModel.search(keyword);
    
    const formattedSongs = songs.map(song => ({
      id: song.id.toString(),
      name: song.title,
      author: song.artist_name,
      img: song.cover_url,
      url: song.audio_url
    }));

    res.status(200).json({
      code: 200,
      message: '搜索成功',
      data: formattedSongs
    });
  } catch (error) {
    console.error('搜索歌曲错误:', error);
    res.status(500).json({
      code: 500,
      message: '服务器内部错误',
      data: null
    });
  }
}

// 获取歌曲最新播放链接（动态获取，解决链接过期问题）
async function getSongUrl(req, res) {
  try {
    const { id } = req.params;
    const song = await musicModel.findById(id);
    if (!song) {
      return res.status(404).json({ code: 404, message: '歌曲不存在', data: null });
    }
    if (!song.netease_id) {
      // 没有网易云ID则返回数据库中的链接（可能会过期）
      if (song.audio_url) {
        return res.status(200).json({ code: 200, message: '获取成功', data: { url: song.audio_url } });
      }
      return res.status(400).json({ code: 400, message: '缺少网易云ID，无法获取播放链接', data: null });
    }
    const urlRes = await song_url({ id: song.netease_id, br: 320000, cookie: NETEASE_COOKIE });
    const url = urlRes?.body?.data?.[0]?.url || '';
    if (!url) {
      return res.status(403).json({ code: 403, message: '无法获取播放链接，可能需要VIP或Cookie', data: null });
    }
    res.status(200).json({ code: 200, message: '获取成功', data: { url } });
  } catch (error) {
    console.error('获取歌曲播放链接错误:', error);
    res.status(500).json({ code: 500, message: '服务器内部错误', data: null });
  }
}

// 获取网易云推荐歌单
async function getRecommendPlaylists(req, res) {
  try {
    const resp = await personalized({ cookie: NETEASE_COOKIE });
    if (resp.status !== 200) {
      return res.status(500).json({ code: 500, message: '获取推荐歌单失败', data: null });
    }
    const list = (resp.body.result || []).map(p => ({
      id: String(p.id),
      name: p.name,
      cover_url: p.picUrl
    }));
    res.status(200).json({ code: 200, message: '获取成功', data: list });
  } catch (error) {
    console.error('获取推荐歌单错误:', error);
    res.status(500).json({ code: 500, message: '服务器内部错误', data: null });
  }
}

// 获取网易云歌单详情（返回歌曲列表）
async function getNetEasePlaylistDetail(req, res) {
  try {
    const { id } = req.params;
    const resp = await playlist_detail({ id, cookie: NETEASE_COOKIE });
    if (resp.status !== 200) {
      return res.status(500).json({ code: 500, message: '获取歌单详情失败', data: null });
    }
    const tracks = (resp.body.playlist?.tracks || []).map(t => ({
      id: String(t.id),
      name: t.name,
      author: (t.ar && t.ar[0] && t.ar[0].name) ? t.ar[0].name : '未知歌手',
      img: t.al?.picUrl || '',
      url: '' // 前端点击时再调用接口获取最新播放链接
    }));
    res.status(200).json({ code: 200, message: '获取成功', data: tracks });
  } catch (error) {
    console.error('获取歌单详情错误:', error);
    res.status(500).json({ code: 500, message: '服务器内部错误', data: null });
  }
}

// 根据网易云歌曲ID获取播放链接
async function getNetEaseSongUrl(req, res) {
  try {
    const { id } = req.params;
    const urlRes = await song_url({ id, br: 320000, cookie: NETEASE_COOKIE });
    const url = urlRes?.body?.data?.[0]?.url || '';
    if (!url) {
      return res.status(403).json({ code: 403, message: '无法获取播放链接，可能需要VIP或Cookie', data: null });
    }
    res.status(200).json({ code: 200, message: '获取成功', data: { url } });
  } catch (error) {
    console.error('获取网易云歌曲链接错误:', error);
    res.status(500).json({ code: 500, message: '服务器内部错误', data: null });
  }
}

module.exports = {
  getList,
  getDetail,
  searchMusic,
  getSongUrl,
  getRecommendPlaylists,
  getNetEasePlaylistDetail,
  getNetEaseSongUrl
};
