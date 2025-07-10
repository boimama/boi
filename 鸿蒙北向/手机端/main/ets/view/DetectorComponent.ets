import http from '@ohos.net.http';

// 创建一个 HTTP 请求对象
let httpRequest = http.createHttp();

// 修改回调类型为 string | null
function sendGetRequest(url: string, callback: (result: string | null) => void): void {
  let req = httpRequest;
  req.request(
    url, // 请求地址
    {
      method: http.RequestMethod.GET,
    },
    (err, data) => {
      if (!err) {
        // 成功获取响应数据
        console.info('Response code: ' + data.responseCode);
        let result = data.result as string;
        console.info('Response data: ' + result);
        callback(result);
      } else {
        // 请求失败
        console.error('Request failed: ' + JSON.stringify(err));
        callback(null); // 现在可以传 null 了
      }
    }
  );
}

// 控制灯光打开
export function lightOpen(): void {
  const url = "http://10.219.63.89:5000/api/device/shadow/light_open";
  sendGetRequest(url, (response) => {
    if (response) {
      console.info("灯光已打开");
    }
  });
}

// 控制灯光关闭
export function lightClose(): void {
  const url = "http://10.219.63.89:5000/api/device/shadow/light_close";
  sendGetRequest(url, (response) => {
    if (response) {
      console.info("灯光已关闭");
    }
  });
}

// 控制电机打开
export function motorOpen(): void {
  const url = "http://10.219.63.89:5000/api/device/shadow/motor_open";
  sendGetRequest(url, (response) => {
    if (response) {
      console.info("电机已启动");
    }
  });
}

// 控制电机关闭
export function motorClose(): void {
  const url = "http://10.219.63.89:5000/api/device/shadow/motor_close";
  sendGetRequest(url, (response) => {
    if (response) {
      console.info("电机已停止");
    }
  });
}

@Entry
@Component
export struct DetectorComponent {
  build() {
    Scroll() {
      Column() {
        Row() {
          Row() {
            // Image($r('app.media.local'))
            //   .height(20)
            //   .width(20)
            //   .margin(8)
            Text("河南省郑州市")
              .fontWeight(FontWeight.Medium)
            Image($r('app.media.right'))
              .height(20)
              .width(20)
          }
          .height(40)

          Row() {
            // Image($r('app.media.message'))
            //   .height(20)
            //   .width(20)
            //   .margin(8)
            // Image($r('app.media.scan_code'))
            //   .height(20)
            //   .width(20)
            //   .margin(8)
          }
          .height(40)
          .margin(130)
        }
        .height("10%")
        .width("100%")
        .justifyContent(FlexAlign.Start)

        Column() {
          Row() {
            Search({ placeholder: "搜索/内容" })
              // .searchIcon({ src: $r('app.media.serach') })
              .width(1000)
              .height(1000)
              .backgroundColor("#fff2f8ff")
              .width(340)
              .height(46)
              .borderRadius(9)

          }
          .justifyContent(FlexAlign.Center)
          .height(80)
          .width('100%')

          Row() {
            Swiper() {
              // Image($r('app.media.small'))
              //   .width('95%')
              //   .height((160))
              //   .borderRadius(5)
              // Image($r('app.media.small1'))
              //   .width('95%')
              //   .height((160))
              //   .borderRadius(5)
              // Image($r('app.media.flower'))
              //   .width('95%')
              //   .height((160))
              //   .borderRadius(5)
            }
            .autoPlay(true)
          }

          Row() {
            Column() {
              Row() {
                // Column() {
                //   // Image($r("app.media.zhuzhuangtu"))
                //   //   .width(25)
                //   //   .height(25)
                // }
                // .backgroundColor("#ff98e364")
                // .width(30)
                // .height(30)
                // .borderRadius(100)
                // .margin(10)

                Column() {
                  Text("家庭状态")
                    .fontWeight(FontWeight.Bold)
                }.margin(10)
              }
              .margin(10)

              .width("100%")
              .height(40)
              .justifyContent(FlexAlign.Start)

              Row() {
                Column() {
                  Row() {
                    Text('评分')
                      .textAlign(TextAlign.Start)
                      .fontSize(17)
                  }

                  .width("60%")
                  .margin(10)

                  Row() {
                    Text('98')
                      .fontWeight(FontWeight.Medium)
                      .fontSize(23)
                  }
                  .width("60%")
                }

                Column() {
                  Row() {
                    Text('优秀')
                      .fontColor(Color.Green)
                  }
                  .width(35)
                  .height(30)
                  .borderRadius(5)
                  .backgroundColor("#ff91e399")
                }
              }
              .backgroundColor("#ff91dd7f")
              .width("88%")
              .height(70)
              .borderRadius(7)
            }
            .margin(10)
            .backgroundColor("#ffb3eaa8")
            .width("45%")
            .height(150)
            .borderRadius(9)

            Column() {
              Row() {
                Row() {
                  Image($r('app.media.tingzhenqi'))
                    .width(35)
                    .height(35)
                    .position({ x: 7, y: 7 })
                }
                .width(50)
                .height(50)
                .backgroundColor("#fff69898")
                .margin(10)
                .borderRadius(100)

                Text('快速诊断')
                  .fontWeight(FontWeight.Bold)
              }
              .backgroundColor("#ffffb2b2")
              .width("100%")
              .height(70)
              .borderRadius(9)

              Row() {
              }
              .backgroundColor("#FFFFFF")
              .height(10)
              .width("100%")

              Row() {
                Row() {
                  Image($r('app.media.yisheng'))
                    .width(35)
                    .height(35)
                    .position({ x: 7, y: 7 })
                }
                .borderRadius(100)
                .backgroundColor("#ff9dbbff")
                .width(50)
                .height(50)
                .margin(10)

                Text('在线分析')
                  .fontWeight(FontWeight.Bold)
              }
              .backgroundColor("#ffb8d9ff")
              .width("100%")
              .height(70)
              .borderRadius(9)

            }
            .width("45%")
            .height(150)

          }
          .margin(10)
          .height(180)
          .width("100%")

          Row() {
            Text("控制器")
          }

          Divider().strokeWidth(1)
          Row() {
            // 左边的文字
            Text("电灯开关")
              .width("70%")
              .fontSize(23)
              .textAlign(TextAlign.Start)

            // 右边的开关
            Toggle({ type: ToggleType.Switch })
              .width(50)
              .height(30)
              .onChange((isOn: boolean) => {
                console.info(`开关状态：${isOn}`);

                const baseUrl = "http://10.219.63.89:5000"; // 替换为你的实际 IP
                const url = isOn
                  ? `${baseUrl}/api/device/shadow/light_open`
                  : `${baseUrl}/api/device/shadow/light_close`;

                sendGetRequest(url, (response) => {
                  if (response) {
                    console.info(`电灯已${isOn ? '打开' : '关闭'}`);
                  } else {
                    console.error(`电灯控制失败`);
                  }
                });
              })
          }
          .width("98%")
          .height(100)
          .border({ width: 0.9, color: "#ffc8c8c8" })
          .padding(12)
          .margin(10)
          .borderRadius(6)
          .backgroundColor('#FFFFFF')

          Row() {
            // 左边的文字
            Text("风扇开关")
              .width("70%")
              .fontSize(23)
              .textAlign(TextAlign.Start)

            // 右边的开关
            Toggle({ type: ToggleType.Switch })
              .width(50)
              .height(30)
              .onChange((isOn: boolean) => {
                console.info(`风扇开关状态：${isOn}`)
                // 控制风扇的逻辑
                if (isOn) {
                  motorOpen(); // 假设这是启动风扇的函数
                } else {
                  motorClose(); // 假设这是关闭风扇的函数
                }
              })
          }
          .width("98%")
          .height(100)
          .border({ width: 0.9, color: "#ffc8c8c8" })
          .padding(12)
          .margin(10)
          .borderRadius(6)
          .backgroundColor('#FFFFFF')

          Row() {
            // 左边的文字
            Text("NFC开关")
              .width("70%")
              .fontSize(23)
              .textAlign(TextAlign.Start)

            // 右边的开关
            Toggle({ type: ToggleType.Switch })
              .width(50)
              .height(30)
              .onChange((isOn: boolean) => {
                console.info(`开关状态：${isOn}`)
                // 在这里处理开关逻辑
              })

          }
          .width("98%")
          .height(100)
          .border({ width: 0.9, color: "#ffc8c8c8" })
          .padding(12)
          .margin(10)
          .borderRadius(6)
          .backgroundColor('#FFFFFF') // 可选背景色

        }
        .width("100%")
        .backgroundColor("#ffffff")
        .borderRadius({ topLeft: 15, topRight: 15 })
      }
      // .height('100%')
      .width('100%')
      .backgroundColor("#ffa2cbf1")

    }
    .width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
  }
}
