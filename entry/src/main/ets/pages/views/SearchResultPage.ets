import { deferredLink } from '@kit.AppLinkingKit'
import Song from '../../models/Song'
import { http } from '@kit.NetworkKit'
import SongSearchResponse from '../../models/SongSearchResponse'
import Artist from '../../models/Artist'
import { AVPlayerHelper } from '../../untils/AVPlayerHelper'
import { WidthBreakpointType } from '../../untils/WidthBreakpointType'

@Builder
export function SearchResultPageBuilder(){
  SearchResultPage()
}

@Component
struct SearchResultPage{
  @State keyword:string=''
  // private pathStack:NavPathStack | undefined
  private pathStack:NavPathStack=new NavPathStack()
  @State songList:Song[]=[]   //用于存储搜索结果
  @State artistList:Artist[]=[]  //用于存储歌手搜索结果
  private pageSize:number=50    //每页显示的记录数
  private pageNum:number=1    //显示的页数
  @StorageProp('widthBreakPoint') currentWidthBreakPoint:WidthBreakpoint = WidthBreakpoint.WIDTH_SM

  build(){
    NavDestination(){
      Column(){
        //定义标题栏
        Row({space:10}){
          SymbolGlyph($r('sys.symbol.chevron_left'))
            .fontSize(25)
            .onClick(() => {
              if (this.pathStack) {
                this.pathStack.pop()
              }
            })
          Search({value:$$this.keyword}).width('80%').margin(0)
        }.width('100%')
        .height(60)

        Tabs(){
          TabContent(){
            List(){
              ForEach(this.songList,(item:Song,index:number)=>{
                ListItem(){
                  this.songListItem(item,index)
                }
              })
            }
          }.tabBar('单曲')
          TabContent(){

          }.tabBar('歌单')
          TabContent(){

          }.tabBar('专辑')
          TabContent(){
            
          }.tabBar('歌手')
        }

      }.width('100%')
      .height('100%')
      .padding(10)
    }
    .hideTitleBar(true)   //隐藏系统根据栏
    .hideToolBar(true)    //隐藏标题栏
    .hideBackButton(true)   //隐藏导航返回按钮
    .backgroundColor('#f1f3f5')
    .onReady(context=>{
      this.pathStack = context.pathStack
      this.keyword= this.pathStack.getParamByName("SearchResultPage")[0] as string
      console.log(this.keyword)
      this.doSearch(this.keyword,1,this.pageSize,this.pageNum)
    })
  }

  doSearch(keyword:string,type:number,pageSize:number,PageNum:number){
    let httpRequest = http.createHttp();
    let options:http.HttpRequestOptions={
      method:http.RequestMethod.GET
    }

    //offset用于确认当前查询的起始位置
    let url = `http://music.163.com/api/search/get?s=${keyword}&type=${type}&limit=${pageSize}&offset=${(PageNum-1)*pageSize}`

    httpRequest.request(encodeURI(url), options).then((response)=>{
      if(response.responseCode=200){
        //获取并处理结果
        let jsonStr=response.result as string
        if(type==1){
          //单曲
          //将jsonstr转化为js原生对象--object/array
          let songSearchResponse=JSON.parse(jsonStr) as SongSearchResponse
          if(songSearchResponse.code==200){
            this.songList=songSearchResponse.result ? songSearchResponse.result.songs : []
            //将请求到的数据同时存放到AppStorage
            AppStorage.setOrCreate('playList',this.songList)
            console.log('songList:',JSON.stringify(this.songList))
          }
        }else if(type==10){
          //专辑

        }else if(type==100){
          //歌手
        }else if(type==1000){
          //歌单

        }
      }else{
        this.getUIContext().getPromptAction().showToast({message:'请求失败'})
      }
    })
  }

  @Builder
  songListItem(song:Song,index:number){
    Row(){
      Column(){
        Text(new WidthBreakpointType(
          song.name.length > 10 ? song.name.substring(0, 10) + '...' : song.name,
          song.name.length > 14 ? song.name.substring(0, 14) + '...' : song.name,
          song.name.length > 40 ? song.name.substring(0, 40) + '...' : song.name,
          song.name.length > 50 ? song.name.substring(0, 50) + '...' : song.name,
          song.name.length > 65 ? song.name.substring(0, 65) + '...' : song.name
        ).getValue(this.currentWidthBreakPoint)).fontSize(18)
        Row({space:5}) {
          Text(song.artists[0].name).fontSize(13).fontColor(Color.Gray)
          if (song.mvid > 0) {
            Text('MV')
              .backgroundColor('#ff5555')
              .fontColor('#ffffff')
              .fontSize(10)
              .borderRadius(5)
              .padding(2)
          }
        }
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      if(song.fee==0){    //如果fee=0，说明存在音频可以播放
        SymbolGlyph($r('sys.symbol.play_fill')).fontSize(20)
          .onClick(() => {
            //播放当前音乐
            AVPlayerHelper.playMusic(song)
            //将当前播放的索引保存到AppStorage
            AppStorage.setOrCreate('currentIndex',index)
            AVPlayerHelper.syncCurrentMusicInfo(song)
          })
      }else{
        SymbolGlyph($r('sys.symbol.play_fill')).fontSize(20).fontColor(['#ffdbd6d6'])
      }
    }.width('99%').padding(15)
  }

}

