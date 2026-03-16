import { AppStorageV2, promptAction } from '@kit.ArkUI'
import { apiService } from '../utils/apiService'
import { SongItemType, PlaylistNav } from '../models/music'
import { GlobalMusic } from '../models/globalMusic'
import { playerManager } from '../utils/AvPlayerManager'

@Builder
export function PlaylistBuilder() {
  Playlist()
}

@ComponentV2
export struct Playlist {
  @Local title: string = ''
  @Local songs: SongItemType[] = []
  @Local loading: boolean = false
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navstack', () => new NavPathStack())!
  playState: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!
  nav: PlaylistNav = AppStorageV2.connect(PlaylistNav, 'PLAYLIST_NAV', () => new PlaylistNav())!

  aboutToAppear() {
    const id = this.nav.id || ''
    this.title = this.nav.name || '歌单'
    if (!id) {
      promptAction.showToast({ message: '歌单ID缺失' })
      return
    }
    this.fetchPlaylist(id)
  }

  async fetchPlaylist(id: string) {
    this.loading = true
    try {
      const resp = await apiService.getNetEasePlaylistDetail(id)
      if (resp.code === 200 && resp.data) {
        this.songs = resp.data
      } else {
        promptAction.showToast({ message: resp.message || '获取歌单失败' })
      }
    } catch (e) {
      promptAction.showToast({ message: '网络错误，请稍后重试' })
    } finally {
      this.loading = false
    }
  }

  async handlePlay(song: SongItemType) {
    try {
      const resp = await apiService.getNetEaseSongUrl(song.id)
      if (resp.code === 200 && resp.data && resp.data.url) {
        const playable: SongItemType = {
          img: song.img,
          name: song.name,
          author: song.author,
          url: resp.data.url,
          id: song.id
        }
        playerManager.singPlay(playable, this.songs)
      } else {
        promptAction.showToast({ message: resp.message || '无法获取播放链接' })
      }
    } catch (e) {
      promptAction.showToast({ message: '网络错误，请稍后重试' })
    }
  }

  build() {
    NavDestination() {
      Column() {
        Row() {
          Image($r('app.media.ic_back'))
            .width(24)
            .fillColor('#FFFFFF')
            .onClick(() => this.pathStack.pop())
          Text(this.title)
            .fontColor('#fff')
            .fontWeight(700)
            .margin({ left: 8 })
        }
        .width('100%')
        .padding({ top: 10, bottom: 10 })
    
        if (this.loading) {
          Text('加载中...')
            .fontColor('#aaa')
        } else {
          List() {
            ForEach(this.songs, (item: SongItemType, index: number) => {
              ListItem() {
                Row() {
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
                  Image($r('app.media.ic_more'))
                    .width(24)
                    .fillColor('#FEFEFE')
                }
                .width('100%')
                .height(80)
                .margin({ bottom: 10 })
                .onClick(() => {
                  this.pathStack.pushPathByName('Play', null, false)
                  this.handlePlay(item)
                })
              }
            })
          }
          .scrollBar(BarState.Off)
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#131313')
      .padding({ left: 10, right: 10 })
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
    }
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}
