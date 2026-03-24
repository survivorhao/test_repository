import { media } from "@kit.MediaKit"
import Song from "../models/Song"
import { http } from "@kit.NetworkKit"
import { SongDetailResponse } from "../models/SongDetailResponse"

export class AVPlayerHelper{
  static avPlayer:media.AVPlayer|undefined
  static async playMusic(song:Song){
    //如果有音乐正在播放，则停止当前音乐
    if(AVPlayerHelper.avPlayer){
      AVPlayerHelper.avPlayer.stop()
      AVPlayerHelper.avPlayer = undefined
    }
    //使用Media Kit中的AVPlayer组件完成音乐播放
    //1.创建实例createAVPlayer()，AVPlayer初始化idle状态
    let avPalyer:media.AVPlayer = await media.createAVPlayer()
    AVPlayerHelper.avPlayer = avPalyer
    //2.订阅avPalyer状态变化事件
    avPalyer.on("stateChange",(state:media.AVPlayerState)=>{
      AppStorage.setOrCreate('avPlayerState',state)
      if(state == 'idle'){                  //闲置状态
      }else if(state == 'initialized'){     //资源初始化
        avPalyer.prepare()
      }else if(state == 'prepared'){        //已准备状态
        avPalyer.play()
      }else if(state == 'playing'){
      }else if(state == 'completed'){
      }else if(state == 'paused'){
      }else if(state == 'stopped'){
        avPalyer.release()
      }else if(state == 'released'){
        console.log('avPlayer已释放')
      }else if(state == 'error'){
        console.log('avPlayer播放出错')
      }
    })
    // 订阅avPalyer播放时间更新事件
    avPalyer.on("timeUpdate",time=>{
      AppStorage.setOrCreate('currentTime',time)
    })
    // 订阅avPalyer音频资源时长更新事件
    avPalyer.on("durationUpdate",duration=>{
      AppStorage.setOrCreate('duration',duration)
    })
    // 订阅播放器跳转事件
    avPalyer.on("seekDone" ,time=>{})
    //3.设置avPlayer的URL （ idle ---> initialized ）
    avPalyer.url = `http://music.163.com/song/media/outer/url?id=${song.id}.mp3`
  }

  static syncCurrentMusicInfo(song:Song){
    // a.根据音乐id查询当前音乐详情
    let httpRequest = http.createHttp()
    let url = `http://music.163.com/api/song/detail/?id=${song.id}&ids=[${song.id}]`
    httpRequest.request(url,(err,res:http.HttpResponse)=>{
      let jsonStr = res.result as string
      let obj = JSON.parse(jsonStr) as SongDetailResponse
      // b.将当前正在播放的音乐详情，显示到播放器
      AppStorage.setOrCreate('currentMusic',obj.songs[0])
      console.log('syncCurrentMusicInfo:',JSON.stringify(obj.songs[0]))
    })
  }

  static playNextMusic(){
    let index = AppStorage.get('currentIndex') as number
    let songList = AppStorage.get('playList') as Song[]
    //index == songList.length-1  用于判断是否为最后一首歌
    let nextIndex = index == songList.length-1 ? 0 : index+1
    let nextSong = songList[nextIndex]
    // 判断当前歌曲是否为收费歌曲，fee != 0[不是免费歌曲]
    while(nextSong.fee != 0 ){
      nextIndex = nextIndex == songList.length-1 ? 0 : nextIndex+1
      nextSong = songList[nextIndex]
    }
    //更新AppStorage存储的正在播放的音乐的索引
    AppStorage.setOrCreate('currentIndex',nextIndex)
    // console.log('下一首音乐的索引值:',nextIndex)
    //执行播放
    AVPlayerHelper.playMusic(nextSong)
    //更新正在播放的音乐信息
    AVPlayerHelper.syncCurrentMusicInfo(nextSong)
  }

  static playLastMusic(){
    let index = AppStorage.get('currentIndex') as number
    let songList = AppStorage.get('playList') as Song[]
    //index == 0  用于判断是否为第一首歌
    let lastIndex = index == 0 ? songList.length-1 : index-1
    let lastSong = songList[lastIndex]
    // 判断当前歌曲是否为收费歌曲，fee != 0[不是免费歌曲]
    while(lastSong.fee != 0 ){
      lastIndex = lastIndex == 0 ? songList.length-1 : lastIndex-1
      lastSong = songList[lastIndex]
    }
    //更新AppStorage存储的正在播放的音乐的索引
    AppStorage.setOrCreate('currentIndex',lastIndex)
    //执行播放
    AVPlayerHelper.playMusic(lastSong)
    //更新正在播放的音乐信息
    AVPlayerHelper.syncCurrentMusicInfo(lastSong)
  }
}