import { AppStorageV2 } from '@kit.ArkUI';
import { UserAuth } from '../models/userAuth';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  // pathStack: NavPathStack = new NavPathStack()
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navstack', () => new NavPathStack())!
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!

  build() {
    Navigation(this.pathStack){
    }.onAppear(async () => {
      // 初始化登录状态
      const context = getContext(this) as common.UIAbilityContext
      await this.userAuth.init(context)
      // 跳转到启动页
      this.pathStack.pushPathByName("Start", null, false)
    })
    .hideNavBar(true) // 不会把当前Index页面放进控制页面对象里面
  }
}