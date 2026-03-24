
@Component
export struct Mine {
  @Consume pathStack:NavPathStack
  @StorageLink("c") flag:boolean = false
  @StorageLink("msg") isBoFangKuang:boolean = true

  build() {
    Column() {
      Column() {
        Row() {
          Image($r('app.media.cai_dan'))
            .width(24)
            .height(24)
            .fillColor(Color.White)

          Blank()

          Image($r('app.media.search'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .onClick(()=>{
              this.pathStack.pushPath({
                name: 'SearchPage'
              })
            })

          Image($r('app.media.san_dian'))
            .width(24)
            .height(24)
            .fillColor(Color.White)
            .margin({left:10})
        }
        .width('100%')
        .padding({ left: 15, right: 15, top: 10, bottom: 10 })

        // 头像和登录按钮
        Column({ space: 10 }) {
          // 头像
          Image($r('app.media.my'))
            .width(80)
            .height(80)
            .borderRadius(40)
            .border({ width: 2, color: Color.White })
            .backgroundColor('#FFE4E1')

          if(!this.flag) {
            Row({ space: 5 }) {
              Text('立即登录')
                .fontSize(16)
                .fontColor(Color.White)

              Image($r('sys.media.ohos_ic_public_arrow_right'))
                .width(16)
                .height(16)
                .fillColor(Color.White)
            }
            .padding({
              left: 20,
              right: 20,
              top: 10,
              bottom: 10
            })
            .onClick(() => {
              this.isBoFangKuang = false
              this.pathStack.pushPath({
                name: 'Login'
              })
            })
          }
          if(this.flag){
            Row({ space: 5 }) {
              Text('退出登录')
                .fontSize(16)
                .fontColor(Color.White)

              Image($r('sys.media.ohos_ic_public_arrow_right'))
                .width(16)
                .height(16)
                .fillColor(Color.White)
            }
            .padding({
              left: 20,
              right: 20,
              top: 10,
              bottom: 10
            })
            .onClick(() => {
              this.flag = false
            })
          }
        }
        .margin({ top: 20 })

        // 功能按钮行
        Row({ space: 15 }) {
          this.FunctionButton('最近', $r('sys.media.ohos_ic_public_clock'))
          this.FunctionButton('本地', $r('app.media.ben_di'))
          this.FunctionButton('网盘', $r('app.media.wang_pan'))
          this.FunctionButton('装扮', $r('app.media.dress_up'))
          this.FunctionButton('', $r('app.media.foreground'))
        }
        .width('100%')
        .padding({ left: 10, right: 10, top: 20 })
        .justifyContent(FlexAlign.Center)

        // 广告横幅
        Row({ space: 10 }) {
          Text('VIP')
            .fontSize(12)
            .fontColor('#666666')
            .backgroundColor('#E0E0E0')
            .borderRadius(4)
            .padding({ left: 6, right: 6, top: 3, bottom: 3 })

          Text('专属福利！1分钱领7天VIP！点击前往')
            .fontSize(14)
            .fontColor('#666666')
            .layoutWeight(1)

          Image($r('sys.media.ohos_ic_public_arrow_right'))
            .width(16)
            .height(16)
            .fillColor('#666666')
        }
        .width('100%')
        .padding({ left: 15, right: 15, top: 15, bottom: 15 })
        .backgroundColor('#2D1F1F')
        .borderRadius(8)
        .margin({ left: 15, right: 15, bottom: 20 })
      }
      .width('100%')
      .backgroundColor('#3D2B2B')

      Column() {
        Tabs({ barPosition: BarPosition.Start }) {
          TabContent() {
            // 歌单列表
            List() {
              // 我喜欢的音乐
              ListItem(){
                Row({ space: 10 }) {
                  Image($r('app.media.a'))
                    .width(70)
                    .height(70)
                    .fillColor('#666666')
                  Column({ space: 5 }) {
                    Text('我喜欢的音乐')
                      .fontSize(20)
                      .fontColor('#333333')
                    Text('0首')
                      .fontSize(15)
                      .fontColor('#999999')
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()
                  Row({ space: 5 }) {
                    Image($r('app.media.love'))
                      .width(16)
                      .height(16)
                      .fillColor('#FC3D49')

                    Text('心动模式')
                      .fontSize(12)
                      .fontColor('#FC3D49')
                  }
                  .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  .backgroundColor('#F5F5F5')
                  .borderRadius(15)
                }
                .width('100%')
                .padding({ left: 15, right: 15, top: 15, bottom: 15 })
                .backgroundColor(Color.White)
              }

              // 新建歌单
              ListItem(){
                Row({ space: 10 }) {
                  Image($r('app.media.b'))
                    .width(70)
                    .height(70)
                    .fillColor('#666666')
                  Text('新建歌单')
                    .fontSize(20)
                    .fontColor('#333333')

                  Text('NEW')
                    .fontSize(13)
                    .fontColor(Color.White)
                    .backgroundColor('#FC3D49')
                    .borderRadius({
                      topLeft: 4,
                      bottomRight: 4,
                      topRight: 4,
                      bottomLeft: 4
                    })
                    .padding({ left: 6, right: 6, top: 3, bottom: 3 })
                }
                .width('100%')
                .padding({ left: 15, right: 15, top: 15, bottom: 15 })
                .backgroundColor(Color.White)
              }

              // 导入外部歌单
              ListItem(){
                Row() {
                  Row({ space: 10 }) {
                    Image($r('app.media.c'))
                      .width(70)
                      .height(70)
                      .fillColor('#666666')

                    Column({ space: 5 }) {
                      Text('导入外部歌单')
                        .fontSize(20)
                        .fontColor('#333333')

                      Text('轻松导入其他APP里的歌单')
                        .fontSize(15)
                        .fontColor('#999999')
                    }
                    .alignItems(HorizontalAlign.Start)
                  }
                  .layoutWeight(1)
                }
                .width('100%')
                .padding({ left: 15, right: 15, top: 15, bottom: 15 })
                .backgroundColor(Color.White)
              }

              ListItem(){
                Row() {
                  Row({ space: 10 }) {
                    Image($r('app.media.c'))
                      .width(70)
                      .height(70)
                      .fillColor('#666666')

                    Column({ space: 5 }) {
                      Text('导入外部歌曲')
                        .fontSize(20)
                        .fontColor('#333333')

                      Text('轻松导入本地歌曲')
                        .fontSize(15)
                        .fontColor('#999999')
                    }
                    .alignItems(HorizontalAlign.Start)
                  }
                  .layoutWeight(1)
                }
                .width('100%')
                .padding({ left: 15, right: 15, top: 15, bottom: 15 })
                .backgroundColor(Color.White)
              }
            }
          }
          .tabBar('音乐')

          TabContent() {
            List() {
              ListItem() {
                Text('播客内容')
                  .fontSize(16)
                  .fontColor('#666666')
              }
            }
            .width('100%')
            .height('100%')
          }
          .tabBar('播客')

          TabContent() {
            List() {
              ListItem(){
                Text('笔记内容')
                  .fontSize(16)
                  .fontColor('#666666')
              }
            }
            .width('100%')
            .height('100%')
          }
          .tabBar('笔记')
        }
        .width('100%')
        .height('100%')
        .barHeight(60)
        .barMode(BarMode.Fixed)
      }
      .margin({bottom: 55})
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F8F8F8')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8F8F8')
  }

  @Builder
  FunctionButton(title: string, icon: Resource) {
    Row({ space: 3 }) {
      Image(icon)
        .width(24)
        .height(24)
        .fillColor('#ffffffff')

      if (title) {
        Text(title)
          .fontSize(15)
          .fontColor('#ffffffff')
      }
    }
    .backgroundColor('#ff754545')
    .padding(3)
  }
}