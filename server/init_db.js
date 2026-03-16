const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

async function initDatabase() {
  console.log('开始初始化数据库...');

  const config = {
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'whumusic',
    multipleStatements: true // 允许执行多条SQL语句
  };

  try {
    // 读取SQL文件
    const sqlPath = path.join(__dirname, 'music.sql');
    const sqlContent = fs.readFileSync(sqlPath, 'utf8');

    // 创建连接
    const connection = await mysql.createConnection(config);
    console.log('数据库连接成功');

    // 执行SQL
    await connection.query(sqlContent);
    console.log('✅ 数据表创建及初始数据导入成功！');

    await connection.end();
  } catch (error) {
    console.error('❌ 初始化失败:', error);
    process.exit(1);
  }
}

initDatabase();
