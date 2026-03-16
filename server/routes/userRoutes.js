const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// 注册路由
router.post('/register', userController.register);

// 登录路由
router.post('/login', userController.login);

// 修改用户名
router.post('/update', userController.updateUsername);

// 修改密码
router.post('/password', userController.updatePassword);

module.exports = router;

