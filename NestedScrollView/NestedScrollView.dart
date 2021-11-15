import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

class NestedScrollViewWidget extends StatefulWidget{
  @override
  NestedScrollViewState createState() => NestedScrollViewState();

}
class NestedScrollViewState extends State<NestedScrollViewWidget> {
  ///滚动监听设置
  ScrollController _scrollController;
  ///头部背景布局 true滚动一定的高度 false 滚动高度为0
  bool headerWhite = false;
  String backIcon = 'https://img.58cdn.com.cn/escstatic/docs/imgUpload/gongchenghui/icon_common_white.png';
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      ///监听滚动位置设置导航栏颜色
      setState(() {
        headerWhite = _scrollController.offset > 400 ? true : false;
        backIcon = _scrollController.offset > 400 ?
        'https://img.58cdn.com.cn/escstatic/docs/imgUpload/gongchenghui/icon_common_back.png' :
        'https://img.58cdn.com.cn/escstatic/docs/imgUpload/gongchenghui/icon_common_white.png';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: () => Scaffold(
          backgroundColor: Color(0xFFF4F5F7),
          body: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: _headerSliverBuilder,
              // body: Text('data'),
              body: buildSliverBody(context)
          ),
        )
    );
  }
  ///页面滚动头部处理
  List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget> [
      buildSliverAppBar(context)
    ];
  }
  ///导航部分渲染
  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 500,
      elevation: 0,
      backgroundColor: headerWhite? Colors.white : Color(0xFFF4F5F7),
      brightness: Brightness.light,
      snap: false,
      leading: IconButton(
          icon: Image.network(backIcon, height: 22, width: 22,),
          onPressed: (){
            //TODO: 返回事件处理
          }
      ),

      flexibleSpace: FlexibleSpaceBar(
        title: headerWhite ? Text('长津湖', style: TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w700,
            fontSize: 17,
            fontFamily: 'PingFangSC-Semibold'
        ),) : Text(''),
        centerTitle: true,
        background: buildAppBarBackground(context),
      ),
    );
  }
  ///渲染背景部分布局
  Widget buildAppBarBackground(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 400,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage('https://p0.meituan.net/movie/0e81560dc9910a6a658a82ec7a054ceb5075992.jpg@464w_644h_1e_1c'),
                  fit: BoxFit.fill
              )
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: (Container(
                    height: 160,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(15),
                    width: ScreenUtil().screenWidth,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(8.0)
                    ),
                  child: (
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('剧情简介',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'PingFangSC-Semibold',
                            color: Color(0xff000000)
                        )),
                        Text('电影《长津湖》以抗美援朝战争第二次战役中的长津湖战役为背景，讲述了一段波澜壮阔的历史：71年前，中国人民志愿军赴朝作战，在极寒严酷环境下，东线作战部队凭着钢铁意志和英勇无畏的战斗精神一路追击，奋勇杀敌，扭转了战场态势，打出了军威国威')
                      ],
                    )
                  ),
                ))
            )
        ),
      ],
    );
  }
  Widget buildSliverBody(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            ///设置卡片外间距padding
            padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 0),
            child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(8.0)
                ),
                child: Text('印象中第一次一大家子一起来看电影，姥爷就是志愿军，他一辈子没进过电影院，开始还担心会不会不适应，'
                    '感谢影院工作人员的照顾，姥爷全程非常投入，我坐在旁边看到他偷偷抹了好几次眼泪，刚才我问电影咋样，一直念叨“好，好哇，'
                    '我们那时候就是那样的，就是那样的……” 忽然觉得历史长河与我竟如此之近，刚刚的三个小时我看到的是遥远的70年前、是教科书里的战争，'
                    '更是姥爷的19岁，是真真切切的、他的青春年代！')
            ),
          ),
          Padding(
            ///设置卡片外间距padding
            padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 0),
            child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(8.0)
                ),
                child: Text('《长津湖》绝对可以称得上是一部伟大的战争史诗了！！拍出了抗美援朝这场立国之战最真实的样子！拍出了我们志愿军战士英勇无畏的英雄性！'
                    '可歌可泣！气势恢宏！ 可以说《长津湖》不仅是目前国内战争电影的天花板，也是迄今为止一部把人和人性拍的最好的战争电影——这是非常难能可贵的！ '
                    '电影可以说是集合了中国一群最优秀最具雄性荷尔蒙的男演员出演！全员演技在线！其中令人印象最深刻的是易烊千玺饰演的伍万里。'
                    '他把一个新兵从懵懂参军到初入战场的恐惧慌乱再到经历了战火的淬炼后面对敌人果敢无畏的成长线演绎地淋漓尽致！人物角色的层次感，立体感和信任感都无比强烈！'
                    '不禁感叹，后生可畏！演得太好了，不，应该说是太出彩了！')
            ),
          )
        ],
      ),
    );
  }

}