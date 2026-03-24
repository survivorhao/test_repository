
@Builder
export function SearchPageBuilder(){
  SearchPage()
}


// @Preview
@Component
struct SearchPage {
  @State keyword:string='抖音热歌'
  // private pathStack:NavPathStack | undefined
  private pathStack:NavPathStack=new NavPathStack()

  toSearchResultPage(){
    if(this.keyword && this.keyword.length>0){
      if(this.pathStack){
        this.pathStack.pushPath({
          name:"SearchResultPage",
          param:this.keyword
        })
      }
    }
  }

  build(){
    NavDestination(){
      Column(){
        //定义标题栏
        Row({space:10}){
          SymbolGlyph($r('sys.symbol.chevron_left'))
            .fontSize(25)
            .width(25)
            .onClick(() => {
              if (this.pathStack) {
                this.pathStack.pop()
              }
            })
          Search({value:$$this.keyword,placeholder:'歌曲/专辑/歌手'}).width('80%').margin(0)
            .onSubmit(()=>{
              this.toSearchResultPage()
            })
          Text('搜索').fontSize(16)
            .onClick(()=>{
              this.toSearchResultPage()
            })
        }
        .width('99%')
        .justifyContent(FlexAlign.SpaceAround)

        Row() {
          this.FunctionItem('歌手', ($r('app.media.ge_shou')))
          this.FunctionItem('曲风', ($r('app.media.qu_feng')))
          this.FunctionItem('专区', ($r('app.media.zhuan_qu')))
          this.FunctionItem('识曲', ($r('app.media.shi_qu')))
        }
        .width('100%')
        .height(80)
        .justifyContent(FlexAlign.SpaceAround)

        List() {
          ListItem() {
            Column() {
              Row() {
                Text('猜你喜欢')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)

                Blank()
                Image($r('app.media.fresh'))
                  .width(20)
                  .height(20)
                  .fillColor('#999999')
                  .onClick(() => {
                  })
              }
              .width('100%')
              .padding({ left: 16, right: 16, top: 12, bottom: 8 })

              // 推荐标签
              Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
                this.GuessTag('莫扎特钢琴曲')
                this.GuessTag('梦中的婚礼')
                this.GuessTag('轻音乐')
                this.GuessTag('古典乐')
                this.GuessTag('爵士乐')
                this.GuessTag('流行歌曲')
              }
              .padding({ left: 16, right: 16, bottom: 12 })
            }
            .width('100%')
            // .backgroundColor('#FFFFFF')
            // .borderRadius(8)
            .margin({ top: 8 })
          }

          Test({pathStack: this.pathStack})

        }

      }.width('100%')
      .height('100%')
      .padding(10)
    }
    .hideTitleBar(true)   //隐藏系统根据栏
    .hideToolBar(true)    //隐藏标题栏
    .hideBackButton(true)   //隐藏导航返回按钮
    .backgroundColor('#f1f3f5')
    .onReady(context=>{
      this.pathStack = context.pathStack
    })
  }

  @Builder
  FunctionItem(text: string, icon: Resource) {
    Column() {
      Image(icon)
        .width(27)
        .height(27)
        .fillColor('#333333')
        .margin({ bottom: 4 })

      Text(text)
        .fontSize(15)
        .fontColor('#333333')
    }
    .padding({ top: 8, bottom: 8 })
    .onClick(() => {})
  }

  @Builder
  GuessTag(text: string) {
    Text(text)
      .fontSize(14)
      .fontColor('#666666')
      .padding({ right: 16, top: 8, bottom: 8 })
      .borderRadius(16)
      // .backgroundColor('#F5F5F5')
      // .margin({ right: 12, bottom: 8 })
      .onClick(() => {
        this.keyword = text
        this.toSearchResultPage()
      })
  }
}

@Component
export struct Test{
  // 热搜榜数据
  @State hotSearchList: string[] = ['海屿你','小半','可我在十六岁遇到了你','左手指月','咏春','失眠','雨过后的风景','雨爱','我本将心向明月','逐玉','于是','别怕变老','精卫','我们俩','苦茶子','一半一半','岁月神谕','童话','其实','一样的月光']
  // 热歌榜数据
  @State hotSongList: string[] = ['海屿你','雨过后的风景','如果呢','一半一半','恋人','苦茶子', '小半','于是','失眠','Dear D (亲爱的告诉你)','唯一','罗生门（Follow）','嗜好','别怕变老', '你','两难','我本将心向明月','还是会想你','晚安','我怀念的']
  // 飙升榜数据
  @State risingList: string[] = ['海屿你','故意没','Anybod','NO BA','我本将','可我在','死疙瘩','马来西','初遇街','Alive','My lov','演员','一样的','为你揭','Lonely','樱花海','X-COC','HEAVE','春','The Ot']
  private pathStack?: NavPathStack

  build(){
    List() {
      // 热搜榜
      ListItem() {
        Column() {
          this.SongListHeader('热搜榜')
          this.SongList(this.hotSearchList)
        }
        .width('70%')
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .margin({ right: 8 })
      }

      // 热歌榜
      ListItem() {
        Column() {
          this.SongListHeader('热歌榜')
          this.SongList(this.hotSongList)
        }
        .width('70%')
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
        .margin({ right: 8 })
      }

      // 飙升榜
      ListItem() {
        Column() {
          this.SongListHeader('飙升榜')
          this.SongList(this.risingList)
        }
        .width('70%')
        .backgroundColor('#FFFFFF')
        .borderRadius(8)
      }
    }
    .width('100%')
    // .height(320)
    .listDirection(Axis.Horizontal) // 设置为水平方向，实现左右滚动
    // .scrollBar(BarState.Off)
    // .edgeEffect(EdgeEffect.Spring)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .margin({ bottom: 100 })
  }
  // 歌单头部组件
  @Builder
  SongListHeader(title: string) {
    Row() {
      Text(title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .padding({ left: 12, right: 12, top: 12, bottom: 8 })
  }

  // 歌单列表组件
  @Builder
  SongList(list: string []) {
    ForEach(list, (item: string, index: number) => {
      Row() {
        Text(`${index + 1}`)
          .fontSize(14)
          .fontColor('#999999')
          .width(24)
          .textAlign(TextAlign.Center)

        Text(item)
          .fontSize(14)
          .fontColor('#333333')
          .layoutWeight(1)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ left: 8 })
      }
      .width('100%')
      .padding({ left: 12, right: 12, top: 8, bottom: 8 })
      .onClick(() => {
        if(this.pathStack){
          this.pathStack.pushPath({
            name:"SearchResultPage",
            param:item
          })
        }
      })
    })
  }
}
