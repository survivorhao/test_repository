import { UserAuth } from '../models/userAuth'
import { AppStorageV2 } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'
import picker from '@ohos.file.picker';

interface AccountInfo {
  label: string
  value: string
}

@CustomDialog
struct EditTagsDialog {
  controller: CustomDialogController
  initialTags: string = ""
  onConfirm: (newTags: string) => void = () => {}
  @State tempTags: string = ''

  aboutToAppear() {
    this.tempTags = this.initialTags
  }

  build() {
    Column() {
      Text('修改个人标签')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 20, bottom: 20 })
      
      TextInput({ text: this.tempTags, placeholder: '请输入标签，用空格分隔' })
        .onChange((value: string) => {
          this.tempTags = value
        })
        .margin({ bottom: 20 })
        .width('90%')
        .height(50)
        .backgroundColor('#F5F5F5')
        .borderRadius(8)

      Row() {
        Button('取消')
          .onClick(() => {
            this.controller.close()
          })
          .backgroundColor('#CCCCCC')
          .margin({ right: 20 })
          .width(100)
        
        Button('确定')
          .onClick(() => {
            this.onConfirm(this.tempTags)
            this.controller.close()
          })
          .backgroundColor('#E85A88')
          .width(100)
      }
      .margin({ bottom: 20 })
    }
    .backgroundColor(Color.White)
    .borderRadius(16)
    .width('80%')
  }
}

@ComponentV2
export struct Mind {
  @Param pathStack: NavPathStack = new NavPathStack()
  
  userAuth: UserAuth = AppStorageV2.connect(UserAuth, 'USER_AUTH', () => new UserAuth())!
  
  @Local isBgExpanded: boolean = false
  @Local isAvatarExpanded: boolean = false

  private accountList: AccountInfo[] = [
    { label: '关注', value: '1' },
    { label: '粉丝', value: '100万' },
    { label: '赞', value: '1.67亿' }
  ]

  dialogController: CustomDialogController = new CustomDialogController({
    builder: EditTagsDialog({
      initialTags: this.userAuth.tags,
      onConfirm: (newTags: string) => {
        const context = getContext(this) as common.UIAbilityContext
        this.userAuth.saveTags(newTags, context)
      }
    }),
    alignment: DialogAlignment.Center,
    autoCancel: true,
    customStyle: false
  })

  async pickImage(type: 'bg' | 'avatar') {
    try {
      const photoPicker = new picker.PhotoViewPicker();
      const result = await photoPicker.select({
        MIMEType: picker.PhotoViewMIMETypes.IMAGE_TYPE,
        maxSelectNumber: 1
      });
      if (result.photoUris.length > 0) {
        const uri = result.photoUris[0];
        const context = getContext(this) as common.UIAbilityContext;
        if (type === 'bg') {
          await this.userAuth.saveBgImage(uri, context);
        } else {
          await this.userAuth.saveAvatarImage(uri, context);
        }
      }
    } catch (e) {
      console.error('Pick image failed', e);
    }
  }

  handleLogout() {
    const context = getContext(this) as common.UIAbilityContext
    this.userAuth.logout(context)
    // 退出后清空栈并跳转到启动页（显示登录和注册按钮）
    if (this.pathStack) {
        this.pathStack.clear()
        this.pathStack.pushPathByName("Start", null, false)
    }
  }

  build() {
    Stack() {
      Column() {
        // 上半部分：图片区域 + 个人信息 70%
        Stack({ alignContent: Alignment.Bottom }) {
          // 背景大图
          Image(this.userAuth.bgImage || $r('app.media.bg_mine'))
            .width('100%')
            .height('100%')
            .objectFit(ImageFit.Cover)
            .onClick(() => {
              this.isBgExpanded = true
            })

          // 退出登录按钮 (右上角)
        Row() {
           Text('退出登录')
             .fontSize(14)
             .fontColor(Color.White)
             .padding({ top: 6, bottom: 6, left: 12, right: 12 })
             .backgroundColor('#E85A88') // 更明亮的粉色背景
             .borderRadius(15)
             .onClick(() => {
               this.handleLogout()
             })
        }
        .position({ x: '100%', y: 20 })
        .markAnchor({ x: '100%', y: 0 })
        .offset({ x: -20, y: 0 })
        .zIndex(1)

        // 底部居中 logo 和 用户名
        Column({ space: 10 }) {
          Image(this.userAuth.avatarImage || $r('app.media.logo5'))
            .width(100)
            .height(100)
            .borderRadius(50)
            .border({ width: 2, color: Color.White })
            .onClick(() => {
              this.isAvatarExpanded = true
            })
          
          // 用户名
          Row() {
            Blank()
              .width(34) // 占位符，宽度 = icon宽度(24) + margin(10)
            
            Text(this.userAuth.username || 'WHU云音乐')
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
                .shadow({ radius: 5, color: 'rgba(0,0,0,0.5)', offsetX: 2, offsetY: 2 })
            
            Image($r('app.media.ic_more'))
                .width(24)
                .height(24)
                .fillColor(Color.White)
                .margin({ left: 10 })
                .bindMenu([
                    {
                        value: '修改用户名',
                        action: () => {
                            this.pathStack.pushPathByName("EditUsername", null, false)
                        }
                    },
                    {
                        value: '修改密码',
                        action: () => {
                            this.pathStack.pushPathByName("EditPassword", null, false)
                        }
                    }
                ])
          }
        }
        .alignItems(HorizontalAlign.Center)
        .margin({ bottom: 40 })
      }
      .width('100%')
      .layoutWeight(6) // 调整比例

      // 下半部分：标签与数据 40%
      Column({ space: 20 }) {
        
        // 用户标签 (可编辑)
        Row({ space: 8 }) {
          Text(this.userAuth.tags || '暂无标签')
            .fontSize(16) // 稍微加大字号
            .fontWeight(FontWeight.Bold) // 加粗
            .fontColor(Color.White) // 纯白
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
          
          Image($r('app.media.ic_more'))
            .width(20)
            .height(20)
            .opacity(0.8)
            .fillColor('#E85A88') 
            .onClick(() => {
               this.dialogController = new CustomDialogController({
                builder: EditTagsDialog({
                  initialTags: this.userAuth.tags,
                  onConfirm: (newTags: string) => {
                    const context = getContext(this) as common.UIAbilityContext
                    this.userAuth.saveTags(newTags, context)
                  }
                }),
                alignment: DialogAlignment.Center,
                autoCancel: true
              })
              this.dialogController.open()
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ left: 40, right: 40 })

        // 账户信息：关注、粉丝、点赞
        Row() {
          ForEach(this.accountList, (item: AccountInfo, index: number) => {
            Column({ space: 8 }) {
              Text(item.value)
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#CCCCCC') // 变暗淡一点
              Text(item.label)
                .fontSize(14)
                .fontColor("#666666") // 变暗淡一点
            }
            .layoutWeight(1) // 均分空间
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceAround)
        .margin({ top: 10 })
      }
      .padding({ top: 30, bottom: 20 })
      .layoutWeight(4) // 调整比例
      .backgroundColor('#131313') // 深色背景衔接
      .borderRadius({ topLeft: 24, topRight: 24 }) // 圆角过渡
      .margin({ top: -20 }) // 向上重叠一点，制造层级感
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
    .expandSafeArea()

    // 背景图全屏预览
    if (this.isBgExpanded) {
      Stack() {
        Image(this.userAuth.bgImage || $r('app.media.bg_mine'))
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Contain)
          .backgroundColor(Color.Black)
          .onClick(() => {
            this.isBgExpanded = false
          })
        
        // 更多操作按钮
        Image($r('app.media.ic_more'))
          .width(30)
          .height(30)
          .fillColor(Color.White)
          .position({ top: 50, right: 20 })
          .onClick(() => {
            this.pickImage('bg')
          })
      }
      .width('100%')
      .height('100%')
      .zIndex(999)
      .expandSafeArea()
    }

    // 头像全屏预览
    if (this.isAvatarExpanded) {
      Stack() {
        Image(this.userAuth.avatarImage || $r('app.media.logo5'))
          .width('100%')
          .objectFit(ImageFit.Contain)
          .backgroundColor(Color.Black)
          .onClick(() => {
            this.isAvatarExpanded = false
          })
        
        // 更多操作按钮
        Image($r('app.media.ic_more'))
          .width(30)
          .height(30)
          .fillColor(Color.White)
          .position({ top: 50, right: 20 })
          .onClick(() => {
            this.pickImage('avatar')
          })
      }
      .width('100%')
      .height('100%')
      .zIndex(999)
      .backgroundColor(Color.Black)
      .expandSafeArea()
    }
  }
}
}