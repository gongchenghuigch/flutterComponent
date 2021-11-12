import 'package:flutter/material.dart';
import '../common/colors.dart';
import '../common/font_const.dart';
import 'package:flutter/widgets.dart';

typedef textareaCallback = void Function(String text);
///定义组件参数model入参实例
class TextareaModel {
  final String title; ///textarea输入框标题
  final String placeholder; ///textarea占位符
  final int maxLength; ///textarea输入框允许输入最多的字符
  final int maxLines; ///textarea输入框最多展示多少行
  final bool count;
  final bool required; ///是否必填
  final bool borderLine; ///是否线上输入框外边线
  final textareaCallback callback; ///textarea输入框回调

  TextareaModel({
    this.title = '',
    this.placeholder,
    this.maxLength = 200,
    this.maxLines = 5,
    this.required = false,
    this.count = false,
    this.borderLine = false,
    this.callback
  });
}

class Textarea extends StatefulWidget {
  final TextareaModel model;

  const Textarea(this.model) ;

  TextareaState createState() => new TextareaState();

}

class TextareaState extends State<Textarea> {
  int _len = 0;
  TextEditingController textareaController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    textareaController.addListener(() {
      setState(() {
        _len = textareaController.text.length;
      });
    });
  }
  void dispose() {
    textareaController.removeListener(() { });
    textareaController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return createTextareaState(context, widget.model);
  }

  Widget createTextareaState(BuildContext context, TextareaModel model) {
    return Container(
      color: WBColors.white,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                          model.title,
                          style: TextStyle(
                              fontSize: 16,
                              color: WBColors.color_333333,
                              fontFamily: FontConst.pingFangSC_Medium,
                              fontWeight: FontWeight.w500
                          )
                      ),
                      Text(
                          model.required ? '（必填）': '（选填）',
                          style: TextStyle(
                              fontSize: 11,
                              color: model.required ? WBColors.color_ff552e : WBColors.color_333333,
                              fontFamily: FontConst.pingFangSC_Medium,
                              fontWeight: FontWeight.w500
                          )
                      )
                    ],
                  ),
              )
            ],
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            controller: textareaController,
            maxLines: model.maxLines,
            maxLength: model.maxLength,
            decoration: InputDecoration(
                hintText: model.placeholder,
                contentPadding: EdgeInsets.all(model.borderLine?5:0),
                enabledBorder: model.borderLine ? OutlineInputBorder( //未选中时候的颜色
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: WBColors.color_eaeaea, width: 0.5),
                ): InputBorder.none,
                focusedBorder: model.borderLine ? OutlineInputBorder( //选中时外边框颜色
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: WBColors.color_eaeaea, width: 0.5),
                ): InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: FontConst.pingFangSC_Medium,
                  color: WBColors.color_cccccc,
                ),
                counterText: '',
            ),
            onChanged: (event) {
              ///监听输入框 回传输入框的值
              model.callback(event);
            } ,
          ),
          model.count?Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  '$_len/${model.maxLength}字',
                  style: TextStyle(
                      fontSize: 12, color: WBColors.color_999999),
                ),
              )
            ],
          ):Text(''),
        ],
      ),
    );
  }
}