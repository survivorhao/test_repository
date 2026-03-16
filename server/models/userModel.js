const { pool } = require('../config/database');
const bcrypt = require('bcryptjs');

class UserModel {
  // 根据用户名查找用户
  async findByUsername(username) {
    try {
      const [rows] = await pool.execute(
        'SELECT * FROM users WHERE username = ?',
        [username]
      );
      return rows.length > 0 ? rows[0] : null;
    } catch (error) {
      console.error('查找用户失败:', error);
      throw error;
    }
  }

  // 根据ID查找用户
  async findById(id) {
    try {
      const [rows] = await pool.execute(
        'SELECT id, username, status FROM users WHERE id = ?',
        [id]
      );
      return rows.length > 0 ? rows[0] : null;
    } catch (error) {
      console.error('查找用户失败:', error);
      throw error;
    }
  }

  // 根据ID查找用户（包含密码）
  async findByIdWithPassword(id) {
    try {
      const [rows] = await pool.execute(
        'SELECT id, username, password, status FROM users WHERE id = ?',
        [id]
      );
      return rows.length > 0 ? rows[0] : null;
    } catch (error) {
      console.error('查找用户(含密码)失败:', error);
      throw error;
    }
  }

  // 创建用户
  async create(username, password) {
    try {
      // 加密密码
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);

      const [result] = await pool.execute(
        'INSERT INTO users (username, password, status) VALUES (?, ?, ?)',
        [username, hashedPassword, 0]
      );

      return {
        id: result.insertId,
        username: username
      };
    } catch (error) {
      console.error('创建用户失败:', error);
      throw error;
    }
  }

  // 验证密码
  async verifyPassword(plainPassword, hashedPassword) {
    try {
      return await bcrypt.compare(plainPassword, hashedPassword);
    } catch (error) {
      console.error('密码验证失败:', error);
      return false;
    }
  }

  // 更新用户名
  async updateUsernameById(id, newUsername) {
    try {
      const [result] = await pool.execute(
        'UPDATE users SET username = ? WHERE id = ?',
        [newUsername, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      console.error('更新用户名失败:', error);
      throw error;
    }
  }

  // 更新密码
  async updatePasswordById(id, newPassword) {
    try {
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(newPassword, salt);
      const [result] = await pool.execute(
        'UPDATE users SET password = ? WHERE id = ?',
        [hashedPassword, id]
      );
      return result.affectedRows > 0;
    } catch (error) {
      console.error('更新密码失败:', error);
      throw error;
    }
  }
}

module.exports = new UserModel();

