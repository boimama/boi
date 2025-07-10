import http from '@ohos.net.http';

// 定义接口类型
interface DeviceProperties {
  autoStatus: string;
  humidity: string;
  illumination: string;
  lightStatus: string;
  motorStatus: string;
  nfcStatus: string;
  temperature: string;
}

interface DeviceReported {
  event_time: string;
  properties: DeviceProperties;
}

interface ShadowItem {
  desired: string;
  reported: DeviceReported;
  service_id: string;
  version: number;
}

interface DeviceShadowData {
  device_id: string;
  shadow: ShadowItem[];
}

interface ApiResponse {
  success: boolean;
  data?: DeviceShadowData;
}

function formatTime(timeStr: string): string {
  // 输入格式："20250708T100729Z"

  // 构造标准 ISO 格式时间字符串
  const isoStr = `${timeStr.slice(0, 4)}-${timeStr.slice(4, 6)}-${timeStr.slice(6, 8)}T${timeStr.slice(9, 11)}:${timeStr.slice(11, 13)}:${timeStr.slice(13, 15)}Z`;

  const date = new Date(isoStr); // 自动识别为 UTC 时间并转为本地时间

  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hour = String(date.getHours()).padStart(2, '0');
  const minute = String(date.getMinutes()).padStart(2, '0');
  const second = String(date.getSeconds()).padStart(2, '0');

  return `${year}-${month}-${day} ${hour}:${minute}:${second}`;
}
// 封装请求函数
function fetchDeviceData(): Promise<ApiResponse> {
  return new Promise((resolve, reject) => {
    let httpRequest = http.createHttp();

    httpRequest.request(
      'http://192.168.1.2:5000/api/device/shadow',
      {
        method: http.RequestMethod.GET
      },
      (err, data) => {
        if (err) {
          console.error('请求失败:', err);
          reject(err);
          return;
        }

        if (typeof data.result === 'string') {
          try {
            const result = JSON.parse(data.result) as ApiResponse;
            resolve(result);
          } catch (e) {
            console.error('JSON 解析失败');
            reject(e);
          }
        } else {
          reject(new Error('响应结果不是字符串'));
        }
      }
    );
  });
}

@Component
@Entry
export  struct DeviceSearchComponent {
  @State deviceId: string = '--';
  @State temperature: string = '--';
  @State humidity: string = '--';
  @State illumination: string = '--';
  @State nfcStatus: string = '--';
  @State motorStatus: string = '--';
  @State lightStatus: string = '--';
  @State autoStatus: string = '--';
  @State updateTime: string = '--';
  // 页面加载时获取数据
  private refreshInterval: number = 5000; // 5秒
  private timer: number = -1;

  aboutToAppear(): void {
    this.fetchData();
    this.timer = setInterval(() => {
      this.fetchData();
    }, this.refreshInterval);
  }

  aboutToDisappear(): void {
    if (this.timer !== -1) {
      clearInterval(this.timer);
      this.timer = -1;
    }
  }


  // 获取并解析数据
  fetchData(): void {
    fetchDeviceData()
      .then((response: ApiResponse) => {
        if (response.success && response.data) {
          const device = response.data;
          const shadow = device.shadow[0];

          this.deviceId = device.device_id;

          if (shadow && shadow.reported && shadow.reported.properties) {
            const props = shadow.reported.properties;

            this.temperature = props.temperature.replace('℃', '').trim();
            this.humidity = props.humidity.replace('%', '').trim();
            this.illumination = props.illumination.trim().replace('Lux', '').trim();
            this.nfcStatus = props.nfcStatus;
            this.motorStatus = props.motorStatus;
            this.lightStatus = props.lightStatus;
            this.autoStatus = props.autoStatus;
            this.updateTime = formatTime(shadow.reported.event_time);
          }
        }
      })
      .catch((error: Error | string) => {
        console.error('完整错误:', JSON.stringify(error, null, 2));
      });
  }

  build() {
    Column() {
      Row() {
        // Image($r('app.media.chevron_left'))
        //   .width(14)
        Text('智能家居')
          .fontSize(14)
        // Image($r('app.media.clock'))
        //   .width(16)
      }
      .width('100%')
      .padding({
        left: 20,
        right: 20
      })
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        top: 10
      })

      Row() {

        Column({ space: 8 }) {
          Text('您家庭状态是')
            .width('100%')
            .fontSize(14)
          Text('超优秀状态')
            .width('100%')
            .fontWeight(700)
          Text(`采集时间是${this.updateTime}`)
            .width('100%')
            .fontSize(12)
        }
        .width('70%')
        .margin({
          left: 20
        })
        //
        // Image($r('app.media.yiliao'))
        //   .width(100)
        //   .margin({
        //     right: 50
        //   })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        top: 20
      })
      .width('100%')
      .height(20)

      Column() {
        Row() {
          Text('家居指标数据')
            .fontSize(12)
            .fontColor('#ff0d8eb8')

        }
        .width('100%')
        .margin({
          top: 20

        })
        .justifyContent(FlexAlign.SpaceAround)

        //横线
        Divider()
          .width('100%')
          .height(2)
          .color(Color.Grey)
          .margin({ top: 10 })
        Scroll() {
          Column(){
            Row() {
              // Image($r('app.media.tizhong'))
              //   .backgroundColor('#4CAF50')
              //   .borderRadius(5)
              //   .width(60)
              //   .margin({
              //     left: 15
              //   })
              Row() {
                Column({ space: 15 }) {
                  Row() {
                    Row() {
                      Text('温度')
                        .fontSize(18)
                        .fontWeight(700)
                    }
                    .layoutWeight(1)

                    // .width('100%')
                    Row() {
                      Text(this.temperature)
                        .margin({
                          right: 5
                        })
                      Text('℃')
                        .fontSize(14)
                    }
                    .layoutWeight(1)
                  }


                  Row() {
                    Text(this.updateTime)
                      .fontSize(14)
                      .fontColor(Color.Gray)
                      .layoutWeight(1)
                    Text('正常')
                      .layoutWeight(1)
                  }
                }
              }
              .margin({
                left: 10
              })
            }
            .width('90%')
            .height(100)
            .margin({
              top: 20
            })
            .border({
              width: 0.2,
              color: '#0088c0'
            })

            Row() {
              // Image($r('app.media.tiwen'))
              //   .backgroundColor('#FF5722')
              //   .borderRadius(5)
              //   .width(60)
              //   .margin({
              //     left: 15
              //   })
              Row() {
                Column({ space: 15 }) {
                  Row() {
                    Row() {
                      Text('湿度')
                        .fontSize(18)
                        .fontWeight(700)
                    }
                    .layoutWeight(1)

                    // .width('100%')
                    Row() {
                      Text(this.humidity)
                        .margin({
                          right: 5
                        })
                      Text('%')
                        .fontSize(14)
                    }
                    .layoutWeight(1)
                  }


                  Row() {
                    Text(this.updateTime)
                      .fontSize(14)
                      .fontColor(Color.Gray)
                      .layoutWeight(1)
                    Text('正常')
                      .layoutWeight(1)
                  }
                }
              }
              .margin({
                left: 10
              })
            }
            .width('90%')
            .height(100)
            .margin({
              top: 20
            })
            .border({
              width: 0.2,
              color: '#0088c0'
            })

            Row() {
              // Image($r('app.media.heart_rate'))
              //   .backgroundColor(Color.Pink)
              //   .borderRadius(5)
              //   .width(60)
              //   .margin({
              //     left: 15
              //   })
              Row() {
                Column({ space: 15 }) {
                  Row() {
                    Row() {
                      Text('光照')
                        .fontSize(18)
                        .fontWeight(700)
                    }
                    .layoutWeight(1)

                    // .width('100%')
                    Row() {
                      Text(this.illumination)
                        .margin({
                          right: 5
                        })
                      Text('Lux')
                        .fontSize(14)
                    }
                    .layoutWeight(1)
                  }

                  Row() {
                    Text(this.updateTime)
                      .fontSize(14)
                      .fontColor(Color.Gray)
                      .layoutWeight(1)
                    Text('正常')
                      .layoutWeight(1)
                  }
                }
              }
              .margin({
                left: 10
              })
            }
            .width('90%')
            .height(100)
            .margin({
              top: 20
            })
            .border({
              width: 0.2,
              color: '#0088c0'
            })

            Row() {
              // Image($r('app.media.heart_rate'))
              //   .backgroundColor(Color.Pink)
              //   .borderRadius(5)
              //   .width(60)
              //   .margin({
              //     left: 15
              //   })
              Row() {
                Column({ space: 15 }) {
                  Row() {
                    Row() {
                      Text('风扇')
                        .fontSize(18)
                        .fontWeight(700)
                    }
                    .layoutWeight(1)

                    // .width('100%')
                    Row() {
                      Text(this.motorStatus)
                        .margin({
                          right: 5
                        })
                      Text('')
                        .fontSize(14)
                    }
                    .layoutWeight(1)
                  }

                  Row() {
                    Text(this.updateTime)
                      .fontSize(14)
                      .fontColor(Color.Gray)
                      .layoutWeight(1)
                    Text('正常')
                      .layoutWeight(1)
                  }
                }
              }
              .margin({
                left: 10
              })
            }
            .width('90%')
            .height(100)
            .margin({
              top: 20
            })
            .border({
              width: 0.2,
              color: '#0088c0'
            })

            Row() {
              // Image($r('app.media.heart_rate'))
              //   .backgroundColor(Color.Pink)
              //   .borderRadius(5)
              //   .width(60)
              //   .margin({
              //     left: 15
              //   })
              Row() {
                Column({ space: 15 }) {
                  Row() {
                    Row() {
                      Text('电灯')
                        .fontSize(18)
                        .fontWeight(700)
                    }
                    .layoutWeight(1)

                    // .width('100%')
                    Row() {
                      Text(this.lightStatus)
                        .margin({
                          right: 5
                        })
                      Text('')
                        .fontSize(14)
                    }
                    .layoutWeight(1)
                  }

                  Row() {
                    Text(this.updateTime)
                      .fontSize(14)
                      .fontColor(Color.Gray)
                      .layoutWeight(1)
                    Text('正常')
                      .layoutWeight(1)
                  }
                }
              }
              .margin({
                left: 10
              })
            }
            .width('90%')
            .height(100)
            .margin({
              top: 20
            })
            .border({
              width: 0.2,
              color: '#0088c0'
            })

            Row() {
              // Image($r('app.media.tizhong'))
              //   .backgroundColor('#00BCD4')
              //   .borderRadius(5)
              //   .width(60)
              //   .margin({
              //     left: 15
              //   })
              Row() {
                Column({ space: 15 }) {
                  Row() {
                    Row() {
                      Text('NFC')
                        .fontSize(18)
                        .fontWeight(700)
                    }
                    .layoutWeight(1)

                    // .width('100%')
                    Row() {
                      Text(this.nfcStatus)
                        .margin({
                          right: 5
                        })
                      Text('')
                        .fontSize(14)
                    }
                    .layoutWeight(1)
                  }

                  Row() {
                    Text(this.updateTime)
                      .fontSize(14)
                      .fontColor(Color.Gray)
                      .layoutWeight(1)
                    Text('正常')
                      .layoutWeight(1)
                  }
                }
              }
              .margin({
                left: 10
              })
            }
            .width('90%')
            .height(100)
            .margin({
              top: 20
            })
            .border({
              width: 0.2,
              color: '#0088c0'
            })
            Row() {
              // Image($r('app.media.tizhong'))
              //   .backgroundColor('#00BCD4')
              //   .borderRadius(5)
              //   .width(60)
              //   .margin({
              //     left: 15
              //   })
              Row() {
                Column({ space: 15 }) {
                  Row() {
                    Row() {
                      Text('')
                        .fontSize(18)
                        .fontWeight(700)
                    }
                    .layoutWeight(1)

                    // .width('100%')
                    Row() {
                      Text()
                        .margin({
                          right: 5
                        })
                      Text()
                        .fontSize(14)
                    }
                    .layoutWeight(1)
                  }

                  Row() {
                    Text('')
                      .fontSize(14)
                      .fontColor(Color.Gray)
                      .layoutWeight(1)
                    Text('')
                      .layoutWeight(1)
                  }
                }
              }
              .margin({
                left: 10
              })
            }
            .width('90%')
            .height(100)
            .margin({
              top: 20
            })
            .border({
              width: 0.2,
              color: '#ffffffff'
            })
          }
          }
          .width('100%')
         .height('100%')
         .scrollable(ScrollDirection.Vertical)
         .scrollBar(BarState.Off)


      }
      .width('100%')
      .height('85%')
      .borderRadius({
        topLeft: 30,
        topRight: 30
      })
      .margin({
        top: '15%'
      })
      .backgroundColor(Color.White)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#C8FFEE')
  }


//   loadDeviceData(){
//     if (this.panduanzhi == "1"){
//       this.panduanzhi = "2";
//     }else {
//       this.panduanzhi = "1"
//     }
//
//     let httpRequest = http.createHttp();
//     httpRequest.on('headersReceive', (header) => {
//       console.info('header: ' + JSON.stringify(header));
//     });
//     httpRequest.request(
//       "https://8fc2eb4d5f.st1.iotda-app.cn-north-4.myhuaweicloud.com:443/v5/iot/4d27aa51ee1945eb9ba42fd9a566a84b/devices/zivnrrmnsmeq-1763799137741963313_rk2206_medical/shadow",
//       // "https://7082ea88ec.st1.iotda-app.cn-north-4.myhuaweicloud.com:443/v5/iot/57b91e432e9d4262b02bc2ccf412598c/devices/661554e52ccc1a58388073d7_djbcdbchdb/shadow",
//       {
//         method: http.RequestMethod.GET,
//         header: {
//           'X-Auth-Token': this.token,
//         },
//         extraData: {
//           "project-id": "4d27aa51ee1945eb9ba42fd9a566a84b",
//           'device_id': '/zivnrrmnsmeq-1763799137741963313_rk2206_medical'
//         },
//         expectDataType: http.HttpDataType.STRING, // 可选，指定返回数据的类型
//         usingCache: true, // 可选，默认为true
//         priority: 1, // 可选，默认为1
//         connectTimeout: 60000, // 可选，默认为60000ms
//         readTimeout: 60000, // 可选，默认为60000ms
//         usingProtocol: http.HttpProtocol.HTTP1_1, // 可选，协议类型默认值由系统自动指定
//       }, (err, data) => {
//       if (!err) {
//         this.message = data.result as string
//       } else {
//         httpRequest.off('headersReceive');
//         httpRequest.destroy();
//       }
//     }
//     );
//     this.timerId = setInterval(()=>{
//       this.chush = this.message
//       let huaweijson = JSON.parse(this.message)
//       this.xin_lv_zhuang_tai     = huaweijson.shadow[0].reported.properties["心率状态"]
//       this.xin_lv                = huaweijson.shadow[0].reported.properties["心率"]
//       this.xin_lv                =huaweijson.shadow[0].reported.properties["心率"].toString()
//       this.xue_yang_zhuang_tai   = huaweijson.shadow[0].reported.properties["血氧状态"]
//       this.xue_yang              = huaweijson.shadow[0].reported.properties["血氧"]
//       this.xue_yang              = huaweijson.shadow[0].reported.properties["血氧"].toString()
//       this.ti_wen_zhuang_tai     = huaweijson.shadow[0].reported.properties["温度状态"]
//       this.ti_wen                = huaweijson.shadow[0].reported.properties["温度"]
//       this.ti_wen                = huaweijson.shadow[0].reported.properties["温度"].toString()
//       // this.xin_lv_zhuang_tai     = huaweijson
//       // this.qwe = "666";
//
//     },2000)
//     /**
//
//
//      "properties": {
//      "心率状态": "无效",
//      "心率": 0,
//      "血氧状态": "无效",
//      "血氧": 0,
//      "温度状态": "无人",
//      "温度": "0"
//      },
//
//
//      @State xin_lv_zhuang_tai   :string = "";   //心率
//      @State xin_lv              :string = "";
//      @State xue_yang_zhuang_tai :string = "";   //血氧
//      @State xue_yang            :string = "";
//      @State ti_wen_zhuang_tai   :string = "";   //体温
//      @State ti_wen              :string = "";
//      @State message              :string = "";
//      */
//   }
//

//
}