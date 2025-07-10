import { InfoItem, MineItemList } from '../model/MineltemList';
import router from '@ohos.router';
@Entry
@Component
export struct MineComponent {

  @State nickname: string = 'Jerry'; // 昵称


  build() {
    Scroll(){
      Column() {
        //顶部区域
        Row() {
          Text('我的')
            .fontSize(20)
          Image($r('app.media.mine_message'))
            .width(20)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        //个人简介
        Column() {
          Row() {
            Image($r('app.media.mine_touxiang'))
              .width(50)
              .margin({
                top: 10
              })
              .fillColor('#ccc')
            Column() {
              Text('居优家')
                .fontSize(14)
                .width('100%')
                .margin({
                  bottom: 5
                })
              Progress({
                value: 20
              })
                .height(1.5)
                .color(Color.Yellow)
                .backgroundColor('#ccc')

              Row() {
                Text() {
                  Span('活力新星')
                  Span('   ')
                  Span('成长值 234 / 1,500')
                }
                .fontSize(14)
                .fontColor(Color.Gray)
                .margin({
                  top: 10
                })
              }
              .width('100%')
            }
            .width('80%')

          }

          Row() {
            Column() {
              Text('Lv.1')
                .fontSize(12)
              Text('等级')
                .fontSize(12)
            }

            Column() {
              Text('0')
                .fontSize(12)
              Text('卡卡')
                .fontSize(12)
            }
            .width('100%')
          }
          .margin({
            left: 60,
            top: 10
          })
        }
        .padding(5)
        .width('100%')
        .height(120)
        .margin({
          top: 20
        })
        .borderRadius(10)
        .backgroundColor(Color.White)

        //卡片组件
        Row() {
          Column({ space: 5}){
            Text('我的组群')
              .fontSize(14)
              .width('100%')
            Text('创建群组')
              .fontSize(12)
              .fontColor(Color.Gray)
              .width('100%')
          }
          .padding(8)
          .width('50%')
          .height(50)
          .borderRadius(10)
          .backgroundColor(Color.White)
          .backgroundImage($r('app.media.mine_zuqun'))
          .backgroundImagePosition(Alignment.End)
          .backgroundImageSize(25)

          Column({ space: 5}){
            Text('家庭空间')
              .fontSize(14)
              .width('100%')
            Text('看看家庭空间有哪些新功能')
              .fontSize(10)
              .fontColor(Color.Gray)
              .width('100%')
              .textOverflow({
                overflow: TextOverflow.Ellipsis
              })
              .maxLines(1)
          }
          .padding(8)
          .margin({
            left: 10
          })
          .width('48%')
          .height(50)
          .borderRadius(10)
          .backgroundColor(Color.White)
          .backgroundImage($r('app.media.house_fill'))
          .backgroundImagePosition(Alignment.End)
          .backgroundImageSize(20)
        }
        .margin({
          top: 10
        })

        Row() {
          Column({ space: 5}){
            Text('我的年度目标')
              .fontSize(14)
              .width('100%')
            Text('创建目标')
              .fontSize(12)
              .fontColor(Color.Gray)
              .width('100%')
          }
          .padding(8)
          .width('50%')
          .height(50)
          .borderRadius(10)
          .backgroundColor(Color.White)
          .backgroundImage($r('app.media.mine_hongqi'))
          .backgroundImagePosition(Alignment.End)

          Column({ space: 5}){
            Text('周报年报')
              .fontSize(14)
              .width('100%')
            Text('十一月月报')
              .fontSize(12)
              .fontColor(Color.Gray)
              .width('100%')
              .textOverflow({
                overflow: TextOverflow.Ellipsis
              })
              .maxLines(1)
          }
          .padding(8)
          .margin({
            left: 10
          })
          .width('48%')
          .height(50)
          .borderRadius(10)
          .backgroundColor(Color.White)
          .backgroundImage($r('app.media.mine_yuebao'))
          .backgroundImagePosition(Alignment.End)
          .backgroundImageSize(20)
        }
        .margin({
          top: 10
        })

        //下拉区域
        // Column() {
        //   Row() {
        //     Text('我的勋章')
        //       .layoutWeight(1)
        //     Text('共 0 枚')
        //     Image($r('app.media.mine_right'))
        //       .width(16)
        //       .fillColor(Color.Gray)
        //       .margin({
        //         left: 3
        //       })
        //   }
        //
        //   Row() {
        //     Image($r('app.media.mine_xunzhang'))
        //       .fillColor('#ccc')
        //       .width(50)
        //     Text('即将获得')
        //       .margin({
        //         left: 8
        //       })
        //   }
        //   .width('100%')
        // }
        // .padding(10)
        // .width('100%')
        // .height(100)
        // .margin({
        //   top: 20
        // })
        // .backgroundColor(Color.White)
        // .borderRadius(10)

        //数据
        Text('数据')
          .margin({
            top: 15,
            bottom: 10
          })
          .width('100%')

        Column() {
          Row(){
            Image($r('app.media.mine_chengjiu'))
              .width(30)
              .fillColor(Color.Gray)
            Text('我的成就')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)

          Row(){
            Image($r('app.media.mine_shuju'))
              .width(30)
              .fillColor(Color.Gray)
            Text('我的数据')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .margin({
            top: 10
          })
          .width('100%')
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)

          Row(){
            Image($r('app.media.mine_kecheng'))
              .width(30)
              .fillColor(Color.Gray)
            Text('课程与计划')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 170
              })
              .fillColor(Color.Grey)
          }
          .margin({
            top: 10
          })
          .width('100%')
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)
          Row(){
            Image($r('app.media.mine_huodong'))
              .width(30)
              .fillColor(Color.Gray)
            Text('我的活动')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .margin({
            top: 10
          })
          .width('100%')
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)
          Row(){
            Image($r('app.media.mine_luxian'))
              .width(30)
              .fillColor(Color.Gray)
            Text('我的设备')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .margin({
            top: 10
          })
          .width('100%')
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)
          Row(){
            Image($r('app.media.mine_ziliao'))
              .width(30)
              .fillColor(Color.Gray)
            Text('个人资料')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .margin({
            top: 10
          })
          .width('100%')

        }
        .padding(15)
        .height(330)
        .backgroundColor(Color.White)
        .borderRadius(10)

        Text('其他')
          .fontSize(14)
          .margin({
            top: 15,
            bottom: 10
          })
          .width('100%')
        Column(){
          Row(){
            Image($r('app.media.mine_dingdan'))
              .width(30)
              .fillColor(Color.Gray)
            Text('我的订单')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)

          Row(){
            Image($r('app.media.mine_zichan'))
              .width(30)
              .fillColor(Color.Gray)
            Text('我的资产')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          .margin({
            top: 15
          })
        }
        .padding(15)
        .height(125)
        .backgroundColor(Color.White)
        .borderRadius(10)

        Column(){
          Row(){
            Image($r('app.media.mine_shezhi'))
              .width(30)
              .fillColor(Color.Gray)
            Text('设置')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 215
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)

          Row(){
            Image($r('app.media.mine_yinsi'))
              .width(30)
              .fillColor(Color.Gray)
            Text('隐私管理')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          .margin({
            top: 15
          })
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)

          Row(){
            Image($r('app.media.mine_bangzhu'))
              .width(30)
              .fillColor(Color.Gray)
            Text('帮助与客服')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 170
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          .margin({
            top: 15
          })
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)

          Row(){
            Image($r('app.media.mine_jiacha'))
              .width(30)
              .fillColor(Color.Gray)
            Text('检查更新')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 185
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          .margin({
            top: 15
          })
          Divider()
            .width('85%')
            .height(0.2)
            .margin({
              left: 30,
              top: 10
            })
            .backgroundColor(Color.Gray)

          Row(){
            Image($r('app.media.mine_guanyu'))
              .width(30)
              .fillColor(Color.Gray)
            Text('关于')
              .fontSize(14)
              .margin({
                left: 10
              })
            Image($r('app.media.mine_right'))
              .width(16)
              .margin({
                left: 215
              })
              .fillColor(Color.Grey)
          }
          .width('100%')
          .margin({
            top: 15
          })

        }
        .margin({
          top: 10
        })
        .padding(15)
        .height(300)
        .backgroundColor(Color.White)
        .borderRadius(10)
      }
      .padding(10)
      .width('100%')
      .backgroundImage($r('app.media.mine_background'))
      .backgroundImageSize(ImageSize.Cover)
    }
    .width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)

  }
}