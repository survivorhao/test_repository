const { pool } = require('../config/database');

class MusicModel {
  // 获取所有歌曲
  async findAll() {
    try {
      const [rows] = await pool.execute('SELECT * FROM songs ORDER BY id ASC');
      return rows;
    } catch (error) {
      console.error('获取歌曲列表失败:', error);
      throw error;
    }
  }

  // 根据ID获取歌曲
  async findById(id) {
    try {
      const [rows] = await pool.execute('SELECT * FROM songs WHERE id = ?', [id]);
      return rows.length > 0 ? rows[0] : null;
    } catch (error) {
      console.error('获取歌曲详情失败:', error);
      throw error;
    }
  }

  // 搜索歌曲
  async search(keyword) {
    try {
      const searchPattern = `%${keyword}%`;
      const [rows] = await pool.execute(
        'SELECT * FROM songs WHERE title LIKE ? OR artist_name LIKE ?',
        [searchPattern, searchPattern]
      );
      return rows;
    } catch (error) {
      console.error('搜索歌曲失败:', error);
      throw error;
    }
  }
}

module.exports = new MusicModel();
