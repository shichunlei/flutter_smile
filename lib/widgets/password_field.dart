import 'dart:math';

import 'package:flutter/material.dart';

import '../generated/i18n.dart';

class CustomPasswordField extends StatelessWidget {
  final String data;
  final int length;

  CustomPasswordField({
    Key key,
    this.data,
    this.length: 6,
  })  : assert(data.length <= length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: TextFieldPainter(data, length));
  }
}

///  继承CustomPainter ，来实现自定义图形绘制
class TextFieldPainter extends CustomPainter {
  ///  传入的密码，通过其长度来绘制圆点
  String pwdLength;

  int length;

  TextFieldPainter(this.pwdLength, this.length) {
    // 初始化密码画笔
    mPwdPaint = Paint()..color = Colors.black;

    // 初始化密码框
    mRectPaint = Paint()..color = Color(0xff707070);
  }

  // 密码画笔
  Paint mPwdPaint;
  Paint mRectPaint;

  ///  此处Sizes是指使用该类的父布局大小
  @override
  void paint(Canvas canvas, Size size) {
    ///  圆角矩形的绘制
    RRect r = RRect.fromLTRBR(
        0.0, 0.0, size.width, size.height, Radius.circular(size.height / 12));

    /// 画笔的风格
    mRectPaint.style = PaintingStyle.stroke;
    canvas.drawRRect(r, mRectPaint);

    /// 将其分成六个 格子（六位支付密码）
    var per = size.width / length;
    var offsetX = per;
    while (offsetX < size.width) {
      canvas.drawLine(
          Offset(offsetX, 0.0), Offset(offsetX, size.height), mRectPaint);
      offsetX += per;
    }

    /// 画实心圆
    var half = per / 2;
    var radio = per / 8;
    mPwdPaint.style = PaintingStyle.fill;

    /// 当前有几位密码，画几个实心圆
    for (int i = 0; i < pwdLength.length && i < length; i++) {
      canvas.drawArc(
          Rect.fromLTRB(i * per + half - radio, size.height / 2 - radio,
              i * per + half + radio, size.height / 2 + radio),
          0.0,
          2 * pi,
          true,
          mPwdPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CustomKbBtn extends StatelessWidget {
  ///  按钮显示的文本内容
  final String text;

  ///  按钮 点击事件的回调函数
  final VoidCallback onPressed;

  final ShapeBorder shape;

  CustomKbBtn({
    Key key,
    this.text,
    this.onPressed,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50.0,
        child: OutlineButton(
            shape: shape,
//                RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            borderSide: BorderSide(color: Color(0x10333333)),
            child: Text(text,
                style: TextStyle(color: Color(0xff333333), fontSize: 20.0)),
            onPressed: onPressed));
  }
}

/// 自定义密码 键盘
class MyKeyboard extends StatelessWidget {
  final Function(KeyEvent event) callback;
  final double horizontalSpace;
  final double verticalSpace;
  final EdgeInsetsGeometry margin;
  final ShapeBorder shape;

  MyKeyboard({
    Key key,
    this.callback,
    this.horizontalSpace: 20.0,
    this.verticalSpace: 20.0,
    this.margin: const EdgeInsets.all(20),
    this.shape: const CircleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
//        color: Colors.white,
        padding: margin,
        child: Column(children: <Widget>[
          ///  第一行
          Row(children: <Widget>[
            CustomKbBtn(
                text: '1',
                onPressed: () => callback(KeyEvent('1')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '2',
                onPressed: () => callback(KeyEvent('2')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '3',
                onPressed: () => callback(KeyEvent('3')),
                shape: shape),
          ], mainAxisAlignment: MainAxisAlignment.spaceAround),

          SizedBox(height: verticalSpace),

          ///  第二行
          Row(children: <Widget>[
            CustomKbBtn(
                text: '4',
                onPressed: () => callback(KeyEvent('4')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '5',
                onPressed: () => callback(KeyEvent('5')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '6',
                onPressed: () => callback(KeyEvent('6')),
                shape: shape),
          ], mainAxisAlignment: MainAxisAlignment.spaceAround),

          SizedBox(height: verticalSpace),

          ///  第三行
          Row(children: <Widget>[
            CustomKbBtn(
                text: '7',
                onPressed: () => callback(KeyEvent('7')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '8',
                onPressed: () => callback(KeyEvent('8')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '9',
                onPressed: () => callback(KeyEvent('9')),
                shape: shape),
          ], mainAxisAlignment: MainAxisAlignment.spaceAround),

          SizedBox(height: verticalSpace),

          ///  第四行
          Row(children: <Widget>[
            CustomKbBtn(
                text: '${S.of(context).delete}',
                onPressed: () => callback(KeyEvent('del')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '0',
                onPressed: () => callback(KeyEvent('0')),
                shape: shape),
            SizedBox(width: horizontalSpace),
            CustomKbBtn(
                text: '${S.of(context).sure}',
                onPressed: () => callback(KeyEvent("commit")),
                shape: shape),
          ], mainAxisAlignment: MainAxisAlignment.spaceAround)
        ], mainAxisSize: MainAxisSize.min));
  }
}

class KeyEvent {
  ///  当前点击的按钮所代表的值
  String key;

  KeyEvent(this.key);

  bool isDelete() => this.key == "del";

  bool isCommit() => this.key == "commit";
}
