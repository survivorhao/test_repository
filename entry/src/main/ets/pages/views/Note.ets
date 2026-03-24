//
//
// @Component
// export struct Note {
//   build(){
//     Column(){
//       Text('笔记视图')
//     }.width('100%')
//     .height('100%')
//   }
// }

@Component
export struct Note {

  @State refreshing: boolean = false
  @State selectedTab: number = 1 // 0: 关注, 1: 推荐

  @State noteData: NoteItem[] = [
    {
      id: 1,
      image: $r('app.media.banner_02'),
      title: '最喜欢的情侣博主离婚了🥺',
      musicText: '你知道天空有多蓝',
      author: '-YIBIANPINCOU',
      likes: 234,
      isLiked: false
    },
    {
      id: 2,
      image: $r('app.media.banner_02'),
      title: '当你在低谷的时候回想一下在顶峰的那一刻',
      musicText: '推开世界的门',
      author: 'Lilly_Zeng',
      likes: 1707,
      isLiked: false
    },
    {
      id: 3,
      image: $r('app.media.banner_02'),
      title: '幸福^请降临婧祎手心🥰',
      musicText: '让爱化彩',
      author: '你和回忆如何抹去',
      likes: 68,
      isLiked: false
    },
    {
      id: 4,
      image: $r('app.media.banner_02'),
      title: '附魔成功 叠buff了以后',
      musicText: 'The Blower\'s Daughter',
      author: '超型的大…',
      likes: 3431,
      isLiked: false
    },
    {
      id: 5,
      image: $r('app.media.banner_02'),
      title: '2026年我想要鞠婧祎万事顺遂',
      musicText: '九万字',
      author: '我不想要天真',
      likes: 15,
      isLiked: false
    },
    {
      id: 6,
      image: $r('app.media.banner_02'),
      title: '谁能拒绝这元气满满的小可爱😜',
      musicText: '九万字',
      author: '二硫碘化钾0223',
      likes: 20,
      isLiked: false
    }
  ]

  // 模拟刷新数据
  //async异步修饰的变量
  async onRefresh() {
    this.refreshing = true
    // 模拟网络请求延迟
    setTimeout(() => {
      // 随机打乱数据顺序
      this.noteData = this.noteData.sort(() => Math.random() - 0.5)
      this.refreshing = false
    }, 1500)
  }

  // 点赞功能
  toggleLike(item: NoteItem) {
    item.isLiked = !item.isLiked
    item.likes += item.isLiked ? 1 : -1
  }

  build() {
    Column() {
      // 顶部导航栏
      Stack({ alignContent: Alignment.Bottom }) {
        Row({ space: 15 }) {
          SymbolGlyph($r('sys.symbol.line_3_horizontal'))
            .fontSize(24)
            .fontColor([Color.Black])

          Text('关注')
            .fontSize(20)
            .fontColor(this.selectedTab === 0 ? '#000000' : '#6B6B6B')
            .fontWeight(this.selectedTab === 0 ? 600 : 400)
            .onClick(() => {
              this.selectedTab = 0
            })

          Text('推荐')
            .fontSize(20)
            .fontColor(this.selectedTab === 1 ? '#000000' : '#6B6B6B')
            .fontWeight(this.selectedTab === 1 ? 600 : 400)
            .onClick(() => {
              this.selectedTab = 1
            })

          SymbolGlyph($r('sys.symbol.magnifyingglass'))
            .fontSize(24)
            .fontColor([Color.Black])

          SymbolGlyph($r('sys.symbol.plus_circle_fill'))
            .fontSize(24)
            .fontColor(['#FF3B30'])
        }
        .width('100%')
        .height(56)
        .padding({ left: 15, right: 15 })
      }

      // 笔记内容列表 - 支持下拉刷新
      if(this.selectedTab == 1) {
        Refresh({ refreshing: $$this.refreshing }) {
          List({ space: 8 }) {
            ForEach(this.noteData, (item: NoteItem) => {
              ListItem() {
                this.NoteCard(item)
              }
            })
          }
          .width('100%')
          .height('100%')
          .padding({
            left: 8,
            right: 8,
            top: 8,
            bottom: 8
          })
          .backgroundColor('#FFFFFF')
        }
        .margin({bottom:60})
        .onRefreshing(() => {
          this.onRefresh()
        })
        .width('100%')
        .layoutWeight(1)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  // builder构建函数，用于封装可复用的UI逻辑
  @Builder
  NoteCard(item: NoteItem) {
    Column({ space: 6 }) {
      // 图片区域
      Image(item.image)
        .width('100%')
        .height(220)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
        .onClick(() => {
          // 点击图片查看详情
        })

      // 内容区域
      Column({ space: 4 }) {
        // 音乐标识和文字
        Row({ space: 4 }) {
          // SymbolGlyph($r('sys.symbol.music_quaver'))
          SymbolGlyph($r('sys.symbol.play_fill'))
            .fontSize(11)
            .fontColor(['#FF3B30'])

          Text(item.musicText)
            .fontSize(11)
            .fontColor('#666666')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
        }
        .width('100%')

        // 标题文字
        Text(item.title)
          .fontSize(14)
          .fontColor('#333333')
          .maxLines(2)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight(20)

        // 底部信息
        Row({ space: 6 }) {
          Text(item.author)
            .fontSize(12)
            .fontColor('#666666')
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)

          // 点赞信息
          Row({ space: 3 }) {
            SymbolGlyph($r('sys.symbol.heart'))
              .fontSize(11)
              .fontColor([item.isLiked ? '#FF3B30' : '#666666'])
              .onClick(() => {
                this.toggleLike(item)
              })

            Text(item.likes.toString())
              .fontSize(11)
              .fontColor('#666666')
          }
        }
        .width('100%')
      }
      .padding({ left: 8, right: 8, bottom: 8 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(8)
    .shadow({
      radius: 3,
      color: 'rgba(0,0,0,0.06)',
      offsetX: 0,
      offsetY: 1
    })
  }
}

// 笔记数据模型
interface NoteItem {
  id: number
  image: Resource
  title: string
  musicText: string
  author: string
  likes: number
  isLiked: boolean
}
