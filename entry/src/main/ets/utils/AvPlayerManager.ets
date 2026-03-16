import { media } from '@kit.MediaKit'
import { GlobalMusic } from '../models/globalMusic'
import { SongItemType } from '../models/music'
import { AppStorageV2 } from '@kit.ArkUI'
import { sessionManager } from './AvSessionManager'
import { apiService } from '../utils/apiService'
import { ApiResponse } from '../models/user'
import { SongUrl } from '../models/music'

class AvPlayerManager {
  // 属性 + 方法
  // 播放器
  player: media.AVPlayer | null = null

  // 共享播放数据
  currentSong: GlobalMusic = AppStorageV2.connect(GlobalMusic, 'SONG_KEY', () => new GlobalMusic())!

  // 定义方法 创建播放器 + 监听播放器的状态
  async init() {
    if(!this.player) {
      this.player = await media.createAVPlayer()
    }

    this.player.on('stateChange',(state) => {
      if(state == 'initialized') {
        this.player?.prepare()
      }
      else if(state == 'prepared') {
        this.player?.play()
        this.currentSong.isPlay = true
      }
      else if(state == 'completed') {
        this.nextPlay(true) // 自动下一首
      }
      else if(state == 'released') {
        this.currentSong.reset()
      }
    })

    // 监听时间变化
    this.player.on('durationUpdate',(duration) => {
      this.currentSong.duration = duration
    })

    let lastUpdate = 0
    this.player.on('timeUpdate',(time) => {
      this.currentSong.time = time
      // 限制更新频率，每秒更新一次
      const now = Date.now()
      if (now - lastUpdate > 1000) {
        sessionManager.setAVPlayBackState()
        lastUpdate = now
      }
    })
    this.player.on('error', (err) => {
      console.error(`[AvPlayerManager] Error: ${JSON.stringify(err)}`)
      this.currentSong.isPlay = false
      sessionManager.setAVPlayBackState()
    })
  }

  // 接受音频
  // singPlay(song: SongItemType) {
  //   this.player!.url = song.url
  //   this.currentSong.img = song.img
  // }
  singPlay(song: SongItemType, fullList?: SongItemType[]) {
    sessionManager.startBackgroundTask()
    sessionManager.setAVPlayBackState()
    if (fullList && fullList.length > 0) {
      if (this.currentSong.playList.length > 0 && this.currentSong.playList[this.currentSong.playIndex]?.id == song.id) {
        this.player?.play()
        this.currentSong.isPlay = true
        return
      }
      this.currentSong.originPlayList = [...fullList]
      this.currentSong.playList = [...fullList]
      const idx = this.currentSong.playList.findIndex(item => item.id == song.id)
      this.currentSong.playIndex = idx >= 0 ? idx : 0
      this.changeSong()
      return
    }
    // 判断是否在列表
    const inList = this.currentSong.playList.some(item => item.id == song.id)
    if(inList) {
      if(this.currentSong.playList[this.currentSong.playIndex]?.id == song.id) {
        this.player?.play()
        this.currentSong.isPlay = true
      } else {
        this.currentSong.playIndex = this.currentSong.playList.findIndex(item => item.id == song.id)
        this.changeSong()
      }
    }
    else {
      this.currentSong.playList.unshift(song)
      this.currentSong.playIndex = 0
      this.changeSong()
    }
  }

  // 切换歌曲
  async changeSong() {
    await this.player?.reset()
    this.currentSong.duration = 0
    this.currentSong.time = 0
    const current = this.currentSong.playList[this.currentSong.playIndex]
    this.currentSong.img = current.img
    this.currentSong.name = current.name
    this.currentSong.author = current.author
    const presetUrl = current.url
    try {
      const songId = current.id
      const neResp: ApiResponse<SongUrl> = await apiService.getNetEaseSongUrl(songId)
      if (neResp.code === 200 && neResp.data && neResp.data.url) {
        this.currentSong.url = neResp.data.url
      } else {
        const resp: ApiResponse<SongUrl> = await apiService.getSongUrl(songId)
        if (resp.code === 200 && resp.data && resp.data.url) {
          this.currentSong.url = resp.data.url
        } else {
          this.currentSong.url = presetUrl || ''
        }
      }
    } catch (_) {
      try {
        const resp: ApiResponse<SongUrl> = await apiService.getSongUrl(current.id)
        if (resp.code === 200 && resp.data && resp.data.url) {
          this.currentSong.url = resp.data.url
        } else {
          this.currentSong.url = presetUrl || ''
        }
      } catch (__ ) {
        this.currentSong.url = presetUrl || ''
      }
    }
    if (this.currentSong.url && this.currentSong.url.length > 0) {
      this.player!.url = this.currentSong.url
      sessionManager.setAVMetadata(this.currentSong.playList[this.currentSong.playIndex])
      try {
        await this.player?.prepare()
        this.player?.play()
        this.currentSong.isPlay = true
      } catch (_) {}
    } else {
      this.currentSong.isPlay = false
    }
  }

  // 跳转进度
  seekPLay(value: number) {
    this.player?.seek(value)
  }

  // 暂停
  paused() {
    this.player?.pause()
    this.currentSong.isPlay = false
    sessionManager.setAVPlayBackState()
  }

  // 恢复播放
  resume() {
    this.player?.play()
    this.currentSong.isPlay = true
    sessionManager.setAVPlayBackState()
  }

  // 上一首
  prevPlay() {
    const len = this.currentSong.playList.length
    if (len === 0) { return }
    if (this.currentSong.playMode === 'random') {
      let newIndex = this.currentSong.playIndex
      if (len > 1) {
        while (newIndex === this.currentSong.playIndex) {
          newIndex = Math.floor(Math.random() * len)
        }
      }
      this.playByIndex(newIndex)
      return
    }
    this.playByIndex(this.currentSong.playIndex - 1)
  }

  // 下一首 根据模式计算索引
  nextPlay(autoNextPlay?: boolean) {
    const len = this.currentSong.playList.length
    if (len === 0) { return }
    if (this.currentSong.playMode === 'repeat' && autoNextPlay) {
      this.playByIndex(this.currentSong.playIndex)
      return
    }
    if (this.currentSong.playMode === 'random') {
      let newIndex = this.currentSong.playIndex
      if (len > 1) {
        while (newIndex === this.currentSong.playIndex) {
          newIndex = Math.floor(Math.random() * len)
        }
      }
      this.playByIndex(newIndex)
      return
    }
    this.playByIndex(this.currentSong.playIndex + 1)
  }

  playByIndex(index: number) {
    const len = this.currentSong.playList.length
    if (len === 0) { return }
    const normalized = ((index % len) + len) % len
    this.currentSong.playIndex = normalized
    this.changeSong()
  }

  // 列表移除歌曲
  removeSong(index: number) {
    if(index == this.currentSong.playIndex) {
      // 正在播放
      if(this.currentSong.playList.length > 1) {
        this.currentSong.playList.splice(index,1)
        if(this.currentSong.playIndex >= this.currentSong.playList.length) {
          this.currentSong.playIndex = 0
        }
        this.singPlay(this.currentSong.playList[this.currentSong.playIndex])
      }
      else {
        this.player?.reset()
        this.currentSong.reset()
      }
    }
    else {
      // 不是正在播放
      if(index < this.currentSong.playIndex) {
        // 删除的index在前面
        this.currentSong.playIndex--
      }
      this.currentSong.playList.splice(index,1)

    }
  }

  // 释放播放器和播放数据
  async release() {
    await this.player?.release()

  }

}

export const playerManager: AvPlayerManager = new AvPlayerManager()
