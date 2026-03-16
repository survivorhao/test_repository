const express = require('express');
const cors = require('cors');
require('dotenv').config();

const { testConnection } = require('./config/database');
const userRoutes = require('./routes/userRoutes');
const musicRoutes = require('./routes/musicRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// 中间件
app.use(cors()); // 允许跨域请求
app.use(express.json()); // 解析JSON请求体
app.use(express.urlencoded({ extended: true })); // 解析URL编码的请求体

// 请求日志中间件
app.use((req, res, next) => {
  console.log(`${new Date().toLocaleString()} - ${req.method} ${req.path}`);
  next();
});

// 路由
app.use('/api/user', userRoutes);
app.use('/api/music', musicRoutes);

// 健康检查路由
app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    message: '服务器运行正常',
    timestamp: new Date().toISOString()
  });
});

// 404处理
app.use((req, res) => {
  res.status(404).json({
    code: 404,
    message: '接口不存在',
    data: null
  });
});

// 错误处理中间件
app.use((err, req, res, next) => {
  console.error('服务器错误:', err);
  res.status(500).json({
    code: 500,
    message: '服务器内部错误',
    data: null
  });
});

// 启动服务器
async function startServer() {
  // 测试数据库连接
  const dbConnected = await testConnection();
  
  if (!dbConnected) {
    console.error('❌ 无法连接到数据库，请检查配置');
    process.exit(1);
  }

  // 启动HTTP服务器
  app.listen(PORT, () => {
    console.log('=================================');
    console.log('🚀 服务器启动成功！');
    console.log(`📍 服务地址: http://localhost:${PORT}`);
    console.log(`📡 API地址: http://localhost:${PORT}/api`);
    console.log(`💚 健康检查: http://localhost:${PORT}/health`);
    console.log('=================================');
  });
}

// 启动服务
startServer();

