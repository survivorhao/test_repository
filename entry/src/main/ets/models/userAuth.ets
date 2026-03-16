import { AppStorageV2 } from '@kit.ArkUI'
import { preferences } from '@kit.ArkData'
import { common } from '@kit.AbilityKit'

@ObservedV2
export class UserAuth {
  @Trace isLogin: boolean = false // 登录状态
  @Trace userId: number = 0 // 用户ID
  @Trace username: string = "" // 用户名
  @Trace token: string = "" // 登录token
  @Trace tags: string = "00后  双子座  北京  歌龄·18年" // 用户标签
  @Trace bgImage: string = "" // 背景图
  @Trace avatarImage: string = "" // 头像

  // 初始化：从本地存储读取登录状态
  async init(context: common.Context) {
    try {
      const dataPreferences = await preferences.getPreferences(context, 'user_auth')
      const savedToken: string = await dataPreferences.get('token', '') as string
      const savedUserId: number = await dataPreferences.get('userId', 0) as number
      const savedUsername: string = await dataPreferences.get('username', '') as string
      const savedTags: string = await dataPreferences.get('tags', '') as string
      const savedBgImage: string = await dataPreferences.get('bgImage', '') as string
      const savedAvatarImage: string = await dataPreferences.get('avatarImage', '') as string
      
      if (savedToken && savedToken.length > 0) {
        this.token = savedToken
        this.userId = savedUserId
        this.username = savedUsername
        if (savedTags) {
          this.tags = savedTags
        }
        if (savedBgImage) {
          this.bgImage = savedBgImage
        }
        if (savedAvatarImage) {
          this.avatarImage = savedAvatarImage
        }
        this.isLogin = true
      }
    } catch (e) {
      console.error('读取登录状态失败:', JSON.stringify(e))
    }
  }

  // 保存登录信息
  async saveLoginInfo(token: string, userId: number, username: string, context: common.Context) {
    try {
      const dataPreferences = await preferences.getPreferences(context, 'user_auth')
      await dataPreferences.put('token', token)
      await dataPreferences.put('userId', userId)
      await dataPreferences.put('username', username)
      await dataPreferences.flush()
      
      this.token = token
      this.userId = userId
      this.username = username
      this.isLogin = true
    } catch (e) {
      console.error('保存登录信息失败:', JSON.stringify(e))
    }
  }

  // 保存标签信息
  async saveTags(tags: string, context: common.Context) {
    try {
      const dataPreferences = await preferences.getPreferences(context, 'user_auth')
      await dataPreferences.put('tags', tags)
      await dataPreferences.flush()
      
      this.tags = tags
    } catch (e) {
      console.error('保存标签信息失败:', JSON.stringify(e))
    }
  }

  // 保存背景图信息
  async saveBgImage(imageUri: string, context: common.Context) {
    try {
      const dataPreferences = await preferences.getPreferences(context, 'user_auth')
      await dataPreferences.put('bgImage', imageUri)
      await dataPreferences.flush()
      
      this.bgImage = imageUri
    } catch (e) {
      console.error('保存背景图信息失败:', JSON.stringify(e))
    }
  }

  // 保存头像信息
  async saveAvatarImage(imageUri: string, context: common.Context) {
    try {
      const dataPreferences = await preferences.getPreferences(context, 'user_auth')
      await dataPreferences.put('avatarImage', imageUri)
      await dataPreferences.flush()
      
      this.avatarImage = imageUri
    } catch (e) {
      console.error('保存头像信息失败:', JSON.stringify(e))
    }
  }

  // 更新用户名
  async updateUsername(newUsername: string, context: common.Context) {
    try {
      const dataPreferences = await preferences.getPreferences(context, 'user_auth')
      await dataPreferences.put('username', newUsername)
      await dataPreferences.flush()
      
      this.username = newUsername
    } catch (e) {
      console.error('更新用户名失败:', JSON.stringify(e))
    }
  }

  // 退出登录
  async logout(context: common.Context) {
    try {
      const dataPreferences = await preferences.getPreferences(context, 'user_auth')
      await dataPreferences.delete('token')
      await dataPreferences.delete('userId')
      await dataPreferences.delete('username')
      await dataPreferences.delete('bgImage')
      await dataPreferences.delete('avatarImage')
      // 可选：退出登录是否清除本地保存的标签？通常保留或也清除。这里选择保留或清除皆可，若要彻底清除：
      // await dataPreferences.delete('tags') 
      await dataPreferences.flush()
      
      this.token = ""
      this.userId = 0
      this.username = ""
      this.isLogin = false
      // 恢复默认标签
      this.tags = "00后  双子座  北京  歌龄·18年"
      this.bgImage = ""
      this.avatarImage = ""
    } catch (e) {
      console.error('退出登录失败:', JSON.stringify(e))
    }
  }
}
