import { SongItemType } from "../models/music"
import { AppStorageV2, promptAction } from "@kit.ArkUI"
import { playerManager } from "../utils/AvPlayerManager"
import { GlobalMusic } from "../models/globalMusic"
import { apiService } from "../utils/apiService"

@ComponentV2
export struct Find {
  @Local songs: SongItemType[] = []
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navstack', () => new NavPathStack())!
  @Local
  playState: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  aboutToAppear() {
    this.getSongList()
  }

  async getSongList() {
    try {
      const result = await apiService.getSongList()
      if (result.code === 200 && result.data) {
        this.songs = result.data
      } else {
        promptAction.showToast({ message: result.message || '获取歌曲列表失败' })
      }
    } catch (error) {
      console.error('Fetch song list failed:', error)
      promptAction.showToast({ message: '网络错误，请稍后重试' })
    }
  }
  
  

  build() {
    Column() {
      Text('猜你喜欢')
        .fontColor('#fff')
        .width('100%')
        .margin({ bottom: 10 })
      
      
      List() {
        ForEach(this.songs, (item: SongItemType, index: number) => {
          ListItem() {
            Row() {
              // 图
              Stack() {
                Image(item.img)
                  .width(80)
                  .border({ radius: 8 })
                  .margin({ right: 10 })
                if(this.playState.playList.length > 0 && this.playState.playList[this.playState.playIndex]?.id == item.id && this.playState.isPlay) {
                  Image($r('app.media.wave'))
                    .width(24)
                }
              }

              // 字
              Column() {
                Text(item.name)
                  .fontColor(this.playState.playList.length > 0 && this.playState.playList[this.playState.playIndex]?.id == item.id ? '#ec5c87' : '#F3F3F3')
                  .width('100%')
                  .fontWeight(700)
                  .margin({ bottom: 15 })
                Row() {
                  Text('VIP')
                    .fontColor('#9A8E28')
                    .border({ width: 1, color: '#9A8E28', radius: 12 })
                    .padding({
                      left: 5,
                      right: 5,
                      top: 3,
                      bottom: 3
                    })
                    .margin({ right: 10 })
                  Text(item.author)
                    .fontColor('#696969')
                }
                .width('100%')
              }
              .layoutWeight(1)

              // 更多
              Image($r('app.media.ic_more'))
                .width(24)
                .fillColor('#FEFEFE')
            }
            .width('100%')
            .height(80)
            // .backgroundColor(Color.Pink)
            .margin({ bottom: 10 })
            .onClick(() => {
              this.pathStack.pushPathByName('Play', null, false)
              playerManager.singPlay(item, this.songs)
            })

          }
        })
      }
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#131313')
    .padding({ left: 10, right: 10 })
    // 扩充组件安全区域
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}
