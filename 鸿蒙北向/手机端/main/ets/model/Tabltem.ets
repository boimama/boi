export interface TabItem {
  icon:Resource;//图标
  icon_selected: Resource;
  title: string;//标题
  id: number;
}

export enum TabID {
  SEARCH_DEVICE,
  DETECTOR,
  // AI,
  // CKT,
  MINE
}

export const TabItemList: TabItem[] = [
  {
    icon:$r('app.media.fangdajing'),
    icon_selected: $r('app.media.fangdajing1'),
    title: '搜索设备',
    id:TabID.SEARCH_DEVICE

  },
  {
    icon:$r('app.media.xindiantu1'),
    icon_selected: $r('app.media.xindiantu'),
    title: '检测仪',
    id:TabID.DETECTOR

  },
  // {
  //   icon:$r('app.media.xindiantu1'),
  //   icon_selected: $r('app.media.xindiantu'),
  //   title: 'AI',
  //   id:TabID.AI
  //
  // },
  // {
  //   icon:$r('app.media.kongzhitai'),
  //   icon_selected: $r('app.media.kongzhitai1'),
  //   title: '操控台',
  //   id:TabID.CKT
  //
  // },
  {
    icon:$r('app.media.wode'),
    icon_selected: $r('app.media.wode1'),
    title: '我的',
    id:TabID.MINE

  }
]