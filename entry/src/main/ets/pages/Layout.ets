import { Find } from "./Find"
import { Mind } from "./Mine"
import { Moment } from "./Moment"
import { Recommend } from "./Recommend"
import { UserAuth } from '../models/userAuth'
import { AppStorageV2 } from '@kit.ArkUI'
import { PlayerStatusBar } from '../components/PlayerStatusBar'
import { GlobalMusic } from '../models/globalMusic'

interface TabClass {
  text: string
  icon: ResourceStr
}

// 跳转页面入口函数
@Builder
export function LayoutBuilder() {
  Layout()
}

@ComponentV2
struct Layout {
  @Local currentIndex:number = 0
  // 控制跳转的对象
  pathStack: NavPathStack = new NavPathStack()
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!
  controller: TabsController = new TabsController()
  tabData: TabClass[] = [
    {text: '推荐', icon: $r('app.media.ic_recommend')},
    {text: '发现', icon: $r('app.media.ic_find')},
    {text: '动态', icon: $r('app.media.ic_moment')},
    {text: '我的', icon: $r('app.media.ic_mine')}
  ]

  @Builder
  tabBuilder (item:TabClass,index:number) {
    Column({space:5}) {
      Image(item.icon)
        .width(24)
        .fillColor(this.currentIndex == index? '#E85A88':'#63AAAA')
      Text(item.text)
        .fontSize(14)
        .fontColor(this.currentIndex == index? '#E85A88':'#63AAAA')
    }
  }

  aboutToAppear() {
    // 检查登录状态，如果未登录则返回启动页
    if (!this.userAuth.isLogin) {
      this.pathStack.replacePathByName("Start", null, false)
    }
  }

  build() {
    NavDestination(){
      Column() {
        Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
          ForEach(this.tabData,(item:TabClass,index:number) => {
            TabContent() {
              if(this.currentIndex == 0) {
                Recommend()
              }
              else if(this.currentIndex == 1) {
                Find()
              }
              else if(this.currentIndex == 2) {
                Moment()
              }
              else if(this.currentIndex == 3) {
                Mind({ pathStack: this.pathStack })
              }
            }
            // .tabBar(this.tabBuilder(item,index)) //自定义导航栏 -> @Builder
            .backgroundColor('#131215')
            .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])
          })
        }
        .barHeight(0)
        .backgroundColor('3B3F42')
        .layoutWeight(1)
        .onChange((index:number) => {
          this.currentIndex = index
        })
        .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])

        // 底部播放控制栏
        PlayerStatusBar({
          onOpenPlay: () => {
            this.pathStack.pushPathByName("Play", null, false)
          },
          onOpenList: () => {
            const gm = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!
            gm.openListPanel = true
            this.pathStack.pushPathByName("Play", null, false)
          }
        })

        // 自定义底部导航栏
        Row() {
          ForEach(this.tabData, (item: TabClass, index: number) => {
            Column() {
              this.tabBuilder(item, index)
            }
            .layoutWeight(1)
            .height('100%')
            .justifyContent(FlexAlign.Center)
            .onClick(() => {
              this.currentIndex = index
              this.controller.changeIndex(index)
            })
          })
        }
        .width('100%')
        .height(60)
        .backgroundColor('#131215')
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#131215')
      .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    // .title('布局页')
    .onReady((context:NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}
