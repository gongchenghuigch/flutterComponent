List listData =  [
  {
    'day': '07-08',
    'time': '13:20',
    'remark': "备注：降价1000客户可考虑，辛苦再撮合备注：降价1000客户可考虑，辛苦再撮合备注：降价1000客户可考虑",
    'description': '',
    'subtitle': '何神(主播)',
    'title': "新建工单"
  },
  {
    'id': "2",
    'day': '07-08',
    'time': '13:20',
    'description': "备注：降价1000客户可考虑，辛苦再撮合备注：降价1000客户可考虑",
    'subtitle': '吴飞飞(销售专员)',
    'title': "联系客户"
  },
  {
    'id': "3",
    'day': '07-08',
    'time': '13:20',
    'description': "备注：降价1000客户可考虑，辛苦再撮合备注：降价1000客户可考虑，辛苦再撮合备注：降价1000客户可考虑，辛苦再撮合",
    // 'subtitle': '何神(主播)',
    'title': "新建工单"
  },
  {
    'id': "4",
    'day': '07-08',
    'time': '13:20',
    'description': "备注：降价1000客户可考虑，辛苦再撮合备注：降价1000客户可考虑，辛苦再撮合备注：降价1000客户可考虑，辛苦再撮合",
    'subtitle': '何神(主播)',
    'title': "新建工单"
  },
  {
    'id': "5",
    'day': '07-08',
    'time': '13:20',
    'description': "备注：降价1000客户可考虑",
    'subtitle': '何神(主播)',
    'title': "新建工单"
  }
];
TimelineComponent(
  timelineList: listData.length > 0 ?listData:[],
  lineColor: WBColors.color_cccccc,
  leftContent: true,
)