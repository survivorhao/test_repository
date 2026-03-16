import { AppStorageV2, promptAction } from '@kit.ArkUI'
import { apiService } from '../utils/apiService'
import { PlaylistNav } from '../models/music'
import { SongItemType } from '../models/music'
import { GlobalMusic } from '../models/globalMusic'
import { playerManager } from '../utils/AvPlayerManager'

@ComponentV2
export struct Recommend {
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navstack', () => new NavPathStack())!
  nav: PlaylistNav = AppStorageV2.connect(PlaylistNav, 'PLAYLIST_NAV', () => new PlaylistNav())!
  @Local playState: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  // 轮播图数据
  swiperList: string[] = [
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner1.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner2.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner3.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner4.png",
    "http://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/HeimaCloudMusic/banner5.png"
  ]

  @Local dailyRecommend: import("../models/music").PlaylistSummary[] = []

  @Local recommendList: import("../models/music").PlaylistSummary[] = []

  // 搜索
  @Local searchText: string = ''

  aboutToAppear() {
    this.fetchRecommend()
  }

  async fetchRecommend() {
    try {
      const resp = await apiService.getRecommendPlaylists()
      if (resp.code === 200 && resp.data) {
        const arr = resp.data
        this.dailyRecommend = arr.slice(0, 4)
        this.recommendList = arr.slice(4, 16)
      }
    } catch (e) {
    }
  }

  async startRoaming() {
    try {
      // 获取推荐歌单，这里复用getRecommendPlaylists，实际漫游可能需要更随机的接口
      const resp = await apiService.getRecommendPlaylists()
      if (resp.code === 200 && resp.data && resp.data.length > 0) {
        // 随机选择一个歌单的歌曲进行播放
        const randomIndex = Math.floor(Math.random() * resp.data.length)
        const playlistId = resp.data[randomIndex].id
        const playlistSongsResp = await apiService.getNetEasePlaylistDetail(playlistId)

        if (playlistSongsResp.code === 200 && playlistSongsResp.data && playlistSongsResp.data.length > 0) {
          // 开始播放第一个歌曲，并将整个歌单作为播放列表
          playerManager.singPlay(playlistSongsResp.data[0], playlistSongsResp.data)
          promptAction.showToast({ message: `开始漫游：${resp.data[randomIndex].name}` })
          // 跳转到播放页
          this.pathStack.pushPathByName("Play", null, false)
        } else {
          promptAction.showToast({ message: "未能获取漫游歌曲，请稍后再试" })
        }
      } else {
        promptAction.showToast({ message: "未能获取推荐歌单，请稍后再试" })
      }
    } catch (e) {
      console.error("Start roaming failed:", e)
      promptAction.showToast({ message: "漫游失败，请检查网络或稍后再试" })
    }
  }

  jumpToSearch() {
    if (this.searchText.trim()) {
      this.pathStack.pushPathByName('Search', [this.searchText], false)
    }
  }

  @Builder
  titleBuilder (title: string) {
    Row() {
      Text(title)
        .fontColor('#fff')
        .fontWeight(700)
        .layoutWeight(1)
      Image($r('app.media.ic_more'))
        .width(22)
        .fillColor('#fff')
    }
    .width('100%')
    .height(40)
  }

  build() {
    Column({space: 10}) {
      // 搜索区域
      Row() {
        Image($r('app.media.ic_search'))
          .width(22)
          .fillColor('#817D83')
        TextInput({placeholder: '只因你太美🔥', text: this.searchText })
          .placeholderColor('#817D83')
          .padding({left: 5})
          .fontColor('#999')
          .layoutWeight(1)
          .onChange((value: string) => {
            this.searchText = value
          })
          .onSubmit(() => {
            this.jumpToSearch()
          })
        Image($r('app.media.ic_search'))
          .width(20)
          .fillColor('#817D83')
          .onClick(() => {
            this.jumpToSearch()
          })
      }
      .width('100%')
      .backgroundColor('#2D2B29')
      .border({radius:20})
      .padding({left:8,right:8})

      // 漫游功能入口
      Row() {
        Image($r('app.media.ic_random'))
          .width(24)
          .height(24)
          .fillColor('#E85A88')
        Text('个性漫游')
          .fontSize(16)
          .fontColor('#fff')
          .fontWeight(FontWeight.Medium)
          .margin({ left: 8 })
      }
      .width('100%')
      .height(50)
      .backgroundColor('#2D2B29')
      .border({ radius: 10 })
      .padding({ left: 15, right: 15 })
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .onClick(() => {
        this.startRoaming()
      })

      // 轮播图
      Swiper() {
        ForEach(this.swiperList,(item:string) => {
          Image(item)
            .width('100%')
            .border({radius: 10})
        })
      }
      .autoPlay(true)

  // 每日推荐区域
  this.titleBuilder('每日推荐')
  List() {
        ForEach(this.dailyRecommend,(item: import("../models/music").PlaylistSummary) => {
          ListItem() {
            Column() {
              Image(item.cover_url)
                .width('100%')
              Text(item.name)
                .width('100%')
                .padding(5)
                .fontSize(14)
                .fontColor('#fff')
                .maxLines(2)
                .textOverflow({overflow: TextOverflow.Ellipsis})
            }
            .width('40%')
            .border({radius: 10})
            .margin({right: 10})
            .clip(true) // 裁剪圆角
            .onClick(() => {
              this.nav.id = item.id
              this.nav.name = item.name
              this.pathStack.pushPathByName('Playlist', null, false)
            })
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .height(230)
      .scrollBar(BarState.Off)

      // 推荐歌单区域
      this.titleBuilder('推荐歌单')
      List() {
        ForEach(this.recommendList,(item: import("../models/music").PlaylistSummary) => {
          ListItem() {
            Column() {
              Stack({alignContent:Alignment.TopStart}) {
                Image(item.cover_url)
                  .width('100%')
                  .height(100)
                  .border({radius: 8})
              }
              Text(item.name)
                .width('100%')
                .fontColor('#fff')
                .fontSize(14)
                .padding(5)
                .maxLines(2)
                .textOverflow({overflow: TextOverflow.Ellipsis})
            }
            .width('30%')
            .margin({right: 10})
            .onClick(() => {
              this.nav.id = item.id
              this.nav.name = item.name
              this.pathStack.pushPathByName('Playlist', null, false)
            })
          }
        })
      }
      .listDirection(Axis.Horizontal)
    }
    .width('100%')
    .height('100%')
    .padding({left:10,right:10,top:5,bottom:5})
  }
}
