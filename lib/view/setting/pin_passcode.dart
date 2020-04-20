import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/widgets/password_field.dart';

import '../../splash.dart';

class PinNumberPage extends StatefulWidget {
  final bool isValid;
  final String validData;

  PinNumberPage({
    Key key,
    this.isValid: false,
    this.validData: "",
  }) : super(key: key);

  @override
  createState() => _PinNumberPageState();
}

class _PinNumberPageState extends State<PinNumberPage>
    with SingleTickerProviderStateMixin {
  String pwdData = '';

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final Animation curve =
        CurvedAnimation(parent: controller, curve: ShakeCurve());
    animation = Tween(begin: 0.0, end: 10.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            pwdData = '';
            controller.value = 0;
          });
        }
      })
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: widget.isValid
            ? null
            : AppBar(
                title: Text(S.of(context).titlePasscode), centerTitle: true),
        body: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 100 + animation.value),
              width: double.infinity,
              height: 60.0,
              child: CustomPasswordField(data: pwdData)),
          Spacer(),
          MyKeyboard(callback: _onKeyDown)
        ]));
  }

  /// 密码键盘 确认按钮 事件
  void onAffirmButton() {
    if (widget.isValid) {
      /// 校验密码 校验一致
      if (pwdData == widget.validData) {
        pushAndRemovePage(context, SplashPage());
      } else {
        /// 校验不一致
        controller.forward();
      }
    } else {
      /// 初始密码，保存密码
      SpUtil.setString(Constant.PASS_CODE_TYPE, 'pin');
      SpUtil.setString(Constant.PASS_CODE, pwdData);
      Navigator.pop(context);
    }
  }

  /// 密码键盘的整体回调，根据不同的按钮事件来进行相应的逻辑实现
  void _onKeyDown(KeyEvent data) {
    if (data.isDelete()) {
      // 如果点击了删除按钮，则将密码进行修改
      if (pwdData.length > 0) {
        pwdData = pwdData.substring(0, pwdData.length - 1);
        setState(() {});
      }
    } else if (data.isCommit()) {
      // 点击了确定按钮时
      if (pwdData.length != 6) {
        return;
      }
      onAffirmButton();
    } else {
      if (pwdData.length < 6) {
        // 点击了数字按钮时  将密码进行完整的拼接
        pwdData += data.key;
      }
      setState(() {});
    }
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) {
    //t from 0.0 to 1.0
    return sin(t * 3 * pi).abs();
  }
}
