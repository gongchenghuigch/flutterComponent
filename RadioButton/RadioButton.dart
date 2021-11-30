import 'package:flutter/cupertino.dart';
import '../common/colors.dart';
import '../common/font_constant.dart';
import 'package:flutter/material.dart';
///声明回调函数
typedef ButtonRadioCallback = void Function(dynamic value);
class ButtonRadioModel {
  ///单选按钮标题
  final String title;
  ///单选按钮数据
  final List radioData;
  ///按钮高度
  final double height;
  ///按钮宽度
  final double width;
  ///单选按钮回调
  final ButtonRadioCallback callback;
  ///定义入参model
  ButtonRadioModel({this.title, this.radioData, this.height=30, this.width=80, this.callback});
}
class ButtonRadio extends StatefulWidget {
  final ButtonRadioModel model;

  const ButtonRadio(this.model);
  ButtonRadioState createState() => new ButtonRadioState();
}

class ButtonRadioState extends State<ButtonRadio> {
  ///当前选中的按钮
  String select;
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return buttonRadioWidget(context, widget.model);
  }
  Widget buttonRadioWidget(BuildContext context, ButtonRadioModel model) {
    return Container(
      color: WBColors.white,
      child: Column(
        children: <Widget>[
          ///标题栏
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(model.title, style: TextStyle(
                      fontSize: 15,
                      color: WBColors.color_333333,
                      fontFamily: FontConstant.pingFangSC_Medium,
                      fontWeight: FontWeight.w500
                  )),
              )
            ],
          ),
          ///按钮组件
          Row(
            children: <Widget>[
              buildGrid(context, model)
            ],
          )
        ],
      ),
    );
  }
  /// 循环构建标签
  Widget buildGrid(BuildContext context, ButtonRadioModel model) {
    List<Widget> tiles = [];//先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for(var item in model.radioData) {
      tiles.add(
          buildItemLabel(item, model)
      );
    }
    content = Wrap(
        spacing: 12.0, // 主轴(水平)方向间距
        runSpacing: 8.0, // 纵轴（垂直）方向间距
        alignment: WrapAlignment.center, //沿主轴方向居中
        children: tiles //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
      //此时如果我们直接把生成的tiles放在<Widget>[]中是会报一个类型不匹配的错误，把<Widget>[]删了就可以了
    );
    return content;
  }
  /// 构建按钮label
  Widget buildItemLabel(item, ButtonRadioModel model) {
    return Container(
      width: model.width,
      height: model.height,
      decoration: BoxDecoration(
        ///设置按钮渐变
        gradient: LinearGradient(
            colors:
            (select == null && item['default']) || select == item['value'] ?
            [WBColors.color_f25228, WBColors.color_fcaf3c] :
            [WBColors.color_f6f6f6, WBColors.color_f6f6f6],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 1)
        ),
          borderRadius: BorderRadius.circular((model.height / 2))
      ),
      child: FlatButton(
          onPressed: (){
            //TODO 返回点选值
            setState(() {
              select = item['value'];
            });
            model.callback(item);
          },
          child: Text(item['text'], style: TextStyle(
              color: (select == null && item['default']) || select == item['value']  ? WBColors.white : WBColors.color_333333,
              fontSize: 12,
              fontFamily: FontConstant.pingFangSC_Regular
          ),)
      ),
    );
  }
}
// 组件调用
// ButtonRadio(
//       ButtonRadioModel(
//           title: '该车车况是否正常？',
//           height: 30,
//           radioData: [{'text':'正常', 'value': '1', 'default': false}, {'text':'异常', 'value': '2', 'default': false}],
//           callback: (result){
//             var value = result['value'];
//           }
//       )),
// )