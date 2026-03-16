import { AppStorageV2 } from '@kit.ArkUI'
import { GlobalMusic } from '../models/globalMusic'
import { playerManager } from '../utils/AvPlayerManager'

@ComponentV2
export struct PlayerStatusBar {
  @Local
  playState: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!
  @Param onOpenPlay: () => void = () => {}
  @Param onOpenList: () => void = () => {}

  build() {
    if (this.playState.playList.length > 0) {
      Row() {
        // Cover Image
        Image(this.playState.img || $r('app.media.ic_logo'))
          .width(40)
          .height(40)
          .borderRadius(4)
          .margin({ left: 15 })
          .objectFit(ImageFit.Cover)

        // Song Info
        Column({ space: 4 }) {
          Text(this.playState.name || '暂无歌曲')
            .fontColor(Color.White)
            .fontSize(14)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          Text(this.playState.author || '未知歌手')
            .fontColor('#a0a0a0')
            .fontSize(12)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 10, right: 10 })

        // Controls
        Row({ space: 15 }) {
          // Prev
          Image($r('app.media.ic_prev'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .onClick(() => {
              playerManager.prevPlay()
            })

          // Play/Pause
          Stack() {
            if (this.playState.isPlay) {
              Image($r('app.media.ic_paused'))
                .width(28)
                .height(28)
                .fillColor(Color.White)
            } else {
              Image($r('app.media.ic_play'))
                .width(28)
                .height(28)
                .fillColor(Color.White)
            }
          }
          .onClick(() => {
            if (this.playState.isPlay) {
              playerManager.paused()
            } else {
              playerManager.resume()
            }
          })

          // Next
          Image($r('app.media.ic_next'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .onClick(() => {
              playerManager.nextPlay()
            })

          // Song List (open Play page list panel)
          Image($r('app.media.ic_song_list'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .onClick(() => {
              if (this.onOpenList) {
                this.onOpenList()
              }
            })
        }
        .margin({ right: 15 })
      }
      .width('100%')
      .height(64)
      .backgroundColor('#1c1c1e')
      .border({ width: { top: 0.5 }, color: '#333333' })
      .onClick(() => {
        if (this.onOpenPlay) {
          this.onOpenPlay()
        }
      })
    }
  }
}
