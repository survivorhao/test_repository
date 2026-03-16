import { UserAuth } from '../models/userAuth'
import { AppStorageV2 } from '@kit.ArkUI'
import { apiService } from '../utils/apiService'
import promptAction from '@ohos.promptAction'
import { common } from '@kit.AbilityKit'

@Builder
export function EditPasswordBuilder() {
  EditPassword()
}

@Component
export struct EditPassword {
  @State oldPassword: string = ''
  @State newPassword: string = ''
  @State confirmPassword: string = ''
  @State isLoading: boolean = false
  
  pathStack: NavPathStack = new NavPathStack()
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!

  async handleSave() {
    if (!this.oldPassword) {
      promptAction.showToast({ message: '请输入原密码' })
      return
    }
    if (!this.newPassword) {
      promptAction.showToast({ message: '请输入新密码' })
      return
    }
    if (this.newPassword.length < 6) {
        promptAction.showToast({ message: '新密码至少6位' })
        return
    }
    if (this.newPassword !== this.confirmPassword) {
      promptAction.showToast({ message: '两次新密码输入不一致' })
      return
    }

    this.isLoading = true
    try {
      const response = await apiService.updatePassword(this.userAuth.userId, this.oldPassword, this.newPassword)
      
      if (response.code === 200 || response.code === 0) {
        promptAction.showToast({ message: '密码修改成功' })
        this.pathStack.pop()
      } else {
        promptAction.showToast({ message: response.message || '修改失败，原密码可能错误' })
      }
    } catch (error) {
      console.error('Update Password Error:', JSON.stringify(error))
      const errorMessage = (error as Record<string, string>).message || '网络错误，请稍后重试'
      promptAction.showToast({ message: errorMessage })
    } finally {
      this.isLoading = false
    }
  }

  build() {
    NavDestination() {
      Column({ space: 20 }) {
        // 标题栏
        Text('修改密码')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 40, bottom: 20 })
          .alignSelf(ItemAlign.Start)

        // 原密码
        Column({ space: 8 }) {
            Text('原密码')
                .fontSize(14)
                .fontColor('#999999')
                .width('100%')
            TextInput({ text: this.oldPassword, placeholder: '请输入原密码' })
                .type(InputType.Password)
                .width('100%')
                .height(50)
                .backgroundColor('#333333')
                .borderRadius(8)
                .fontColor(Color.White)
                .placeholderColor('#666666')
                .padding({ left: 12, right: 12 })
                .onChange((value: string) => {
                    this.oldPassword = value
                })
        }

        // 新密码
        Column({ space: 8 }) {
            Text('新密码')
                .fontSize(14)
                .fontColor('#999999')
                .width('100%')
            TextInput({ text: this.newPassword, placeholder: '请输入新密码（至少6位）' })
                .type(InputType.Password)
                .width('100%')
                .height(50)
                .backgroundColor('#333333')
                .borderRadius(8)
                .fontColor(Color.White)
                .placeholderColor('#666666')
                .padding({ left: 12, right: 12 })
                .onChange((value: string) => {
                    this.newPassword = value
                })
        }

        // 确认新密码
        Column({ space: 8 }) {
            Text('确认新密码')
                .fontSize(14)
                .fontColor('#999999')
                .width('100%')
            TextInput({ text: this.confirmPassword, placeholder: '请再次输入新密码' })
                .type(InputType.Password)
                .width('100%')
                .height(50)
                .backgroundColor('#333333')
                .borderRadius(8)
                .fontColor(Color.White)
                .placeholderColor('#666666')
                .padding({ left: 12, right: 12 })
                .onChange((value: string) => {
                    this.confirmPassword = value
                })
        }

        // 按钮区域
        Row({ space: 20 }) {
          Button('取消')
            .width('40%')
            .height(45)
            .backgroundColor('#CCCCCC')
            .fontColor(Color.Black)
            .onClick(() => {
              this.pathStack.pop()
            })

          Button('更改')
            .width('40%')
            .height(45)
            .backgroundColor('#E85A88')
            .fontColor(Color.White)
            .enabled(!this.isLoading)
            .opacity(this.isLoading ? 0.6 : 1)
            .onClick(() => {
              this.handleSave()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .margin({ top: 40 })

      }
      .width('100%')
      .height('100%')
      .backgroundColor('#131313')
      .padding({ left: 20, right: 20 })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}