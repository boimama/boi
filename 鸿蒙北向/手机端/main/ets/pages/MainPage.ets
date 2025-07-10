import { TabID, TabItemList } from '../model/Tabltem';
// import {Ctrl} from '../view/Ctrl';
// import {AI} from '../view/AI';
import {DetectorComponent} from '../view/DetectorComponent';
import {DeviceSearchComponent} from '../view/DeviceSearchComponent';
import { MineComponent } from '../view/MineComponent';

@Entry
@Component
struct MainPage {

  @State pageIndex: number = 0;//页面索引
  private tabController: TabsController = new TabsController();//tab切换控制器


  build() {

    Tabs({barPosition:BarPosition.End}){



      TabContent(){
        DetectorComponent()//调用设备搜索组件
      }
      .tabBar('设备控制')
      .tabBar(this.MyTabBuilder(TabID.SEARCH_DEVICE))//调用自定义的TabBar
      TabContent(){
        //Text('检测仪 ')
        DeviceSearchComponent()
      }
      .tabBar('检测仪')
      .tabBar(this.MyTabBuilder(TabID.DETECTOR))//调用自定义的TabBar
      // TabContent(){
      //   //Text('AI ')
      //   AI()
      // }
      // //.tabBar('AI')
      // .tabBar(this.MyTabBuilder(TabID.AI))//调用自定义的TabBar
      // TabContent(){
      //   Text('我的')
      //   Ctrl();//我的页面
      // }
      // .tabBar('我的')
      // .tabBar(this.MyTabBuilder(TabID.CKT))//调用自定义的TabBar

      TabContent(){
        MineComponent();//我的页面
      }
      .tabBar('我的')
      .tabBar(this.MyTabBuilder(TabID.MINE))//调用自定义的TabBar

    }
    .vertical(false)
    .scrollable(true)
    .barWidth('100%')
    .barMode(BarMode.Fixed)
    .width('100%')
    .height('100%')
    .onChange((index)=>{
      this.pageIndex = index;
    })

  }

  @Builder MyTabBuilder(idx: number){
    Column(){
      Image(idx === this.pageIndex ? TabItemList[idx].icon_selected : TabItemList[idx].icon)
        .width(32)
        .height(32)
      Text(TabItemList[idx].title)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.pageIndex === idx ? '#006eee':'#888')
    }
  }
}