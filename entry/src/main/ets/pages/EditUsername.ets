import { UserAuth } from '../models/userAuth'
import { AppStorageV2 } from '@kit.ArkUI'
import { apiService } from '../utils/apiService'
import promptAction from '@ohos.promptAction'
import { common } from '@kit.AbilityKit'

@Builder
export function EditUsernameBuilder() {
  EditUsername()
}

@Component
export struct EditUsername {
  @State newUsername: string = ''
  @State isLoading: boolean = false
  
  pathStack: NavPathStack = new NavPathStack()
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!

  aboutToAppear() {
    this.newUsername = this.userAuth.username
  }

  async handleSave() {
    if (!this.newUsername.trim()) {
      promptAction.showToast({ message: '用户名不能为空' })
      return
    }

    if (this.newUsername === this.userAuth.username) {
        this.pathStack.pop()
        return
    }

    this.isLoading = true
    try {
      const response = await apiService.updateUsername(this.userAuth.userId, this.newUsername)
      
      if (response.code === 200 || response.code === 0) {
        const context = getContext(this) as common.UIAbilityContext
        await this.userAuth.updateUsername(this.newUsername, context)
        promptAction.showToast({ message: '用户名修改成功' })
        this.pathStack.pop()
      } else {
        promptAction.showToast({ message: response.message || '修改失败' })
      }
    } catch (error) {
      console.error('Update Username Error:', JSON.stringify(error))
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
        Text('修改用户名')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ top: 40, bottom: 20 })
          .alignSelf(ItemAlign.Start)

        // 输入框
        TextInput({ text: this.newUsername, placeholder: '请输入新用户名' })
          .width('100%')
          .height(50)
          .backgroundColor('#333333')
          .borderRadius(8)
          .fontColor(Color.White)
          .placeholderColor('#666666')
          .padding({ left: 12, right: 12 })
          .onChange((value: string) => {
            this.newUsername = value
          })

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

          Button('保存')
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