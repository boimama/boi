
// import router from '@ohos.router'
import router from '@ohos.router'
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import promptAction from '@ohos.promptAction';
// import HttpUtl from './http'
//
// function ctoken(r) {
//   let context = getContext(this) as common.UIAbilityContext;
//   let filesDir = context.filesDir;
//   let file = fs.openSync(filesDir + '/token.txt', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
//   // fs.writeSync(file.fd, "                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                ");
//   let writeLen = fs.writeSync(file.fd, r);
//   console.info("The length of str is: " + writeLen);
//   fs.closeSync(file);
// }

@Entry
@Component
struct Index {

  @State account: string = ''
  @State password: string = ''
  @State zccg: string = ''
  /***************/
  @State message: string = '智能家居'
  @State message2: string = '智能家居'
  @State token: string = '66666666666666666666666666666666'
  @State instance_id: string = '57b91e432e9d4262b02bc2ccf412598c'
  @State username:string ="ubumtu"
  @State userpwd :string="zhou123"
  @State handlePopup: boolean = false
  @State showLoadingProgress:Boolean=false
  //
  ro() {
    router.pushUrl({
      url:'pages/LoadingPage'
    })
  }
  //
  // login() {
  //   console.log('user:', JSON.stringify(this.username));
  //
  //   let url = 'https://iam.cn-north-4.myhuaweicloud.com/v3/auth/tokens';
  //
  //   let hw_user = {
  //     "auth": {
  //       "identity": {
  //         "methods": [
  //           "password"
  //         ],
  //         "password": {
  //           "user": {
  //             "name": this.username,  // IAM用户名
  //             "password": this.userpwd,  // IAM用户密码
  //             "domain": {
  //               "name": "GT-Z2595859114" // IAM用户所属帐号名
  //             }
  //           }
  //         }
  //       },
  //       "scope": {
  //         "domain": {
  //           "name": "GT-Z2595859114" // IAM用户所属帐号名
  //         }
  //       }
  //     }
  //   }


  //   //每一个httpRequest对应一个HTTP请求任务，不可复用
  //   console.log('url:', url);
  //   console.log('hw_user:', hw_user);
  //   HttpUtl.post(url, hw_user, (result) => {
  //     console.log('result:', result);
  //     // this.message2 = globalThis.token;
  //     this.token = globalThis.token;
  //     console.log('token:', globalThis.token);
  //   });
  //
  // }


  showToastMessage(message: string) {
    promptAction.showToast({
      message: message,
      duration: 1500
    });
  };


  build() {

    Flex({direction:FlexDirection.Column,alignItems:ItemAlign.Center,justifyContent:FlexAlign.SpaceAround}) {
      Column() {

        Row() {
          Image($r("app.media.app_close"))
            .width(20)
            .fillColor("#999")
          Text("帮助")
            .fontWeight(600)
            .fontColor("#999")
        }
        .width("100%")
        .justifyContent(FlexAlign.SpaceBetween)

        //logo部分
        Row()
        {
          Text('智能家居')
            .fontColor("#4E81E9")
            .fontSize(35)
            .margin({
              top:40,
              bottom: 20
            })
        }
        Row()
        {
          Image($r("app.media.touxiang"))
            .width(180)
            .height(180)
        }
        Row()
        {

        }

        // 国家/地址部分
        Row() {
          Text('国家/地址')
            .fontColor("#666")
            .layoutWeight(1)
          Text("中国(+86)")
            .fontColor("#666")
            .layoutWeight(1)
            .textAlign(TextAlign.End)
          Image($r("app.media.right"))
            .width(20)
            .fillColor("#999")
        }
        .margin({
          top:40,
          bottom: 20
        })
        .width('100%')
        .height(40)
        .width("100%")
        .padding({
          left: 15,
          right: 10
        })
        .backgroundColor("#fff")
        .borderRadius(20)

        // 文本框部分
        TextInput({ placeholder: "请输入手机号" })
          .height(40)
          .borderRadius(20)
          .placeholderColor("#666")
          .backgroundColor("#fff")
          .onChange((value)=>{
            this.password = value;
          })
        // 协议部分
        Row() {
          Checkbox()
            .width(10)
            .margin({ top: 7 })
          // 如果一段文本中，有样式需要单独设置，可以使用text包裹span
          Text() {
            Span(" 我已阅读并同意")
            Span("《智能家居使用手册》")
              .fontColor("#4E81E9")
              .fontSize(13)
            Span("《智能家居用户服务协议》")
              .fontColor("#4E81E9")
              .fontSize(13)
            Span("未注册的手机号将自动创建华为账号")
          }
          .fontSize(12)
          .lineHeight(20)
          .fontColor("#666")
        }
        .alignItems(VerticalAlign.Top)
        .margin({
          top: 20,
          bottom: 25
        })
        .width("100%")

        // 登录部分
        Button("登录")
          .width("100%")
          .backgroundColor("#ff3097f6")
          .onClick(()=>{
            setTimeout(() => {
              this.showToastMessage("登陆成功");
              this.ro()
            }, 3000);
          })
        Row({ space: 25 }) {
          Button()
          {
            Text("新用户注册")
              .fontSize(13)
              .fontColor("#666")
              .onClick(() => {
                // 输出成功点击'Next'按钮的消息
                console.info(`Succeeded in clicking the 'Next' button.`)

                // 跳转到第二页
                router.pushUrl({ url: 'pages/big' }).then(() => {
                  // 成功跳转到第二页后，输出成功的消息
                  console.info('Succeeded in jumping to the second page.')
                })
              })
          }.backgroundColor(Color.Transparent)
          Text("账号密码登录")
            .fontSize(13)
            .fontColor("#666")
          Text("无法登录")
            .fontSize(13)
            .fontColor("#666")
        }
        .margin({
          top: 15
        })

        // 填充组件作用：填充空白区域【自适应】
        Blank()
        // 其他登录方式
        Column() {
          Text("其他登录方式")
            .height(22)
            .fontSize("14")
            .fontColor("#666")
            .margin({
              bottom: 20
            })
          Row() {
            Image($r("app.media.weixin"))
              .width(35)
            Image($r("app.media.weibo"))
              .width(35)
              .fillColor("#56a44a")
            Image($r("app.media.qq"))
              .width(35)
              .fillColor("#C02838")
            Image($r("app.media.huaiwei"))
              .width(35)
              .fillColor("#1296db")
          }
          .margin({
            bottom: 30
          })
          .width("100%")
          .justifyContent(FlexAlign.SpaceAround)
        }
      }
      .padding(20)
      .width("100%")
      .height("100%")
      .linearGradient({
        angle: 135, // 设置颜色渐变起始角度为顺时针方向45°
        colors: [
          [0xceeff2, 0.0],
          [0xFFDCE7BC, 0.4],
          [0xFFFFFFF, 0.8],
        ]
      })
    }
  }
}