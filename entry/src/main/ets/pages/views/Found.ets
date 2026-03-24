//
//
// @Component
// export struct Found {
//   build(){
//     Column(){
//       Text('发现视图')
//     }.width('100%')
//     .height('100%')
//   }
// }
// 定义歌曲信息接口
interface SongInfo {
  rank: number
  song: string
  artist: string
  trend?: string
  tag?: string
}

@Component
export struct Found {
  @State isRefreshing: boolean = false
  @State selectedTab: string = '音乐'
  @State selectedTab1: string = '排行榜'
  @State index: number = 0
  @Consume pathStack: NavPathStack = new NavPathStack()

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        SymbolGlyph($r('sys.symbol.list_bullet'))
          .fontSize(24)
          .fontColor([Color.Black])
        Text('音乐')
          .fontSize(20)
          .fontWeight(600)
          .fontColor(this.selectedTab === '音乐' ? '#000000' : '#ff8c8585')
          .onClick(() => {
            this.selectedTab = '音乐'
            this.index=0
          })
          // .margin({ right: 15 })

        Text('播客')
          .fontSize(20)
          .fontColor(this.selectedTab === '播客' ? '#000000' : '#ff8c8585')
          .onClick(() => {
            this.selectedTab = '播客'
            this.index=1
          })
          // .margin({ right: 20 })

        Text('听书')
          .fontSize(20)
          .fontColor(this.selectedTab === '听书' ? '#000000' : '#ff8c8585')
          .onClick(() => {
            this.selectedTab = '听书'
            this.index=2
          })

        SymbolGlyph($r('sys.symbol.magnifyingglass'))
          .fontSize(24)
          .fontColor([Color.Black])
      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 15, bottom: 15 })
      .justifyContent(FlexAlign.SpaceAround)

      // 分割线
      Divider()
        .color('#E0E0E0')

      // 二级导航栏
      if(this.index == 0) {
        Row({ space: 10 }) {
          SymbolGlyph($r('sys.symbol.chevron_left'))
            .fontSize(20)
            .fontColor(['#000000'])

          Text('排行榜')
            .fontSize(14)
            .fontWeight(600)
            .fontColor(this.selectedTab1 === '排行榜' ? '#000000' : '#ff8c8585')
            .margin({ left: 15, right: 15 })
            .onClick(() => {
              this.selectedTab1 = '排行榜'
            })

          Text('歌单')
            .fontSize(14)
            .fontColor(this.selectedTab1 === '歌单' ? '#000000' : '#ff8c8585')
            .margin({ right: 15 })
            .onClick(() => {
              this.selectedTab1 = '歌单'
            })

          Text('原创')
            .fontSize(14)
            .fontColor(this.selectedTab1 === '原创' ? '#000000' : '#ff8c8585')
            .margin({ right: 15 })
            .onClick(() => {
              this.selectedTab1 = '原创'
            })

          Text('VIP...')
            .fontSize(14)
            .fontColor(this.selectedTab1 === 'VIP' ? '#000000' : '#ff8c8585')
            .margin({ right: 15 })
            .onClick(() => {
              this.selectedTab1 = 'VIP'
            })

          SymbolGlyph($r('sys.symbol.chevron_down'))
            .fontSize(20)
            .fontColor(['#6B6B6B'])
        }
        .width('100%')
        .padding({
          left: 15,
          right: 15,
          top: 10,
          bottom: 10
        })
        .justifyContent(FlexAlign.SpaceAround)
      }

      // 列表内容
      if (this.selectedTab === '音乐' && this.selectedTab1 === '排行榜') {
        this.RankListContent()
      } else if (this.selectedTab1 === '歌单') {
        this.PlaylistContent()
      } else {
        this.EmptyContent()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  RankListContent() {
    List({ space: 0 }) {
      // 榜单推荐标题
      ListItem() {
        Row() {
          Text('榜单推荐')
            .fontSize(16)
            .fontWeight(600)
            .fontColor('#000000')
        }
        .width('100%')
        .padding({ left: 20, top: 20, bottom: 15 })
      }

      // 榜单推荐卡片
      ListItem() {
        List({ space: 15 }) {
          // 中文说唱榜
          ListItem() {
            Column() {
              Stack() {
                // 渐变背景
                Column()
                  .width('100%')
                  .height('100%')
                  .linearGradient({
                    angle: 180,
                    colors: [['#FF6B6B', 0.0], ['#FF8E53', 1.0]]
                  })
                  .borderRadius(12)

                Column({ space: 8 }) {
                  Text('中文说唱榜')
                    .fontSize(14)
                    .fontWeight(600)
                    .fontColor(Color.White)

                  Image($r('sys.symbol.play_circle'))
                    .width(24)
                    .height(24)
                    .fillColor(Color.White)
                }
                .justifyContent(FlexAlign.Center)
              }
              .width(130)
              .height(140)
              .borderRadius(12)
            }
          }

          // 潮流风向榜
          ListItem() {
            Column() {
              Stack() {
                Column()
                  .width('100%')
                  .height('100%')
                  .linearGradient({
                    angle: 180,
                    colors: [['#FF416C', 0.0], ['#FF4B2B', 1.0]]
                  })
                  .borderRadius(12)

                Column({ space: 8 }) {
                  Text('潮流风向榜')
                    .fontSize(14)
                    .fontWeight(600)
                    .fontColor(Color.White)

                  Image($r('sys.symbol.play_circle'))
                    .width(24)
                    .height(24)
                    .fillColor(Color.White)
                }
                .justifyContent(FlexAlign.Center)
              }
              .width(130)
              .height(140)
              .borderRadius(12)
            }
          }
          // .layoutWeight(1)

          // 国风榜
          ListItem() {
            Column() {
              Stack() {
                Column()
                  .width('100%')
                  .height('100%')
                  .linearGradient({
                    angle: 180,
                    colors: [['#F7971E', 0.0], ['#FFD200', 1.0]]
                  })
                  .borderRadius(12)

                Column({ space: 8 }) {
                  Text('国风榜')
                    .fontSize(14)
                    .fontWeight(600)
                    .fontColor(Color.White)

                  Image($r('sys.symbol.play_circle'))
                    .width(24)
                    .height(24)
                    .fillColor(Color.White)
                }
                .justifyContent(FlexAlign.Center)
              }
              .width(130)
              .height(140)
              .borderRadius(12)
            }
          }

          ListItem() {
            Column() {
              Stack() {
                Column()
                  .width('100%')
                  .height('100%')
                  .linearGradient({
                    angle: 180,
                    colors: [['#ff022dff', 0.0], ['#ff02beff', 1.0]]
                  })
                  .borderRadius(12)

                Column({ space: 8 }) {
                  Text('热搜榜')
                    .fontSize(14)
                    .fontWeight(600)
                    .fontColor(Color.White)

                  Image($r('sys.symbol.play_circle'))
                    .width(24)
                    .height(24)
                    .fillColor(Color.White)
                }
                .justifyContent(FlexAlign.Center)
              }
              .width(130)
              .height(140)
              .borderRadius(12)
            }
          }
          ListItem(){
            Column(){
              SymbolGlyph($r('sys.symbol.dot_grid_2x2'))
                .fontSize(25)
            }.width(70)
            .height(140)
            .justifyContent(FlexAlign.Center)
          }
        }
        .listDirection(Axis.Horizontal)
        // .width('100%')
        .scrollBar(BarState.Off)
        .padding({ left: 20, right: 20, bottom: 25 })
      }

      // 官方榜标题
      ListItem() {
        Row() {
          Row() {
            Text('官方榜')
              .fontSize(16)
              .fontWeight(600)
              .fontColor('#000000')
          }
        }
        .width('100%')
        .padding({ left: 20, top: 15, bottom: 15 })
      }

      // 飙升榜
      ListItem() {
        this.RankCard(
          '飙升榜',
          '刚刚更新',
          [
            { rank: 1, song: '故意没接', artist: 'Double SR', trend: 'up' },
            { rank: 2, song: '海屿你', artist: '马也_Crabbit', trend: 'up' },
            { rank: 3, song: '可我在十六岁遇到了你', artist: 'Fir…', trend: 'same' }
          ]
        )
      }

      // 新歌榜
      ListItem() {
        this.RankCard(
          '新歌榜',
          '刚刚更新',
          [
            { rank: 1, song: '第三个吻痕', artist: '何水水', trend: 'up' },
            { rank: 2, song: '山歌王', artist: '功夫胖KUNGFU-P…', trend: 'up' },
            { rank: 3, song: '故意没接', artist: 'Double SR', trend: 'up' }
          ]
        )
      }

      // 热歌榜
      ListItem() {
        this.RankCard(
          '热歌榜',
          '刚刚更新',
          [
            { rank: 1, song: '海屿你', artist: '马也_Crabbit', trend: 'same' },
            { rank: 2, song: '雨过后的风景', artist: 'Dizzy Dizzo…', trend: 'up' },
            { rank: 3, song: '我本将心向明月', artist: '王朝1982…', trend: 'up' }
          ]
        )
      }

      // 原创榜
      ListItem() {
        this.RankCard(
          '原创榜',
          '每周四更新',
          [
            { rank: 1, song: '峨眉', artist: '刘森', tag: '新' },
            { rank: 2, song: '北夜', artist: 'Vansdaddy', tag: '新' },
            { rank: 3, song: '没出息', artist: '银河快递', tag: '新' }
          ]
        )
      }

      // 畅销榜
      ListItem() {
        this.RankCard(
          '畅销榜',
          '每半小时更新',
          [
            { rank: 1, song: 'Mono (Feat. skaiwater)', artist: '', trend: 'up' },
            { rank: 2, song: '希忘Hope', artist: '', trend: 'up' },
            { rank: 3, song: '量变临界点', artist: '', trend: 'down' }
          ]
        )
      }
    }
    .width('100%')
    .margin({bottom:60})
    .layoutWeight(1)
    .scrollBar(BarState.Off)
  }

  @Builder
  RankCard(title: string, updateTime: string, songs: SongInfo[]) {
    Row() {
      // 榜单封面
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(600)
          .fontColor('#000000')
          .width('100%')
          .margin({bottom:6})
        Image($r('app.media.shi_li'))
          .width(100)
          .height(100)
          .borderRadius(8)
          .objectFit(ImageFit.Cover)
      }
      .justifyContent(FlexAlign.Center)
      .borderRadius(8)
      .margin({ right: 15 })
      .width(100)

      // 歌曲列表
      List() {
        ListItem(){
          Column({ space: 12 }) {
            // 歌曲列表
            ForEach(songs, (item: SongInfo, index?: number) => {
              Row() {
                Text(item.rank.toString())
                  .fontSize(16)
                  .fontColor('#FF3B30')
                  .width(20)

                Column({ space: 4 }) {
                  Row() {
                    Text(item.song + ' ')
                      .fontSize(20)
                      .fontColor('#000000')
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })

                    if (item.artist) {
                      Text(' - ' + item.artist)
                        .fontSize(16)
                        .fontColor('#6B6B6B')
                    }
                  }
                  .onClick(() => {
                    if (item.song && item.song.length > 0) {
                      if (this.pathStack) {
                        this.pathStack.pushPath({
                          name: "SearchResultPage",
                          param: item.song
                        })
                      }
                    }
                  })
                  .width('100%')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
                .margin({ left: 12 })
              }
              .justifyContent(FlexAlign.Center)
              .width('100%')
              .padding({ right: 10 })
            })
          }
          .padding({ right: 10, top: 10 })
        }

        ListItem(){}.margin({right:100})
      }
      .listDirection(Axis.Horizontal) // 设置为水平方向，实现左右滚动
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 5, bottom: 15 })
    .backgroundColor('#FFFFFF')
  }

  @Builder
  PlaylistContent() {
    Column() {
      Text('歌单内容开发中...')
        .fontSize(16)
        .fontColor('#6B6B6B')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  EmptyContent() {
    Column() {
      Text('功能开发中...')
        .fontSize(16)
        .fontColor('#6B6B6B')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }
}