
@Builder
export function RegisterBuilder(name:string, props?:object){
  Register()
}

@Component
struct Register {
  pathStack:NavPathStack=new NavPathStack()
  @StorageLink("a") register_pn:string=''
  @StorageLink("b") register_pw:string=''
  @State register_pw1:string=''
  @State flag:boolean=false

  build() {
    NavDestination(){
      Column({space:15}){
        Image($r('app.media.startIcon')).height(100).margin({ top: 40 })
          .objectFit(ImageFit.Contain)

        Text('注册界面')
          .fontSize(30)
          .fontWeight(500)
          .margin({ bottom: 40 })

        TextInput({ placeholder: '请输入账号' })    //$$为双向绑定
          .maxLength(11)
          .type(InputType.Number)
          .height(50)
          .fontSize(20)
          .onChange((value: string) => {
            this.register_pn = value
          })
          .onSubmit(() => {
            console.log('账号：', this.register_pn)
          })
        /*绑定onChange事件可以获取输入框内改变的文本内容，
         绑定onSubmit事件可以获取回车提交的文本信息*/
        TextInput({ placeholder: '请输入密码' })
          .maxLength(16)
          .type(InputType.Password)
          .height(50)
          .fontSize(20)
          .onChange((value: string) => {
            this.register_pw = value
          })
          .onSubmit(() => {
            console.log('密码：', this.register_pw)
          })
          .margin({ top: 10})

        TextInput({ placeholder: '请确认密码', text: this.register_pw1 })
          .maxLength(16)
          .type(InputType.Password)
          .height(50)
          .fontSize(20)
          .onChange((value: string) => {
            this.register_pw1 = value
          })
          .margin({ top: 10, bottom: 20 })

        Button('注册')
          .width('30%')
          .margin({ top: 10, bottom: 20 })
          .onClick(() => {
            // console.log(this.register_pn, this.register_pw)
            if(this.register_pw1==this.register_pw){
              this.flag=true
            }else {
              this.flag = false
              this.getUIContext().getPromptAction().showToast({ message: '密码不一致', duration: 2000 , textColor: Color.Red})
              // console.log('密码不一致')
            }
            if(this.flag) {
              this.getUIContext().getPromptAction().showToast({ message: '注册成功', duration: 2000 })
              // console.log('注册成功')
              this.pathStack.pop()
            }
          })

      }.width('100%')
      .height('100%')
    }.hideTitleBar(true)
    .onReady(context=>{   //在页面准备完成时执行--生命周期回调
      //从上下文中获取pathStack对象
      //这一步一定要写，无Page0ne数据，PageThree无法访问
      this.pathStack=context.pathStack
    })
  }
}