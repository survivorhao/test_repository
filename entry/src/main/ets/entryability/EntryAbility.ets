import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      this.getWindowBreakpoint(windowStage)
    });
  }
  getWindowBreakpoint(windowStage:window.WindowStage){
    //获取当前设备屏幕的断点（xs、sm、md、lg、xl）
    //通过 windowStage.getMainWindow()异步获取主窗口实例(ArkUI的窗口管理能力)
    windowStage.getMainWindow().then((data:window.Window)=>{
      let uiConext = data.getUIContext()        //获取应用当前主窗口UI上下文对象
      //WidthBreakpoint.WIDTH_XS、WIDTH_SM、WIDTH_MD、WIDTH_LG、WIDTH_XL
      let widthBreakPoint:WidthBreakpoint = uiConext.getWindowWidthBreakpoint()
      //HeightBreakpoint.HEIGHT_SM 、 HEIGHT_MD 、HEIGHT_LG
      let heightBreakPoint:HeightBreakpoint = uiConext.getWindowHeightBreakpoint()

      //将获取到的横向断点和纵向断点存储到AppStorage     [区别LocalStorage---页面间的共享，AppStorage--整个应用进程内的共享]
      AppStorage.setOrCreate('widthBreakPoint',widthBreakPoint)
      AppStorage.setOrCreate('heightBreakPoint',heightBreakPoint)

      //订阅屏幕尺寸变化事件
      data.on('windowSizeChange',()=>{
        let widthBreakPoint:WidthBreakpoint = uiConext.getWindowWidthBreakpoint()
        //HeightBreakpoint.HEIGHT_SM 、 HEIGHT_MD 、HEIGHT_LG
        let heightBreakPoint:HeightBreakpoint = uiConext.getWindowHeightBreakpoint()
        //将获取到的横向断点和纵向断点存储到AppStorage
        AppStorage.setOrCreate('widthBreakPoint',widthBreakPoint)
        AppStorage.setOrCreate('heightBreakPoint',heightBreakPoint)
      })
    })
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}