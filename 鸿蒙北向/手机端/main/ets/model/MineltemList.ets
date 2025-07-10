export interface InfoItem {
  id: string;
  title: string;//标题
  // icon?: Resource;//图标，可有可无
}

export const MineItemList: InfoItem[] = [
  {
    id:'1',
    title:'个人资料',
    // icon: $r('app.media.grrenziliao')
  },

  {
    id:'2',
    title:'我的报告',
    // icon: $r('app.media.baogao')
  },
  {
    id:'3',
    title:'心脏中心',
    // icon: $r('app.media.xinzang')
  },

  {
    id:'4',
    title:'账号与安全',
    // icon: $r('app.media.yaoshi')
  },

  {
    id:'5',
    title:'检查更新',
    // icon: $r('app.media.banshou')
  },

  {
    id:'6',
    title:'关于',
    // icon: $r('app.media.fangkuai')
  }
]