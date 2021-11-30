import '../common/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/font_constant.dart';

class ButtonModel {
  final String text;
  final String value;
  final TextStyle style;

  ButtonModel({this.text, this.value, this.style});
}

typedef confirmFunction = void Function(Map<String, dynamic> result);
class DialogModel {
  final String title;
  final String content;
  final List btn;
  final confirmFunction callback;

  DialogModel({this.title, this.content, this.btn, this.callback});
}
/// 底部默认弹窗
class BottomNormalDialog {


  static show(BuildContext context, DialogModel model) {
    showModalBottomSheet(
      context: context,
      builder: (_) => createDialogContent(context,  model),
      backgroundColor: Colors.transparent,
    );
  }

  static Widget createDialogContent(BuildContext context,  DialogModel model) {
    return SafeArea(child: Container(
      constraints: BoxConstraints(
          minHeight: 195.5 + MediaQuery.of(context).padding.bottom,
          maxHeight: 200 + MediaQuery.of(context).padding.bottom
      ),
      decoration: _createBgDecoration(),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30, bottom: 25),
            child: Text(
              model.title,
              style: TextStyle(
                  fontSize: 20,
                  color: WBColors.color_333333,
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
          Expanded(child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 0, bottom: 30),
            child: Text(
              model.content,
              style: TextStyle(
                  fontSize: 14,
                  color: WBColors.color_333333,
                  fontWeight: FontWeight.w400
              ),
            ),
          )),
          buildButton(context, model)

        ],
      ),
    ));
  }
  /// 循环构建弹窗按钮
  static Widget buildButton(BuildContext context, DialogModel model) {
    List<Widget> tmpList = [];//先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for(int index = 0; index < model.btn.length; index++ ) {
      tmpList.add(
          buildItemButton(context, model.btn[index], index, model.btn.length, model)
      );
    }

    content = Flex(
        direction: Axis.horizontal,
        children: tmpList //重点在这里，因为用编辑器写Column生成的children后面会跟一个<Widget>[]，
    );
    return content;
  }
  /// 渲染底部按钮
  /// @param item 按钮实例
  static Widget buildItemButton(BuildContext context, ButtonModel item, int index, int len, DialogModel model) {
    return Expanded(child: Container(
      height: 44,
      ///如果有两个按钮 第一个按钮需要设置
      margin: EdgeInsets.only(right: len>1&&index == 0 ? 10 : 0, bottom: 8),
      decoration: len>1 ? index == 0 ? createNormalBoxDecoration() : createHighlightBoxDecoration(): createHighlightBoxDecoration(),
      child: FlatButton(
          onPressed: (){
            ///点击按钮关闭弹窗
            Navigator.pop(context);
            model.callback({'result': item.value});
          },
          child: Text(item.text,
              style: len>1? index ==0 ? createNormalTextStyle() : createHighlightTextStyle() : createHighlightTextStyle()
          )
      ),
    ));
  }
  /// 按钮高亮背景
  static Decoration createHighlightBoxDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(colors: [
        WBColors.color_f25228,
        WBColors.color_fcaf3c,
      ], begin: FractionalOffset(0, 1), end: FractionalOffset(1, 0)),
      borderRadius: BorderRadius.circular(22),
    );
  }

  /// 按钮普通背景
  static Decoration createNormalBoxDecoration() {
    return BoxDecoration(
      color: WBColors.color_f5f5f5,
      borderRadius: BorderRadius.circular(22),
    );
  }
  ///高亮按钮字体
  static TextStyle createHighlightTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      color: WBColors.white,
      fontFamily: FontConstant.pingFangSC_Medium
    );
  }
  ///普通按钮字体
  static TextStyle createNormalTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: WBColors.color_333333,
        fontFamily: FontConstant.pingFangSC_Medium
    );
  }
  /// 整体背景
  static Decoration _createBgDecoration() {
    return BoxDecoration(
      color: WBColors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    );
  }
}
//调用示例
// Widget showDialog (BuildContext context) {
//     return BottomNormalDialog.show(
//         context,
//         DialogModel(
//             title:  '请完善信息',
//             content: '车况说明尚未填写完成，确认要离开吗？',
//             btn: [
//               ButtonModel(text: '取消', value: '1'),
//               ButtonModel(text: '确认', value: '2')
//             ],
//             callback:(res){
//               if(res['result'] == '2'){
//                 // Magpie.singleton.closeCurrent(result: {'type': 'back'});
//               }
//             })
//     );
//   }