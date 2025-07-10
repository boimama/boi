import router from '@ohos.router';
@Entry
@Component



struct LoadingPage {
  @State showSeconds: number = 3;//3秒跳转
  private timerId: number = -1;//定时器id
  @State num: number = 0
  @State numZ: number = 100
  @State twonum: number = 90
  @State twonumZ: number = 90
  @State treenum: number = 180
  @State treenumZ: number = 90
  @State formnum: number = 270
  @State formnumZ: number = 270



  onPageShow(): void {
    console.log('页面触发')
    animateTo({
      duration: 2000,
      iterations: -1,
      curve: Curve.Linear
    }, () => {
      this.num = 360
      this.numZ = 470
      this.twonum = 450
      this.twonumZ = 470
      this.treenum = 480
      this.treenumZ = 450
      this.formnum = 610
      this.formnumZ = 630
    })

  }

  build() {
    Stack() {
      //一
      Row() {
      }
      .width(190)
      .height(190)
      .border({ width: { bottom: 8 }, color: 'rgb(255, 141, 249)', style: BorderStyle.Solid })
      .borderRadius(90)
      .rotate({
        x: 50,
        y: 0,
        z: this.numZ,
        angle: this.num,
        centerX: 80,
        centerY: 80,
      })
      //二
      Row() {
      }
      .width(190)
      .height(190)
      .border({ width: { bottom: 8 }, color: 'rgb(255, 65, 106)', style: BorderStyle.Solid })
      .borderRadius(90)
      .rotate({
        x: 20,
        y: 50,
        z: this.twonumZ,
        angle: this.twonum,
        centerX: 80,
        centerY: 80,
      })
      //三
      Row() {
      }
      .width(190)
      .height(190)
      .border({ width: { bottom: 8 }, color: 'rgb(0, 255, 255)', style: BorderStyle.Solid })
      .borderRadius(90)
      .rotate({
        x: 40,
        y: 150,
        z: this.treenumZ,
        angle: this.treenum,
        centerX: 80,
        centerY: 80,
      })
      //四
      Row() {
      }
      .width(190)
      .height(190)
      .border({ width: { bottom: 8 }, color: 'rgb(252, 183, 55)', style: BorderStyle.Solid })
      .borderRadius(90)
      .rotate({
        x: 70,
        y: 0,
        z: this.formnumZ,
        angle: this.formnum,
        centerX: 80,
        centerY: 80,
      })

      Row() {
        Text('登录加载中...')
          .fontColor(Color.Black)
      }
    }
    .onClick(() => {
      router.pushUrl({
        url: 'pages/MainPage'
      })
    })

    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff')
  }
  aboutToAppear(){
    this.timerId = setInterval(()=>{
      if(this.showSeconds >0 ){
        this.showSeconds --;

      }else {
        clearInterval(this.timerId)
        router.pushUrl({
          url:'pages/MainPage'
        })
      }
    },1000)
  }
}





