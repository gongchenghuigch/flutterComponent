/*
 * @Description: new file
 * @Author: gongchenghui
 * @Date: 2021-11-30 11:20:57
 * @LastEditors: gongchenghui
 * @LastEditTime: 2021-11-30 11:22:38
 * @FilePath: /flutterComponent/card/card.dart
 * Copyright (C) 2021 gongchenghui. All rights reserved.
 */
import 'package:flutter/cupertino.dart';
///封装UI卡片组件
class CardWidget extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  /// 卡片内容
  final Widget child;

  const CardWidget({
    this.padding,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      ///设置卡片外间距padding
      padding: padding != null ? padding : EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 0),
      child: Container(
          padding: EdgeInsets.all(15.0),
          decoration: new BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: new BorderRadius.circular(8.0)
          ),
          child: child
      ),
    );
  }}
