const userModel = require('../models/userModel');
const jwt = require('jsonwebtoken');

// 生成JWT Token
function generateToken(user) {
  const payload = {
    userId: user.id,
    username: user.username
  };
  
  return jwt.sign(payload, process.env.JWT_SECRET || 'your_super_secret_jwt_key', {
    expiresIn: '30d' // Token有效期30天
  });
}

// 注册控制器
async function register(req, res) {
  try {
    const { username, password } = req.body;

    // 验证输入
    if (!username || !password) {
      return res.status(400).json({
        code: 400,
        message: '用户名和密码不能为空',
        data: null
      });
    }

    // 验证用户名长度
    if (username.length < 3) {
      return res.status(400).json({
        code: 400,
        message: '用户名至少需要3个字符',
        data: null
      });
    }

    // 验证密码长度
    if (password.length < 6) {
      return res.status(400).json({
        code: 400,
        message: '密码至少需要6个字符',
        data: null
      });
    }

    // 检查用户名是否已存在
    const existingUser = await userModel.findByUsername(username);
    if (existingUser) {
      return res.status(400).json({
        code: 400,
        message: '用户名已存在',
        data: null
      });
    }

    // 创建用户
    const newUser = await userModel.create(username, password);

    // 返回成功响应
    res.status(200).json({
      code: 200,
      message: '注册成功',
      data: {
        userId: newUser.id
      }
    });
  } catch (error) {
    console.error('注册错误:', error);
    res.status(500).json({
      code: 500,
      message: '服务器内部错误',
      data: null
    });
  }
}

// 登录控制器
async function login(req, res) {
  try {
    const { username, password } = req.body;

    // 验证输入
    if (!username || !password) {
      return res.status(400).json({
        code: 400,
        message: '用户名和密码不能为空',
        data: null
      });
    }

    // 查找用户
    const user = await userModel.findByUsername(username);
    if (!user) {
      return res.status(401).json({
        code: 401,
        message: '用户名或密码错误',
        data: null
      });
    }

    // 检查账号状态
    if (user.status === 1) {
      return res.status(403).json({
        code: 403,
        message: '账号已被禁用',
        data: null
      });
    }

    // 验证密码
    const isPasswordValid = await userModel.verifyPassword(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({
        code: 401,
        message: '用户名或密码错误',
        data: null
      });
    }

    // 生成Token
    const token = generateToken(user);

    // 返回成功响应
    res.status(200).json({
      code: 200,
      message: '登录成功',
      data: {
        token: token,
        user: {
          id: user.id,
          username: user.username,
          status: user.status
        }
      }
    });
  } catch (error) {
    console.error('登录错误:', error);
    res.status(500).json({
      code: 500,
      message: '服务器内部错误',
      data: null
    });
  }
}

module.exports = {
  register,
  login,
  // 修改用户名
  async updateUsername(req, res) {
    try {
      const { userId, username } = req.body;

      if (!userId || !username) {
        return res.status(400).json({
          code: 400,
          message: '缺少必要参数',
          data: null
        });
      }

      if (String(username).trim().length < 3) {
        return res.status(400).json({
          code: 400,
          message: '用户名至少需要3个字符',
          data: null
        });
      }

      // 检查用户是否存在
      const user = await userModel.findById(userId);
      if (!user) {
        return res.status(404).json({
          code: 404,
          message: '用户不存在',
          data: null
        });
      }

      // 如果用户名没有变化，直接返回成功
      if (user.username === username) {
        return res.status(200).json({
          code: 200,
          message: '用户名修改成功',
          data: null
        });
      }

      // 检查用户名是否被其他用户占用
      const existing = await userModel.findByUsername(username);
      if (existing && existing.id !== userId) {
        return res.status(400).json({
          code: 400,
          message: '用户名已存在',
          data: null
        });
      }

      const ok = await userModel.updateUsernameById(userId, username);
      if (!ok) {
        return res.status(500).json({
          code: 500,
          message: '用户名修改失败',
          data: null
        });
      }

      return res.status(200).json({
        code: 200,
        message: '用户名修改成功',
        data: null
      });
    } catch (error) {
      console.error('修改用户名错误:', error);
      return res.status(500).json({
        code: 500,
        message: '服务器内部错误',
        data: null
      });
    }
  },
  // 修改密码
  async updatePassword(req, res) {
    try {
      const { userId, oldPassword, newPassword } = req.body;

      if (!userId || !oldPassword || !newPassword) {
        return res.status(400).json({
          code: 400,
          message: '缺少必要参数',
          data: null
        });
      }

      if (String(newPassword).length < 6) {
        return res.status(400).json({
          code: 400,
          message: '新密码至少需要6个字符',
          data: null
        });
      }

      // 查询用户和密码
      const user = await userModel.findByIdWithPassword(userId);
      if (!user) {
        return res.status(404).json({
          code: 404,
          message: '用户不存在',
          data: null
        });
      }

      // 验证原密码
      const valid = await userModel.verifyPassword(oldPassword, user.password);
      if (!valid) {
        return res.status(401).json({
          code: 401,
          message: '原密码错误',
          data: null
        });
      }

      // 不允许与原密码一致
      const same = await userModel.verifyPassword(newPassword, user.password);
      if (same) {
        return res.status(400).json({
          code: 400,
          message: '新密码不能与原密码相同',
          data: null
        });
      }

      const ok = await userModel.updatePasswordById(userId, newPassword);
      if (!ok) {
        return res.status(500).json({
          code: 500,
          message: '密码修改失败',
          data: null
        });
      }

      return res.status(200).json({
        code: 200,
        message: '密码修改成功',
        data: null
      });
    } catch (error) {
      console.error('修改密码错误:', error);
      return res.status(500).json({
        code: 500,
        message: '服务器内部错误',
        data: null
      });
    }
  }
};

