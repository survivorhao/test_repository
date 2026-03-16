import { AppStorageV2, promptAction } from '@kit.ArkUI'
import { apiService } from '../utils/apiService'
import { SongItemType } from '../models/music'
import { GlobalMusic } from '../models/globalMusic'
import { playerManager } from '../utils/AvPlayerManager'

@ComponentV2
export struct Roaming {
  pathStack: NavPathStack = AppStorageV2.connect(NavPathStack, 'navstack', () => new NavPathStack())!
  @Local playState: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!
  @Local isLoading: boolean = false
  @Local currentPlaylistName: string = "正在探索..."

  aboutToAppear() {
    // 如果当前没有播放列表，自动开启漫游
    if (this.playState.playList.length === 0) {
      this.startRoaming()
    }
  }

  async startRoaming() {
    if (this.isLoading) return
    this.isLoading = true
    try {
      const resp = await apiService.getRecommendPlaylists()
      if (resp.code === 200 && resp.data && resp.data.length > 0) {
        const randomIndex = Math.floor(Math.random() * resp.data.length)
        const playlist = resp.data[randomIndex]
        this.currentPlaylistName = playlist.name
        
        const playlistSongsResp = await apiService.getNetEasePlaylistDetail(playlist.id)
        if (playlistSongsResp.code === 200 && playlistSongsResp.data && playlistSongsResp.data.length > 0) {
          playerManager.singPlay(playlistSongsResp.data[0], playlistSongsResp.data)
          promptAction.showToast({ message: `漫游至：${playlist.name}` })
        }
      }
    } catch (e) {
      promptAction.showToast({ message: "漫游失败，请稍后再试" })
    } finally {
      this.isLoading = false
    }
  }

  build() {
    Stack() {
      // 沉浸式背景：当前播放歌曲的封面模糊效果
      Image(this.playState.playList[this.playState.playIndex]?.img || $r('app.media.bg_mine'))
        .width('100%')
        .height('100%')
        .blur(50)
        .objectFit(ImageFit.Cover)
        .opacity(0.4)

      Column() {
        // 顶部状态
        Row() {
          Text('音乐漫游')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          
          if (this.isLoading) {
            LoadingProgress()
              .width(24)
              .height(24)
              .color(Color.White)
              .margin({ left: 10 })
          }
        }
        .width('100%')
        .padding(20)
        .justifyContent(FlexAlign.Center)

        Blank()

        // 核心视觉：黑胶唱片旋转感
        Stack({ alignContent: Alignment.Center }) {
          // 唱片底盘
          Circle()
            .width(260)
            .height(260)
            .fill('#111')
            .shadow({ radius: 20, color: '#000', offsetX: 5, offsetY: 5 })
          
          // 歌曲封面
          Image(this.playState.playList[this.playState.playIndex]?.img || $r('app.media.logo5'))
            .width(240)
            .height(240)
            .borderRadius(120)
            .objectFit(ImageFit.Cover)
            // 模拟旋转效果（实际需要animation，这里简化为静态展示）
        }
        .margin({ bottom: 40 })

        // 歌曲信息
        Column({ space: 8 }) {
          Text(this.playState.playList[this.playState.playIndex]?.name || '暂无播放内容')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })

          Text(this.playState.playList[this.playState.playIndex]?.author || '未知艺术家')
            .fontSize(16)
            .fontColor('#ccc')
            .textAlign(TextAlign.Center)
        }
        .padding({ left: 30, right: 30 })

        Text(`来自：${this.currentPlaylistName}`)
          .fontSize(12)
          .fontColor('#888')
          .margin({ top: 10 })

        Blank()

        // 漫游控制
        Row({ space: 40 }) {
          // 换一换按钮
          Column({ space: 5 }) {
            Button({ type: ButtonType.Circle }) {
              Image($r('app.media.ic_random'))
                .width(30)
                .fillColor(Color.White)
            }
            .width(60)
            .height(60)
            .backgroundColor('#33E85A88')
            .onClick(() => this.startRoaming())
            
            Text('换个频道')
              .fontSize(12)
              .fontColor(Color.White)
          }

          // 进入播放页详情
          Column({ space: 5 }) {
            Button({ type: ButtonType.Circle }) {
              Image($r('app.media.ic_playing'))
                .width(30)
            }
            .width(60)
            .height(60)
            .backgroundColor('#3363AAAA')
            .onClick(() => {
              this.pathStack.pushPathByName("Play", null, false)
            })
            
            Text('查看详情')
              .fontSize(12)
              .fontColor(Color.White)
          }
        }
        .margin({ bottom: 100 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#131215')
  }
}
