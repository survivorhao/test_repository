import { router } from '@kit.ArkUI'
@Builder

export function LoginBuilder(name:string, props?:object){
  Login()
}

@Component
struct Login {
  @State phoneNumber:string=''
  @State password:string=''
  @StorageLink("a") register_pn:string='1'
  @StorageLink("b") register_pw:string='2'
  @State isShowSheet:boolean=false
  pathStack:NavPathStack=new NavPathStack()
  @StorageLink("c") flag:boolean = false   //登录成功标志
  @StorageLink("msg") isBoFangKuang:boolean = false

  @Builder
  SheetBuilder() {
    Column({space: 15}) {
      Text('sanlf')
    }
  }

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height('48vp')
    .width('48vp')
    .backgroundColor(Color.White)
    // .backgroundColor('#F1F3F5')
    .onClick(() => {
      // this.isShowSheet = !this.isShowSheet;
      this.isShowSheet = true;
    })

  }

  build() {
    NavDestination() {
      Column({ space: 15 }) {
        Image($r('app.media.startIcon')).height(100).margin({ top: 40 })
          .objectFit(ImageFit.Contain)

        Text('登录界面')
          .fontSize(30)
          .fontWeight(500)
        Text('登录账号以使用更多服务')
          .fontColor(Color.Gray)
          .margin({ bottom: 40 })

        TextInput({ placeholder: '账号' })    //&&this.phoneNumber----$$为双向绑定
          .maxLength(11)
          .type(InputType.Number)
          .height(50)
          .fontSize(20)
          .onChange((value: string) => {
            this.phoneNumber = value
          })
          .onSubmit(() => {
            console.log('账号：', this.phoneNumber)
          })
        /*绑定onChange事件可以获取输入框内改变的文本内容，
         绑定onSubmit事件可以获取回车提交的文本信息*/
        TextInput({ placeholder: '密码' })
          .maxLength(16)
          .type(InputType.Password)
          .height(50)
          .fontSize(20)
          .onChange((value: string) => {
            this.password = value
          })
          .onSubmit(() => {
            console.log('密码：', this.password)
          })
          .margin({ top: 5, bottom: 10 })

        Row({ space: 10 }) {
          Text('短信验证码登录')
            .textAlign(TextAlign.End)
            // .margin({right: 150})
            .fontColor('#ff02acff')

          Text('忘记密码')
            .textAlign(TextAlign.End)
            .fontColor('#ff02acff')
        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceBetween)

        Button('登录', { type: ButtonType.Normal })
          .width('95%')
          .height(50)
          .margin({ top: 20 })
          .borderRadius(10)
          .backgroundColor('#ff027fff')
          .margin({ bottom: 10 })
          .onClick(() => {
            // console.log(this.phoneNumber, this.password, this.register_pn, this.register_pw)
            if (this.phoneNumber === this.register_pn && this.password === this.register_pw) {
              this.flag = true
              this.getUIContext().getPromptAction().showToast({ message: '登录成功', duration: 2000 })
              //页面跳转
              // router.pushUrl({
              //   url: 'pages/Index'   //这里的url指定是指定你接下来要跳转的页面名称
              //   // url: 'pages/Test'
              // })
              // this.pathStack.popToIndex(1)
              this.pathStack.pop()
              this.isBoFangKuang = true
            } else {
              this.getUIContext().getPromptAction().showToast({
                message: '账号或密码错误', duration: 2000, textColor: Color.Red
              })
            }
          })

        Text('注册账号')
          .fontColor('#ff02acff')
          .onClick(()=>{
            this.pathStack.pushPath({
              name: 'Register'
              // console.log(this.register_pn)
            })
          })

        Column({ space: 15 }) {
          Text('其他登录方式')
            .fontColor(Color.Gray)
            .fontSize(15)

          Row({ space: 44 }) {
            this.imageButton($r('app.media.QQ'))
            this.imageButton($r('app.media.WX'))
            this.imageButton($r('app.media.WB'))
            //使用半模态弹窗
          }
        }.margin({ top: 70 })
      }
      .height('100%')
      .width('100%')
      // .backgroundColor('#f1f3f5')
      .bindSheet($$this.isShowSheet, this.SheetBuilder(), {
        detents: [SheetSize.MEDIUM, SheetSize.LARGE, 600],
        preferType: SheetType.BOTTOM,
        // title: { title: $r('app.media.banner_pic1') }
      })
    }.hideTitleBar(true)
    .onReady(context=>{   //在页面准备完成时执行--生命周期回调
      //从上下文中获取pathStack对象
      //这一步一定要写，无Page0ne数据，PageThree无法访问
      this.pathStack=context.pathStack
    })
  }
}

