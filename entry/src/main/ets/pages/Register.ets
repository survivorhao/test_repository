import { apiService } from '../utils/apiService'
import { UserAuth } from '../models/userAuth'
import { AppStorageV2 } from '@kit.ArkUI'
import { RegisterRequest } from '../models/user'
import promptAction from '@ohos.promptAction'

interface RegisterForm {
  username: string
  password: string
  confirmPassword: string
}

@Builder
export function RegisterBuilder() {
  Register()
}

@Component
export struct Register {
  @State form: RegisterForm = {
    username: '',
    password: '',
    confirmPassword: ''
  }
  @State isLoading: boolean = false
  
  pathStack: NavPathStack = new NavPathStack()
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!

  // 处理注册
  async handleRegister() {
    if (!this.form.username.trim()) {
      promptAction.showToast({ message: '请输入用户名', duration: 2000 })
      return
    }
    if (this.form.username.trim().length < 3) {
      promptAction.showToast({ message: '用户名至少3个字符', duration: 2000 })
      return
    }
    if (!this.form.password.trim()) {
      promptAction.showToast({ message: '请输入密码', duration: 2000 })
      return
    }
    if (this.form.password.length < 6) {
      promptAction.showToast({ message: '密码至少6个字符', duration: 2000 })
      return
    }
    if (this.form.password !== this.form.confirmPassword) {
      promptAction.showToast({ message: '两次密码输入不一致', duration: 2000 })
      return
    }

    this.isLoading = true
    try {
      const params: RegisterRequest = {
        username: this.form.username.trim(),
        password: this.form.password
      }
      
      const response = await apiService.register(params)
      
      if (response.code === 200 || response.code === 0) {
        promptAction.showToast({ message: '注册成功，请登录', duration: 2000 })
        
        // 注册成功后返回登录页面
        setTimeout(() => {
          this.pathStack.replacePathByName("Login", null, false)
        }, 2000)
      } else {
        promptAction.showToast({ message: response.message || '注册失败', duration: 2000 })
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
        Text('注册')
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
          TextInput({ placeholder: '请输入用户名（至少3个字符）', text: this.form.username })
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
          TextInput({ placeholder: '请输入密码（至少6个字符）', text: this.form.password })
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

        // 确认密码输入框
        Column({ space: 8 }) {
          Text('确认密码')
            .fontSize(14)
            .fontColor('#999999')
            .width('100%')
          TextInput({ placeholder: '请再次输入密码', text: this.form.confirmPassword })
            .type(InputType.Password)
            .width('100%')
            .height(50)
            .backgroundColor('#333333')
            .borderRadius(8)
            .fontColor(Color.White)
            .placeholderColor('#666666')
            .padding({ left: 12, right: 12 })
            .onChange((value: string) => {
              this.form.confirmPassword = value
            })
        }
        .width('80%')

        // 注册按钮
        Button('注册')
          .width('80%')
          .height(50)
          .fontSize(16)
          .fontColor(Color.White)
          .backgroundColor('#E85A88')
          .borderRadius(8)
          .enabled(!this.isLoading)
          .opacity(this.isLoading ? 0.6 : 1)
          .onClick(() => {
            this.handleRegister()
          })

        // 返回登录按钮
        Row() {
          Text('已有账号？')
            .fontSize(14)
            .fontColor('#999999')
          Text('立即登录')
            .fontSize(14)
            .fontColor('#E85A88')
            .onClick(() => {
              this.pathStack.replacePathByName("Login", null, false)
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

