import { apiService } from '../utils/apiService'
import { UserAuth } from '../models/userAuth'
import { AppStorageV2 } from '@kit.ArkUI'
import { LoginRequest } from '../models/user'
import promptAction from '@ohos.promptAction'
import { common } from '@kit.AbilityKit'

interface LoginForm {
  username: string
  password: string
}

@Builder
export function LoginBuilder() {
  Login()
}

@Component
export struct Login {
  @State form: LoginForm = {
    username: '',
    password: ''
  }
  @State isLoading: boolean = false
  
  pathStack: NavPathStack = new NavPathStack()
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!

  // 处理登录
  async handleLogin() {
    if (!this.form.username.trim()) {
      promptAction.showToast({ message: '请输入用户名', duration: 2000 })
      return
    }
    if (!this.form.password.trim()) {
      promptAction.showToast({ message: '请输入密码', duration: 2000 })
      return
    }

    this.isLoading = true
    try {
      const params: LoginRequest = {
        username: this.form.username.trim(),
        password: this.form.password
      }
      
      const response = await apiService.login(params)
      
      if (response.code === 200 || response.code === 0) {
        // 登录成功，保存用户信息
        const context = getContext(this) as common.UIAbilityContext
        await this.userAuth.saveLoginInfo(
          response.data.token,
          response.data.user.id,
          response.data.user.username,
          context
        )
        
        promptAction.showToast({ message: '登录成功', duration: 2000 })
        
        // 登录成功，跳转到Layout页面，并清空栈，防止返回到登录页
        this.pathStack.clear()
        this.pathStack.pushPathByName("Layout", null, false)
      } else {
        promptAction.showToast({ message: response.message || '登录失败', duration: 2000 })
      }
    } catch (error) {
      const errorMessage = (error as Record<string, string>).message || '网络错误，请稍后重试'
      promptAction.showToast({ message: errorMessage, duration: 2000 })
    } finally {
      this.isLoading = false
    }
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        // 标题
        Text('登录')
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 60, bottom: 40 })

        // 用户名输入框
        Column({ space: 8 }) {
          Text('用户名')
            .fontSize(14)
            .fontColor('#999999')
            .width('100%')
          TextInput({ placeholder: '请输入用户名', text: this.form.username })
            .width('100%')
            .height(50)
            .backgroundColor('#333333')
            .borderRadius(8)
            .fontColor(Color.White)
            .placeholderColor('#666666')
            .padding({ left: 12, right: 12 })
            .onChange((value: string) => {
              this.form.username = value
            })
        }
        .width('80%')

        // 密码输入框
        Column({ space: 8 }) {
          Text('密码')
            .fontSize(14)
            .fontColor('#999999')
            .width('100%')
          TextInput({ placeholder: '请输入密码', text: this.form.password })
            .type(InputType.Password)
            .width('100%')
            .height(50)
            .backgroundColor('#333333')
            .borderRadius(8)
            .fontColor(Color.White)
            .placeholderColor('#666666')
            .padding({ left: 12, right: 12 })
            .onChange((value: string) => {
              this.form.password = value
            })
        }
        .width('80%')

        // 登录按钮
        Button('登录')
          .width('80%')
          .height(50)
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor('#E85A88')
          .borderRadius(8)
          .enabled(!this.isLoading)
          .opacity(this.isLoading ? 0.6 : 1)
          .onClick(() => {
            this.handleLogin()
          })

        // 注册按钮
        Row() {
          Text('还没有账号？')
            .fontSize(14)
            .fontColor('#999999')
          Text('立即注册')
            .fontSize(14)
            .fontColor('#E85A88')
            .onClick(() => {
              this.pathStack.pushPathByName('Register', null, false)
            })
        }
        .margin({ top: 20 })
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#131313')
      .justifyContent(FlexAlign.Start)
      .padding({ top: 40 })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}

