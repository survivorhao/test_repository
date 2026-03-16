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
  @Local rotateAngle: number = 0 // 唱片旋转角度
  
  // 模拟旋转动画
  private timerId: number = -1

  aboutToAppear() {
    if (this.playState.playList.length === 0) {
      this.startRoaming()
    }
    this.startAnimation()
  }

  aboutToDisappear() {
    this.stopAnimation()
  }

  startAnimation() {
    this.timerId = setInterval(() => {
      if (this.playState.isPlay) {
        this.rotateAngle = (this.rotateAngle + 2) % 360
      }
    }, 50)
  }

  stopAnimation() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId)
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
      // 1. 动态氛围背景层
      Image(this.playState.playList[this.playState.playIndex]?.img || $r('app.media.bg_mine'))
        .width('100%')
        .height('100%')
        .blur(80)
        .objectFit(ImageFit.Cover)
        .opacity(0.6)
      
      // 2. 黑色渐变遮罩，增加文字可读性
      Rect()
        .width('100%')
        .height('100%')
        .fill(new LinearGradient({
          angle: 180,
          colors: [['rgba(0,0,0,0.2)', 0], ['rgba(0,0,0,0.8)', 1]]
        }))

      Column() {
        // 顶部标题栏
        Row() {
          Text('漫游模式')
            .fontSize(22)
            .fontWeight(700)
            .fontColor(Color.White)
            .letterSpacing(2)
            .shadow({ radius: 10, color: 'rgba(0,0,0,0.5)' })
          
          if (this.isLoading) {
            LoadingProgress()
              .width(24)
              .height(24)
              .color('#E85A88')
              .margin({ left: 12 })
          }
        }
        .width('100%')
        .padding({ top: 40, bottom: 20 })
        .justifyContent(FlexAlign.Center)

        // 3. 核心唱机视觉区域
        Stack({ alignContent: Alignment.Top }) {
          // 唱片主体
          Stack() {
            // 外圈阴影光晕
            Circle()
              .width(305)
              .height(305)
              .fill('rgba(255,255,255,0.05)')
            
            // 黑胶唱片底盘
            Image($r('app.media.ic_cd'))
              .width(300)
              .height(300)
              .rotate({ angle: this.rotateAngle })
            
            // 歌曲封面
            Image(this.playState.playList[this.playState.playIndex]?.img || $r('app.media.logo5'))
              .width(200)
              .height(200)
              .borderRadius(100)
              .rotate({ angle: this.rotateAngle })
              .shadow({ radius: 15, color: 'rgba(0,0,0,0.8)', offsetX: 5, offsetY: 5 })
          }
          .margin({ top: 60 })

          // 唱针（Stylus）
          Image($r('app.media.ic_stylus'))
            .width(100)
            .height(150)
            .margin({ left: 130 })
            .rotate({ 
              angle: this.playState.isPlay ? 0 : -30,
              centerX: 25,
              centerY: 25
            })
            .animation({ duration: 500, curve: Curve.EaseInOut })
        }
        .layoutWeight(1)

        // 4. 歌曲信息与控制面板（玻璃拟态设计）
        Column() {
          // 歌曲名称
          Text(this.playState.playList[this.playState.playIndex]?.name || '开启探索之旅')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .margin({ bottom: 8 })

          // 艺术家
          Text(this.playState.playList[this.playState.playIndex]?.author || '未知艺术家')
            .fontSize(16)
            .fontColor('rgba(255,255,255,0.7)')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 20 })

          // 来源标签
          Row() {
            Image($r('app.media.ic_music'))
              .width(14)
              .fillColor('rgba(255,255,255,0.5)')
              .margin({ right: 6 })
            Text(`正在漫游：${this.currentPlaylistName}`)
              .fontSize(13)
              .fontColor('rgba(255,255,255,0.5)')
          }
          .padding({ left: 12, right: 12, top: 4, bottom: 4 })
          .backgroundColor('rgba(255,255,255,0.1)')
          .borderRadius(12)
          .margin({ bottom: 40 })

          // 控制按钮组
          Row({ space: 50 }) {
            // 换个频道
            Column({ space: 8 }) {
              Button({ type: ButtonType.Circle }) {
                Image($r('app.media.ic_random'))
                  .width(28)
                  .fillColor(Color.White)
              }
              .width(64)
              .height(64)
              .backgroundColor('rgba(232, 90, 136, 0.2)')
              .border({ width: 1, color: 'rgba(232, 90, 136, 0.4)' })
              .onClick(() => this.startRoaming())
              
              Text('换个频道')
                .fontSize(12)
                .fontColor('rgba(255,255,255,0.8)')
            }

            // 播放/暂停
            Column({ space: 8 }) {
              Button({ type: ButtonType.Circle }) {
                Image(this.playState.isPlay ? $r('app.media.ic_paused') : $r('app.media.ic_play'))
                  .width(32)
                  .fillColor(Color.White)
              }
              .width(72)
              .height(72)
              .backgroundColor('rgba(255, 255, 255, 0.15)')
              .border({ width: 1, color: 'rgba(255, 255, 255, 0.3)' })
              .onClick(() => {
                playerManager.pauseOrPlay()
              })
              
              Text(this.playState.isPlay ? '暂停' : '播放')
                .fontSize(12)
                .fontColor('rgba(255,255,255,0.8)')
            }

            // 详情
            Column({ space: 8 }) {
              Button({ type: ButtonType.Circle }) {
                Image($r('app.media.ic_playing'))
                  .width(28)
              }
              .width(64)
              .height(64)
              .backgroundColor('rgba(99, 170, 170, 0.2)')
              .border({ width: 1, color: 'rgba(99, 170, 170, 0.4)' })
              .onClick(() => {
                this.pathStack.pushPathByName("Play", null, false)
              })
              
              Text('播放详情')
                .fontSize(12)
                .fontColor('rgba(255,255,255,0.8)')
            }
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .margin({ bottom: 60 })
        }
        .width('90%')
        .padding(30)
        .backgroundColor('rgba(255,255,255,0.05)')
        .borderRadius(32)
        .border({ width: 1, color: 'rgba(255,255,255,0.1)' })
        .margin({ bottom: 40 })
        .backdropBlur(20) // 毛玻璃效果
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#000')
  }
}
