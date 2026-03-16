import { AppStorageV2 } from '@kit.ArkUI';

@Builder
export function SettingsBuilder() {
  Settings()
}

@ComponentV2
struct Settings {
  pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Column() {
        // 标题栏
        Row() {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .onClick(() => {
              this.pathStack.pop()
            })
          Text('设置')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .margin({ left: 16 })
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#131215')

        List() {
          ListItem() {
            Row() {
              Text('个人资料')
                .fontSize(16)
                .fontColor(Color.White)
              Blank()
              Image($r('app.media.ic_more'))
                .width(20)
                .height(20)
                .fillColor('#666666')
            }
            .width('100%')
            .padding(16)
          }

          ListItem() {
            Row() {
              Text('播放设置')
                .fontSize(16)
                .fontColor(Color.White)
              Blank()
              Image($r('app.media.ic_more'))
                .width(20)
                .height(20)
                .fillColor('#666666')
            }
            .width('100%')
            .padding(16)
          }

          ListItem() {
            Row() {
              Text('音质选择')
                .fontSize(16)
                .fontColor(Color.White)
              Blank()
              Text('极高')
                .fontSize(14)
                .fontColor('#666666')
                .margin({ right: 8 })
              Image($r('app.media.ic_more'))
                .width(20)
                .height(20)
                .fillColor('#666666')
            }
            .width('100%')
            .padding(16)
          }

          ListItem() {
            Row() {
              Text('关于 WHU云音乐')
                .fontSize(16)
                .fontColor(Color.White)
              Blank()
              Image($r('app.media.ic_more'))
                .width(20)
                .height(20)
                .fillColor('#666666')
            }
            .width('100%')
            .padding(16)
          }
        }
        .divider({ strokeWidth: 1, color: '#222222', startMargin: 16, endMargin: 16 })
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#131215')
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}
