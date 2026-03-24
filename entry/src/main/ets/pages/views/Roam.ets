import { SongDetail } from "../../models/SongDetailResponse"


//创建一个自定义的ui组件
@Component
export struct Roam {
  @Consume pathStack: NavPathStack=new NavPathStack()
  private musicData: SongDetail | null = null

  //构建ui函数
  build() {
    NavDestination() {

      //其子组件采用纵向布局
      Column() {
        // 顶部状态栏

        //子组件采用横向布局
        Row() {
          SymbolGlyph($r('sys.symbol.chevron_left'))
            .fontSize(25)
            .fontColor([Color.White])
            .onClick(() => {
              this.pathStack.pop()
            })
          Text('私人推荐')
            .fontSize(16)
            .fontColor(Color.White)
            .fontWeight(600)
          Blank()
          Row() {
            Text('免')
              .fontSize(10)
              .fontColor('#FF3B30')
            Text('29:15')
              .fontSize(10)
              .fontColor(Color.White)
          }
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
          .borderRadius(8)
          .backgroundColor('rgba(255,255,255,0.2)')
          SymbolGlyph($r('sys.symbol.arrow_clockwise'))
            .fontSize(18)
            .fontColor([Color.White])
        }
        .width('100%')
        .padding({ left: 15, right: 15, top: 15, bottom: 15 })

          // 黑胶唱片界面
          Column() {
            // 黑胶唱片
            Stack({ alignContent: Alignment.Center }) {
              // 黑胶唱片外圈
              Column()
                .width(280)
                .height(280)
                .borderRadius(140)
                .backgroundColor('#1a1a1a')
                .shadow({ radius: 20, color: 'rgba(0,0,0,0.5)', offsetX: 0, offsetY: 5 })

              // 唱片纹理
              Column()
                .width(260)
                .height(260)
                .borderRadius(130)
                .backgroundColor('#0a0a0a')

              // 专辑封面
              Image(this.musicData?.album?.blurPicUrl || $r('app.media.banner_02'))
                .width(180)
                .height(180)
                .borderRadius(90)
                .objectFit(ImageFit.Cover)
                .shadow({ radius: 15, color: 'rgba(0,0,0,0.3)', offsetX: 0, offsetY: 2 })

              // 唱臂
              Row() {
                Column()
                  .width(4)
                  .height(120)
                  .backgroundColor('#ffffff')
                  .borderRadius(2)
                  .rotate({ angle: -30, centerX: '50%', centerY: '0%' })
              }
              .position({ x: 140, y: 0 })
            }
            .width('100%')
            .margin({ top: 60, bottom: 40 })

            // 歌曲信息
            Column({ space: 8 }) {
              Row() {
                Text(this.musicData?.name || '一程山路')
                  .fontSize(22)
                  .fontWeight(600)
                  .fontColor(Color.White)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .layoutWeight(1)
                Text('VIP')
                  .fontSize(10)
                  .fontColor('#FF3B30')
                  .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                  .borderRadius(8)
                  .backgroundColor('rgba(255,255,255,0.15)')
              }
              .width('100%')

              Row() {
                Text(this.musicData?.artists[0]?.name || '毛不易')
                  .fontSize(14)
                  .fontColor('#888888')
                Blank()
                Text('关注')
                  .fontSize(12)
                  .fontColor('#888888')
                  .padding({ left: 12, right: 12, top: 4, bottom: 4 })
                  .borderRadius(15)
                  .backgroundColor('rgba(255,255,255,0.1)')
              }
              .width('100%')
            }
            .padding({ left: 20, right: 20 })
            .margin({ bottom: 20 })

            // 操作按钮
            Row({ space: 30 }) {
              Row() {
                SymbolGlyph($r('sys.symbol.heart'))
                  .fontSize(20)
                  .fontColor(['#888888'])
                Text('999w+')
                  .fontSize(10)
                  .fontColor('#888888')
              }
              .onClick(() => {})

              Row() {
                // SymbolGlyph($r('sys.symbol.bubble'))
                SymbolGlyph($r('sys.symbol.heart'))
                  .fontSize(20)
                  .fontColor(['#888888'])
                Text('20w+')
                  .fontSize(10)
                  .fontColor('#888888')
              }
              .onClick(() => {})
            }
            .margin({ bottom: 30 })

            // 进度条
            Column({ space: 8 }) {
              Progress({ value: 28 * 1000, total: 215 * 1000 })
                .width('90%')
                .color('#FF3B30')
                .backgroundColor('rgba(255,255,255,0.2)')

              Row() {
                Text('00:28')
                  .fontSize(11)
                  .fontColor('#666666')
                Blank()
                Text('标准音质')
                  .fontSize(10)
                  .fontColor('#666666')
                Blank()
                Text('03:35')
                  .fontSize(11)
                  .fontColor('#666666')
              }
              .width('90%')
            }
            .margin({ bottom: 20 })

            // 播放控制，使用系统内置的Symbol符号
            Row({ space: 40 }) {
              SymbolGlyph($r('sys.symbol.repeat'))
                .fontSize(20)
                .fontColor(['#888888'])
              SymbolGlyph($r('sys.symbol.backward_end_fill'))
                .fontSize(32)
                .fontColor([Color.White])
              SymbolGlyph($r('sys.symbol.play_fill'))
                .fontSize(40)
                .fontColor([Color.White])
              SymbolGlyph($r('sys.symbol.forward_end_fill'))
                .fontSize(32)
                .fontColor([Color.White])
              SymbolGlyph($r('sys.symbol.music_note_list'))
                .fontSize(20)
                .fontColor(['#888888'])
            }
            .margin({ bottom: 30 })
          }
          .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#1a1a1a')
    }
    .hideTitleBar(true)
    .hideToolBar(true)
    .onReady((context: NavDestinationContext) => {
      this.musicData = context.pathInfo.param as SongDetail
    })
  }

}
