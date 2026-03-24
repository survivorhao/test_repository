import { SongDetail } from '../models/SongDetailResponse'
import { AVPlayerHelper } from '../untils/AVPlayerHelper'
import { WidthBreakpointType } from '../untils/WidthBreakpointType'
import { RegisterBuilder } from './views/Register'
import { Found } from './views/Found'
import { LoginBuilder } from './views/Login'
import { Mine } from './views/Mine'
import { Note } from './views/Note'
import { Roam } from './views/Roam'
import { SearchPageBuilder } from './views/SearchPage'
import { SearchResultPageBuilder } from './views/SearchResultPage'
import { Tui_jian } from './views/Tui_jian'

@Entry
@Component
struct Index {

  @Provide pathStack:NavPathStack=new NavPathStack()
  @State currentIndex:number=0
  @StorageLink("msg") isBoFangKuang:boolean = true
  @StorageProp('currentMusic') currentMusic:SongDetail|undefined= undefined
  @StorageProp('currentTime') time:number=0
  @StorageProp('duration') duration:number=0
  @StorageProp('avPlayerState') avPlayerState:string='pause'
  @State isPlayViewShow:boolean=false   //默认情况下不拉起
  @StorageProp('widthBreakPoint') currentWidthBreakPoint:WidthBreakpoint = WidthBreakpoint.WIDTH_SM

  @Builder      //使用@Builder定义导航图样式
  tabBuilder(title:string,index:number,selectedImg:Resource,normalImg:Resource){
    Column(){
      Image(this.currentIndex===index ? selectedImg : normalImg)
        .width('25vp').height('25vp')
      Text(title)
        .fontSize('10fp')
        .fontColor(this.currentIndex===index ? '#FC3D49' : '#6B6B6B' )
    }
    .width('100%').height('56vp').justifyContent(FlexAlign.Center)
  }

  @Builder
  PageMap(name: string) {
    if (name === 'SearchPage') {
      SearchPageBuilder()
    }
    else if (name === 'SearchResultPage') {
      SearchResultPageBuilder()
    }
    else if(name==='Login'){
      LoginBuilder(name)
    }
    else if(name==='Register'){
      RegisterBuilder(name)
    }
  }

  build() {
    Stack({
      alignContent:Alignment.Bottom,
    }) {
      Navigation(this.pathStack){
        Tabs({
          // barPosition:BarPosition.End
          // barPosition:new WidthBreakpointType(BarPosition.End,BarPosition.End,BarPosition.Start,BarPosition.Start,BarPosition.Start).getValue(this.currentWidthBreakPoint)
          barPosition:new WidthBreakpointType(BarPosition.End,BarPosition.End,BarPosition.Start,BarPosition.Start,BarPosition.Start).getValue(this.currentWidthBreakPoint)
        }){
          TabContent(){
            Tui_jian()
          }.tabBar(this.tabBuilder('推荐',0,$r('app.media.tab_music_selected'),$r('app.media.tab_music_normal')))
          TabContent(){
            Found()
          }.tabBar(this.tabBuilder('发现',1,$r('app.media.tab_found_selected'),$r('app.media.tab_found_normal')))
          TabContent(){
            Roam()
          }.tabBar(this.tabBuilder('漫游',2,$r('app.media.tab_roam_selected'),$r('app.media.tab_roam_normal')))
          TabContent(){
            Note()
          }.tabBar(this.tabBuilder('笔记',3,$r('app.media.tab_note_selected'),$r('app.media.tab_note_normal')))
          TabContent(){
            Mine()
          }.tabBar(this.tabBuilder('我的',4,$r('app.media.tab_mine_selected'),$r('app.media.tab_mine_normal')))
        }
        .vertical(new WidthBreakpointType(false,false,true,true,true).getValue(this.currentWidthBreakPoint))
        .barWidth(new WidthBreakpointType('100%','100%','80vp','80vp','80vp').getValue(this.currentWidthBreakPoint))
        .barHeight(new WidthBreakpointType(60,60,500,500,500).getValue(this.currentWidthBreakPoint))
        .onChange(index=>{
          this.currentIndex=index
          console.log('当前索引：',index)
        })
      }
      .width('100%')
      .height('100%')
      .hideTitleBar( true)      //是否隐藏标题栏
      .hideToolBar(true)        //是否隐藏工具栏
      .backgroundColor('#f1f3f5')
      .mode(NavigationMode.Stack)     //设置为单栏模式
      .navDestination(this.PageMap)   //绑定子页配置到Navigation导航

      //自定义设置播控框
      if(this.isBoFangKuang && this.currentIndex != 2){
        Row() {
          Image(this.currentMusic == undefined ? $r('app.media.banner_02') : this.currentMusic?.album?.blurPicUrl)
            .width('39vp')
            .height('39vp')
            .margin({ left: 20, right: 5 })
            .bindContentCover(this.isPlayViewShow,this.PlayView())    //全模态窗的绑定
            .onClick(() => {
              this.isPlayViewShow = !this.isPlayViewShow
            })

          Column({ space: 10 }) {
            Row() {
              if (this.currentMusic) {
                  // Text(this.currentMusic?.name)
                  Text(new WidthBreakpointType(
                    this.currentMusic?.name.length > 8 ? this.currentMusic?.name.substring(0, 8) + '...' : this.currentMusic?.name,
                    this.currentMusic?.name.length > 8 ? this.currentMusic?.name.substring(0, 8) + '...' : this.currentMusic?.name,
                    this.currentMusic?.name.length > 16 ? this.currentMusic?.name.substring(0, 16) + '...' : this.currentMusic?.name,
                    this.currentMusic?.name.length > 20 ? this.currentMusic?.name.substring(0, 20) + '...' : this.currentMusic?.name,
                    this.currentMusic?.name.length > 25 ? this.currentMusic?.name.substring(0, 25) + '...' : this.currentMusic?.name
                  ).getValue(this.currentWidthBreakPoint)).fontSize(10)
                  Text(' - ' + this.currentMusic?.artists[0].name).fontColor('#ff888181').fontSize(8).margin({right: 10})
                Blank()
                //Math.floor(x) 返回小于参数x的最大整数---取整
                //Math.round(x) 返回最接近参数x的整数（四舍五入）
                //Math.round(this.time/1000)----转化为秒级精度
                //Math.floor(秒数/60)-----计算分钟部分
                Text(Math.floor(Math.round(this.time / 1000) / 60) + ':'
                  + (Math.round(this.time / 1000) % 60)).fontColor('#bbbbbb')
                Text(' / ').fontColor('#bbbbbb')
                Text(Math.floor(Math.round(this.duration / 1000) / 60) + ':'
                  + (Math.round(this.duration / 1000) % 60)).fontColor('#bbbbbb')
              }
            }.width('100%')

            //md/lg/xl尺寸
            if (this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_LG ||
              this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_XL ||
              this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_MD) {
              Progress({ value: this.time, total: this.duration })
            }
          }.width('55%')

          Blank()
          Row({ space: 10 }) {
            if (this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_LG ||
              this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_XL ||
              this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_MD) {
              SymbolGlyph($r('sys.symbol.backward_end_fill')).fontSize(22)
                .onClick(() => {
                  AVPlayerHelper.playLastMusic()
                })
            }
            if (this.avPlayerState == 'playing') {
              SymbolGlyph($r('sys.symbol.pause')).fontSize(22)
                .onClick(() => {
                  AVPlayerHelper.avPlayer?.pause()
                })
            } else {
              SymbolGlyph($r('sys.symbol.play_fill')).fontSize(22)
                .onClick(() => {
                  AVPlayerHelper.avPlayer?.play()
                })
            }
            if (this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_LG ||
              this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_XL ||
              this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_MD) {
              SymbolGlyph($r('sys.symbol.forward_end_fill')).fontSize(22)
                .onClick(() => {
                  AVPlayerHelper.playNextMusic()
                })
            }
            SymbolGlyph($r('sys.symbol.music_note_list')).fontSize(22)
          }
          .margin({ right: 20 })

        }
        .width('98%')
        .height('56vp')
        .backgroundColor('#ffffff')
        .borderRadius('25vp')
        .margin({ bottom: (this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_LG ||
          this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_XL ||
          this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_MD) ? 0 : 60})
      }
    }
    .height('100%')
    .width('100%')
  }

  @Builder
  PlayViewHeader(){
    Row() {
      SymbolGlyph($r('sys.symbol.chevron_down')).fontSize(25).fontColor(['#cccccc'])
        .onClick(()=>{
          this.isPlayViewShow = !this.isPlayViewShow
        })
    }.width('100%')
    .margin({left: 20,top: 10})
  }

  @Builder
  PlayViewAlbumImage(){
    Column(){
      Image(this.currentMusic == undefined ? $r('app.media.icon') : this.currentMusic?.album?.blurPicUrl)
        .width('280vp').height('280vp')
        .borderRadius(10)
    }.width('100%')
    .padding(20)
  }

  @Builder
  PlayViewTitle(){
    Row() {
      Column(){
        Text(this.currentMusic ? this.currentMusic.name : 'Dream It Possible').fontSize(20).fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
        Text(this.currentMusic ? this.currentMusic.artists[0].name : 'Dele').fontSize(15).fontColor('#cccccc')
      }.width('90%')
      .alignItems(HorizontalAlign.Start)
      Blank()
      SymbolGlyph($r('sys.symbol.heart')).fontSize(24).fontColor(['#cccccc'])
    }
    .width('100%')
    .padding(20)
  }

  timeToString(time:number){    //用Math.trunc()确保取整数部分（丢弃小数位）
    //通过padStart(2, '0')方法保证两位数显示：
    //小于10的数值自动补零（如5→05）
    let minute:string = Math.trunc(time/1000/60).toString().padStart(2, '0') //（整除获取分钟数）
    let second:string = Math.trunc(time/1000%60).toString().padStart(2, '0') //（取模获取剩余秒数）
    return `${minute}:${second}`
  }

  @Builder
  PlayViewControl(){
    Column(){
      Row() {
        SymbolGlyph($r('sys.symbol.music_note_list')).fontSize(25).fontColor(['#cccccc'])
        SymbolGlyph($r('sys.symbol.arrow_down_and_car')).fontSize(25).fontColor(['#cccccc'])
        SymbolGlyph($r('sys.symbol.bell_fill')).fontSize(25).fontColor(['#cccccc'])
        SymbolGlyph($r('sys.symbol.more')).fontSize(25).fontColor(['#cccccc'])
      }.width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Column(){
        //播放进度
        Slider({
          value:this.time,
          max:this.duration
        }).width('100%')
          .onChange((t)=>{
            AVPlayerHelper.avPlayer?.seek(t)
          })

        //时长
        Row(){
          Text(this.timeToString(this.time)).fontSize(13).fontColor('#cccccc')
          Blank()
          Text(this.timeToString(this.duration)).fontSize(13).fontColor('#cccccc')
        }.width('100%')

        Row(){
          SymbolGlyph($r('sys.symbol.backward_end_fill')).fontSize(40).fontColor([Color.White])
            .onClick(() => {
              AVPlayerHelper.playLastMusic()
            })
          if (this.avPlayerState == 'playing') {
            SymbolGlyph($r('sys.symbol.pause')).fontSize(40).fontColor([Color.White])
              .onClick(() => {
                AVPlayerHelper.avPlayer?.pause()
              })
          } else {
            SymbolGlyph($r('sys.symbol.play_fill')).fontSize(40).fontColor([Color.White])
              .onClick(() => {
                AVPlayerHelper.avPlayer?.play()
              })
          }
          SymbolGlyph($r('sys.symbol.forward_end_fill')).fontSize(40).fontColor([Color.White])
            .onClick(() => {
              AVPlayerHelper.playNextMusic()
            })
        }.width('100%')
        .justifyContent(FlexAlign.SpaceAround)

      }.width('100%')
    }.width('100%')
    .padding(20)
  }

  //全模态窗视图设计
  @Builder
  PlayView(){
    Column(){
      if(this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_SM){
        this.PlayViewHeader()
        Swiper(){
          Column({space:10}){
            this.PlayViewAlbumImage()
            this.PlayViewTitle()
            this.PlayViewControl()
          }.width('100%')
          Column(){
            // this.PlayViewLrc()
            // this.PlayViewLrcSetting()
          }.width('100%')
        }.indicator(false)
      }else if(this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_MD || this.currentWidthBreakPoint == WidthBreakpoint.WIDTH_LG){
        this.PlayViewHeader()
        GridRow({
          columns: { xs: 4, sm:4, md:8,lg:12, xl:12}
        }){
          GridCol({
            span:{xs: 4, sm:4, md:4, lg:4, xl:4},
            offset:new WidthBreakpointType(0,0,0,1,1)
              .getValue(this.currentWidthBreakPoint)
          }){
            this.PlayViewAlbumImage()
            this.PlayViewTitle()
            this.PlayViewControl()
          }
          GridCol({
            span:{xs: 4, sm:4, md:4, lg:6, xl:6},
            offset:new WidthBreakpointType(0,0,0,1,1)
              .getValue(this.currentWidthBreakPoint)
          }){
            // this.PlayViewLrc()
            // this.PlayViewLrcSetting()
          }
        }
      }
    }
    .width('100%')
    .height('100%')
    .padding({top:40})
    .backgroundColor('#A3706F')
    .expandSafeArea([SafeAreaType.SYSTEM],[SafeAreaEdge.BOTTOM])
  }
}

