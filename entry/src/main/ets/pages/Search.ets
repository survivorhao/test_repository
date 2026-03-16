import { SongItemType } from "../models/music"
import { AppStorageV2, promptAction } from "@kit.ArkUI"
import { apiService } from "../utils/apiService"
import { playerManager } from "../utils/AvPlayerManager"
import { GlobalMusic } from "../models/globalMusic"

// 跳转页面入口函数
@Builder
export function SearchBuilder() {
  SearchPage()
}

@ComponentV2
struct SearchPage {
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navstack', () => new NavPathStack())!
  @Local searchText: string = ''
  @Local searchResults: SongItemType[] = []
  @Local isSearching: boolean = false
  @Local playState: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  aboutToAppear() {
    // 获取传递的搜索关键词
    const params = this.pathStack.getParamByName("Search") as string[]
    if (params && params.length > 0) {
      this.searchText = params[0]
      this.handleSearch()
    }
  }

  async handleSearch() {
    if (this.isSearching) return
    if (!this.searchText.trim()) {
      return
    }
    this.isSearching = true
    this.searchResults = []
    
    try {
      // 1. 优先尝试网易云搜索
      const resp = await apiService.searchNetEaseSongs(this.searchText)
      if (resp.code === 200 && resp.data && resp.data.length > 0) {
        this.searchResults = resp.data
      } else {
        // 2. 网易云无结果或失败，回退本地搜索
        await this.searchLocal()
      }
    } catch (e) {
      // 网络异常，回退本地搜索
      await this.searchLocal()
    } finally {
      this.isSearching = false
    }
  }

  async searchLocal() {
    try {
      const resp = await apiService.getSongList()
      if (resp.code === 200 && resp.data) {
        const keyword = this.searchText.toLowerCase()
        this.searchResults = resp.data.filter(song => 
          song.name.toLowerCase().includes(keyword) || 
          song.author.toLowerCase().includes(keyword)
        )
      }
    } catch (e) {
      promptAction.showToast({ message: '搜索失败，请稍后重试' })
    }
  }

  build() {
    NavDestination() {
      Column() {
        // 顶部搜索栏
        Row() {
          Image($r('app.media.ic_back'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .onClick(() => {
              this.pathStack.pop()
            })
            .margin({ right: 10 })

          Row() {
            Image($r('app.media.ic_search'))
              .width(22)
              .fillColor('#817D83')
            TextInput({ text: this.searchText, placeholder: '搜索歌曲、歌手' })
              .placeholderColor('#817D83')
              .padding({ left: 5 })
              .fontColor('#999')
              .layoutWeight(1)
              .onChange((value) => {
                this.searchText = value
              })
              .onSubmit(() => {
                this.handleSearch()
              })
          }
          .layoutWeight(1)
          .backgroundColor('#2D2B29')
          .borderRadius(20)
          .padding({ left: 8, right: 8, top: 5, bottom: 5 })
          .height(40)

          Text('搜索')
            .fontColor(Color.White)
            .fontSize(16)
            .margin({ left: 10 })
            .onClick(() => {
              this.handleSearch()
            })
        }
        .width('100%')
        .padding({ left: 10, right: 10, top: 10, bottom: 10 })
        .backgroundColor('#131313')

        // 搜索状态
        if (this.isSearching) {
          Column() {
            LoadingProgress()
              .width(40)
              .height(40)
              .color(Color.White)
            Text('搜索中...')
              .fontColor(Color.Gray)
              .fontSize(14)
              .margin({ top: 10 })
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
        } else if (this.searchResults.length === 0) {
          // 无结果
          Column() {
            Text('未找到相关歌曲')
              .fontColor(Color.Gray)
              .fontSize(14)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
        } else {
          // 搜索结果列表
          List() {
            ForEach(this.searchResults, (item: SongItemType, index: number) => {
              ListItem() {
                Row() {
                  // 序号或波形
                  Stack({ alignContent: Alignment.Center }) {
                    if (this.playState.playList.length > 0 && this.playState.playList[this.playState.playIndex]?.id == item.id && this.playState.isPlay) {
                      Image($r('app.media.wave'))
                        .width(20)
                        .height(20)
                        .fillColor('#ec5c87')
                    } else {
                      Text((index + 1).toString())
                        .fontColor('#999')
                        .fontSize(14)
                    }
                  }
                  .width(40)

                  // 歌曲信息
                  Column({ space: 4 }) {
                    Text(item.name)
                      .fontColor(this.playState.playList.length > 0 && this.playState.playList[this.playState.playIndex]?.id == item.id ? '#ec5c87' : Color.White)
                      .fontSize(16)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                    
                    Text(item.author)
                      .fontColor(Color.Gray)
                      .fontSize(12)
                      .maxLines(1)
                      .textOverflow({ overflow: TextOverflow.Ellipsis })
                  }
                  .layoutWeight(1)
                  .alignItems(HorizontalAlign.Start)
                  .padding({ left: 10 })

                  // 更多按钮
                  Image($r('app.media.ic_more'))
                    .width(24)
                    .height(24)
                    .fillColor(Color.Gray)
                    .margin({ left: 10 })
                }
                .width('100%')
                .padding({ top: 10, bottom: 10, left: 10, right: 10 })
                .backgroundColor('#131313')
                .onClick(() => {
                  this.pathStack.pushPathByName('Play', null, false)
                  playerManager.singPlay(item, this.searchResults)
                })
              }
            })
          }
          .width('100%')
          .layoutWeight(1)
          .divider({ strokeWidth: 0.5, color: '#333333', startMargin: 60 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#131313')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}
