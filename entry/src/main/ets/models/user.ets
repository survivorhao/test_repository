// 用户信息接口
export interface UserInfo {
  id: number
  username: string
  status: number
}

// 登录请求参数
export interface LoginRequest {
  username: string
  password: string
}

// 注册请求参数
export interface RegisterRequest {
  username: string
  password: string
}

// 修改用户名请求参数
export interface UpdateUsernameRequest {
  userId: number
  username: string
}

// 修改密码请求参数
export interface UpdatePasswordRequest {
  userId: number
  oldPassword: string
  newPassword: string
}

// API响应基础结构
export interface ApiResponse<T> {
  code: number
  message: string
  data: T
}

// 登录响应数据
export interface LoginResponse {
  token: string
  user: UserInfo
}

