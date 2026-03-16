import { UserAuth } from '../models/userAuth'
import { AppStorageV2 } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

// 跳转页面入口函数
@Builder
export function StartBuilder() {
  Start()
}

@Component
struct Start {
  // 控制跳转的对象
  pathStack: NavPathStack = new NavPathStack()
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!

  // 页面显示时检查登录状态
  async aboutToAppear() {
    // 初始化登录状态
    const context = getContext(this) as common.UIAbilityContext
    await this.userAuth.init(context)
    
    // 如果已登录，3秒后自动跳转到主页
    if (this.userAuth.isLogin) {
      setTimeout(() => {
        this.pathStack.replacePathByName("Layout", null, false)
      }, 3000)
    }
  }

  // 跳转到主页（只有登录后才能跳转）
  goToLayout() {
    if (this.userAuth.isLogin) {
      this.pathStack.replacePathByName("Layout", null, false)
    } else {
      // 未登录，跳转到登录页面
      this.pathStack.pushPathByName("Login", null, false)
    }
  }

  build() {
    NavDestination(){
      Stack({ alignContent:Alignment.Bottom }) {
        // 广告图片
        Image($r('app.media.ad2'))
          .width('100%')
          .height('100%')
          .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])

        // 跳过按钮（已登录显示在右上角）
        if (this.userAuth.isLogin) {
          Button('跳过')
            .width(60)
            .height(30)
            .fontSize(14)
            .fontColor(Color.White)
            .backgroundColor('rgba(0,0,0,0.4)')
            .borderRadius(15)
            .position({ top: 50, right: 20 })
            .zIndex(1)
            .onClick(() => {
              this.goToLayout()
            })
        }

        // 底部按钮区域（未登录显示）
        if (!this.userAuth.isLogin) {
          Column({ space: 12 }) {
            // 登录按钮
            Button('登录')
              .width('80%')
              .height(50)
              .fontSize(16)
              .fontColor(Color.White)
              .backgroundColor('#E85A88')
              .borderRadius(8)
              .onClick(() => {
                this.pathStack.pushPathByName("Login", null, false)
              })

            // 注册按钮
            Button('注册')
              .width('80%')
              .height(50)
              .fontSize(16)
              .fontColor('#E85A88')
              .backgroundColor(Color.Transparent)
              .border({ width: 1, color: '#E85A88', radius: 8 })
              .onClick(() => {
                this.pathStack.pushPathByName("Register", null, false)
              })
          }
          .width('100%')
          .padding({ bottom: 60, left: 20, right: 20 })
        }
      }
    }
    // .title('广告页')
    .onReady((context:NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}