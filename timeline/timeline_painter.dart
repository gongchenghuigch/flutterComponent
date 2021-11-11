import 'dart:async';
import 'dart:ui' as UI;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
///自定义视图展示
class TimelinePainter extends CustomPainter {

  final Color lineColor;
  final Color backgroundColor;
  final bool firstElement;
  final bool lastElement;
  final Animation<double> controller;
  final Animation<double> height;

  TimelinePainter({
    @required this.lineColor,
    @required this.backgroundColor,
    this.firstElement = false,
    this.lastElement = false,
    this.controller
  }) :height = new Tween(begin: 0.0, end: 1.0).animate(new CurvedAnimation(
    parent: controller,
    curve: new Interval(
        0.45, 1.0,
        curve: Curves.ease),
  ),
  ),
        super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    _centerElementPaint(canvas, size);
  }

  void _centerElementPaint(Canvas canvas, Size size)
  {
    Paint lineStroke = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;
    if(firstElement && lastElement)
    {
      Offset offsetCenter = size.topCenter(new Offset(0.0, 2.0));
      Offset offsetBottom = size.bottomCenter(new Offset(0.0, 0.0));
      Offset renderOffset = new Offset(offsetBottom.dx, offsetBottom.dy*(0.5+(controller.value/2)));
      canvas.drawLine(
          offsetCenter,
          renderOffset,
          lineStroke);
    }
    else if(firstElement)
    {
      ///偏移量从顶部开始计算
      Offset offsetTop  = size.topCenter(new Offset(0.0, 0.0));
      Offset offsetBottom = size.bottomCenter(new Offset(0.0, 0.0));
      Offset renderOffset = new Offset(offsetBottom.dx, offsetBottom.dy*(0.5+(controller.value/2)));
      canvas.drawLine(
          offsetTop,
          renderOffset,
          lineStroke);
    }
    else if(lastElement)
    {
      Offset offsetTopCenter = size.topCenter(new Offset(0.0, 0.0));
      Offset offsetCenter = size.center(new Offset(0.0, 20.0));
      Offset renderOffset = new Offset(offsetCenter.dx, offsetCenter.dy*controller.value);
      canvas.drawLine(
          offsetTopCenter,
          renderOffset,
          lineStroke);
    }
    else {
      Offset offsetTopCenter = size.topCenter(new Offset(0.0, 0.0));
      Offset offsetBottom = size.bottomCenter(new Offset(0.0, 0.0));
      Offset renderOffset = new Offset(offsetBottom.dx, offsetBottom.dy*controller.value);
      canvas.drawLine(
          offsetTopCenter,
          renderOffset,
          lineStroke);
    }

    Paint circleFill = new Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;
    // canvas.drawImage(_image, Offset(0.0, -8.0), circleFill);
    canvas.drawCircle(size.topCenter(new Offset(0.0, 0.0)), 3.5, circleFill);

  }

  @override
  bool shouldRepaint(TimelinePainter oldDelegate) {
    return oldDelegate.lineColor!=lineColor || oldDelegate.backgroundColor!=backgroundColor;
  }

}
