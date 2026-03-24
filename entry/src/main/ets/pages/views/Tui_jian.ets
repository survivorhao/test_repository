import { WidthBreakpointType } from "../../untils/WidthBreakpointType"


@Component
export struct Tui_jian {

  // @StorageProp('widthBrakPoint') currentWidthBreakPoint:WidthBreakpoint=WidthBreakpoint.WIDTH_SM
  // @State bannerArr:Resource[]=[
  //   $r('app.media.banner_01'),
  //   $r('app.media.banner_02'),
  //   $r('app.media.banner_03'),
  //   $r('app.media.banner_04'),
  //   $r('app.media.banner_05'),
  //   $r('app.media.banner_06')
  // ]
  // @State ge_dan:Resource[]=[
  //   $r('app.media.1'),
  //   $r('app.media.2'),
  //   $r('app.media.3'),
  //   $r('app.media.4'),
  //   $r('app.media.5'),
  //   $r('app.media.6')
  // ]
  // @State ge_qu:Resource[]=[
  //   $r('app.media.1_1'),
  //   $r('app.media.1_2'),
  //   $r('app.media.1_3'),
  //   $r('app.media.1_4'),
  //   $r('app.media.1_5'),
  //   $r('app.media.1_6')
  // ]
  // @State songTitles:string[]=['念旧','幻听','过客','后来','成全','十年']
  // @State artistNames:string[]=['关喆','许嵩','周思涵','刘若英','林宥嘉','陈奕迅']
  // @State hasVIP:(boolean|null)[]=[null,true,true,null,null,true]
  @Consume pathStack:NavPathStack     //获取主页面Index中Navigation页面栈对象

  build(){
    Column(){
      // Text('推荐视图')
      GridRow({
        columns:{xs:4,sm:4,md:12,lg:12,xl:12},
        direction:GridRowDirection.Row,
        gutter:10,
        breakpoints:{
          value:['320vp','600vp','830vp','1440vp','1600vp'],
          reference:BreakpointsReference.WindowSize
        }
      }){
        GridCol({
          span:{xs:4,sm:4,md:6,lg:6,xl:7}
        }){
          Row(){
            Text('推荐')
            Text('音乐')
            Text('博客')
            Text('听书')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
          .padding({top:20})
        }
        GridCol({
          span:{xs:4,sm:4,md:6,lg:7,xl:7}
        }){
          Row(){
            Search().onClick(()=>{
              this.pathStack.pushPath({
                name:'SearchPage'
              })
            })
          }
          .width('100%')
          .padding({right:15})
        }
      }

      Test()
      // List(){
      //   ListItem(){
      //     Swiper() {
      //       ForEach(this.bannerArr, (item: Resource, index: number) => {
      //         Image(item).width('96%').borderRadius(10)
      //           .margin({ left: new WidthBreakpointType(0, 0, 5, 5, 5).getValue(this.currentWidthBreakPoint) })
      //           .onClick(() => {
      //             console.log('123')
      //           })
      //       })
      //     }
      //     .autoPlay(true)
      //     .displayCount(new WidthBreakpointType(1, 1, 2, 3, 3).getValue(this.currentWidthBreakPoint))
      //     .indicator(new WidthBreakpointType(true, true, false, false, false).getValue(this.currentWidthBreakPoint))
      //   }
      //
      //   ListItem(){
      //     Row() {
      //       Text('推荐歌单')
      //         .fontWeight(350)
      //         .fontSize(25)
      //         .margin({left:7})
      //       Image($r('app.media.arrow_right')).width(15).height(13)
      //         .objectFit(ImageFit.Cover)
      //     }
      //     .width('95%')
      //     .margin({ top: 40, bottom: 10 })
      //     .onClick(() => {
      //
      //     })
      //   }
      //
      //   ListItem(){
      //     Swiper() {
      //       ForEach(this.ge_dan, (item: Resource, index: number) => {
      //         Image(item).width('96%').borderRadius(10)
      //           .margin({ left: new WidthBreakpointType(0, 2, 5, 5, 5).getValue(this.currentWidthBreakPoint) })
      //           .onClick(() => {
      //             console.log('点击了歌单')
      //           })
      //       })
      //     }
      //     .duration(2000)
      //     .autoPlay(true)
      //     .displayCount(new WidthBreakpointType(1, 2, 2, 3, 4).getValue(this.currentWidthBreakPoint))
      //     .indicator(new WidthBreakpointType(true, true, false, false, false).getValue(this.currentWidthBreakPoint))
      //   }
      //
      //   ListItem(){
      //     Text('推荐歌曲')
      //       .fontWeight(350)
      //       .fontSize(25)
      //       .width('95%')
      //       .padding({left:7,top:50,bottom:15})
      //   }
      //
      //   ForEach(this.ge_qu,(item:Resource,index:number)=>{
      //     ListItem(){
      //       Row(){
      //         Image(item)
      //           .width(70)
      //           .height(70)
      //           .borderRadius(5)
      //           .objectFit(ImageFit.Cover)
      //
      //         Column(){
      //           Text(this.songTitles[index])
      //             .fontSize(20)
      //             .fontWeight(FontWeight.Medium)
      //           Row(){
      //             if(this.hasVIP[index]){
      //               Text('VIP')
      //                 .fontSize(13)
      //                 .padding({left:3,right:3,top:2,bottom:2})
      //                 .margin({right:7})
      //                 .borderRadius(3)
      //                 .fontColor(Color.Red)
      //                 .border({width:1,color:Color.Red})
      //             }
      //             Text(this.artistNames[index])
      //               .fontSize(16)
      //               .fontColor('#666')
      //           }
      //           .margin({top:5})
      //         }
      //         .alignItems(HorizontalAlign.Start)
      //         .margin({left:15})
      //
      //         Blank()
      //         SymbolGlyph($r('sys.symbol.play_fill'))
      //           .fontSize(30)
      //           .fontColor(['#ffbcb9b9'])
      //           .margin({right:7})
      //       }
      //       .width('100%')
      //       .padding({left:10,right:10,top:10,bottom:10})
      //       .onClick(()=>{
      //         console.log('点击了歌曲')
      //       })
      //     }
      //   })
      // }
    }.width('100%')
    .height('100%')
  }
}

@Component
export struct Test {
  // 控制下拉刷新状态
  @State isRefreshing: boolean = false
  // 控制上拉加载状态
  @State isLoadingMore: boolean = false
  // 提示文字
  @State promptText: string = "下拉刷新"
  @StorageProp('widthBrakPoint') currentWidthBreakPoint: WidthBreakpoint = WidthBreakpoint.WIDTH_SM
  @State bannerArr: Resource[] = [
    $r('app.media.banner_01'),
    $r('app.media.banner_02'),
    $r('app.media.banner_03'),
    $r('app.media.banner_04'),
    $r('app.media.banner_05'),
    $r('app.media.banner_06')
  ]
  @State ge_dan: Resource[] = [
    $r('app.media.1'),
    $r('app.media.2'),
    $r('app.media.3'),
    $r('app.media.4'),
    $r('app.media.5'),
    $r('app.media.6')
  ]
  @State ge_qu: Resource[] = [
    $r('app.media.1_1'),
    $r('app.media.1_2'),
    $r('app.media.1_3'),
    $r('app.media.1_4'),
    $r('app.media.1_5'),
    $r('app.media.1_6')
  ]
  @State songTitles: string[] = ['念旧', '幻听', '过客', '后来', '成全', '十年']
  @State artistNames: string[] = ['关喆', '许嵩', '周思涵', '刘若英', '林宥嘉', '陈奕迅']
  @State hasVIP: (boolean | null)[] = [null, true, true, null, null, true]
  @Consume pathStack: NavPathStack = new NavPathStack() //获取主页面Index中Navigation页面栈对象

  build() {
    Refresh({
      //组件当前是否处于刷新中状态；默认值为false，表示未处于刷新中状态。
      refreshing: $$this.isRefreshing,
      promptText: this.promptText
    }) {
      List() {
        ListItem() {
          Swiper() {
            ForEach(this.bannerArr, (item: Resource, index: number) => {
              Image(item).width('96%').borderRadius(10)
                .margin({ left: new WidthBreakpointType(0, 0, 5, 5, 5).getValue(this.currentWidthBreakPoint) })
                .onClick(() => {
                  console.log('123')
                })
            })
          }
          .autoPlay(true)
          .displayCount(new WidthBreakpointType(1, 1, 2, 3, 3).getValue(this.currentWidthBreakPoint))
          .indicator(new WidthBreakpointType(true, true, false, false, false).getValue(this.currentWidthBreakPoint))
        }

        ListItem() {
          Row() {
            Text('推荐歌单')
              .fontWeight(350)
              .fontSize(25)
              .margin({ left: 7 })
            Image($r('app.media.arrow_right')).width(15).height(13)
              .objectFit(ImageFit.Cover)
          }
          .width('95%')
          .margin({ top: 40, bottom: 10 })
          .onClick(() => {

          })
        }

        ListItem() {
          Swiper() {
            ForEach(this.ge_dan, (item: Resource, index: number) => {
              Image(item).width('96%').borderRadius(10)
                .margin({ left: new WidthBreakpointType(0, 2, 5, 5, 5).getValue(this.currentWidthBreakPoint) })
                .onClick(() => {
                  console.log('点击了歌单')
                })
            })
          }
          .duration(2000)
          .autoPlay(true)
          .displayCount(new WidthBreakpointType(1, 2, 2, 3, 4).getValue(this.currentWidthBreakPoint))
          .indicator(new WidthBreakpointType(true, true, false, false, false).getValue(this.currentWidthBreakPoint))
        }

        ListItem() {
          Text('推荐歌曲')
            .fontWeight(350)
            .fontSize(25)
            .width('95%')
            .padding({ left: 7, top: 50, bottom: 15 })
        }

        ForEach(this.ge_qu, (item: Resource, index: number) => {
          ListItem() {
            Row() {
              Image(item)
                .width(70)
                .height(70)
                .borderRadius(5)
                .objectFit(ImageFit.Cover)

              Column() {
                Text(this.songTitles[index])
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                Row() {
                  if (this.hasVIP[index]) {
                    Text('VIP')
                      .fontSize(13)
                      .padding({
                        left: 3,
                        right: 3,
                        top: 2,
                        bottom: 2
                      })
                      .margin({ right: 7 })
                      .borderRadius(3)
                      .fontColor(Color.Red)
                      .border({ width: 1, color: Color.Red })
                  }
                  Text(this.artistNames[index])
                    .fontSize(16)
                    .fontColor('#666')
                }
                .margin({ top: 5 })
              }
              .alignItems(HorizontalAlign.Start)
              .margin({ left: 15 })

              Blank()
              SymbolGlyph($r('sys.symbol.play_fill'))
                .fontSize(30)
                .fontColor(['#ffbcb9b9'])
                .margin({ right: 7 })
            }
            .width('100%')
            .padding({
              left: 10,
              right: 10,
              top: 10,
              bottom: 10
            })
            .onClick(() => {
              if (this.songTitles[index] && this.songTitles[index].length > 0) {
                if (this.pathStack) {
                  this.pathStack.pushPath({
                    name: "SearchResultPage",
                    param: this.songTitles[index]
                  })
                }
              }
            })
          }
        })
      }
      .margin({ bottom: 150 })
    }
    .onStateChange((refreshStatus: RefreshStatus) => {
      // 当前刷新状态变更时，触发回调
      if (refreshStatus === RefreshStatus.Drag) {
        this.promptText = "释放立即刷新"
      } else if (refreshStatus === RefreshStatus.Refresh) {
        this.promptText = "正在刷新..."
      } else if (refreshStatus === RefreshStatus.Done) {
        this.promptText = "刷新完成"
      } else {
        this.promptText = "下拉刷新"
      }
    })
    .onRefreshing(() => {
      // 进入刷新状态时触发回调
      setTimeout(() => {
        this.isRefreshing = false
      }, 2000)
    })
    .refreshOffset(64) //下拉偏移量
    .pullToRefresh(true) //当下拉距离超过refreshOffset时是否能触发刷新
  }
}