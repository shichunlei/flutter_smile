import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile/config/api.dart';

import 'config/constant.dart';
import 'global/toast.dart';
import 'home.dart';
import 'utils/route_util.dart';
import 'utils/utils.dart';

class SplashPage extends StatefulWidget {
  final String email;

  SplashPage({Key key, @required this.email})
      : assert(email != null),
        super(key: key);

  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  Animation<double> _animation, _opacityAnimation, _scaleAnimation;
  AnimationController controller;

  String days = '0';

  /// 上次点击时间
  DateTime _lastPressedAt;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 3000))
          ..addListener(() => setState(() {}));

    _animation = Tween<double>(
            begin: Utils.height - Utils.width * 0.4 - 50,
            end: Utils.topSafeHeight + 50)
        .animate(CurvedAnimation(
            curve: Interval(.0, .5, curve: Curves.linear), parent: controller));

    _opacityAnimation = Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(.5, 1.0, curve: Curves.ease)));

    _scaleAnimation = Tween(begin: .0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(.5, 1.0, curve: Curves.bounceInOut)));

    /// 启动动画
    controller.forward().orCancel;

    getMoodDays(widget.email);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          backgroundColor: Constant.kPrimaryColor,
          body: Stack(children: <Widget>[
            Opacity(
                opacity: _opacityAnimation.value,
                child: Container(
                    padding: EdgeInsets.only(top: Utils.topSafeHeight),
                    child: Column(children: <Widget>[
                      Align(
                          child: IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () => pushNewPage(context,
                                  HomePage(index: Constant.INDEX_SETTING))),
                          alignment: Alignment.topRight),
                      SizedBox(height: 90 + Utils.width * 0.4),
                      Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          child: Row(children: <Widget>[
                            GestureDetector(
                                child: Image.asset("assets/mooddiary_1.png",
                                    width: Utils.width * 0.4,
                                    height: Utils.width * 0.4),
                                onTap: () => pushNewPage(context,
                                    HomePage(index: Constant.INDEX_MOOD))),
                            GestureDetector(
                                child: Image.asset("assets/emotionline_1.png",
                                    width: Utils.width * 0.4,
                                    height: Utils.width * 0.4),
                                onTap: () => pushNewPage(context,
                                    HomePage(index: Constant.INDEX_LINE)))
                          ], mainAxisSize: MainAxisSize.min)),
                      Row(children: <Widget>[
                        GestureDetector(
                            child: Image.asset("assets/gratitudejournal_1.png",
                                width: Utils.width * 0.4,
                                height: Utils.width * 0.4),
                            onTap: () => pushNewPage(context,
                                HomePage(index: Constant.INDEX_GRATITUDE))),
                        GestureDetector(
                            child: Image.asset("assets/moments_1.png",
                                width: Utils.width * 0.4,
                                height: Utils.width * 0.4),
                            onTap: () => pushNewPage(context,
                                HomePage(index: Constant.INDEX_MOMENTS))),
                      ], mainAxisSize: MainAxisSize.min)
                    ]))),
            Positioned(
                child: Image.asset("assets/smile_logo.png",
                    width: Utils.width * 0.4, height: Utils.width * 0.4),
                left: 0,
                right: 0,
                top: _animation.value),
            Positioned(
                left: 0,
                right: 0,
                top: Utils.topSafeHeight + 50 + Utils.width * 0.4 + 18,
                child: ScaleTransition(
                    child: Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '$days',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '\nDays'),
                            ],
                            style:
                                TextStyle(color: Colors.pink, fontSize: 15.0),
                          ),
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, //阴影颜色
                              blurRadius: 10.0, //阴影大小
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                    ),
                    scale: _scaleAnimation))
          ])),
      onWillPop: _onBackPressed,
    );
  }

  Future getMoodDays(String username) async {
    var daysResult = await APIs.getData(
        'http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=GetMoodDays&UserName=$username');

    if (daysResult != null) {
      print("===========> $daysResult");

      Map<String, dynamic> _json = json.decode(daysResult);

      if (!mounted) return;

      setState(() {
        days = _json["MoodDays"];
      });
    }
  }

  Future<bool> _onBackPressed() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      debugPrint("点击时间");
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      Toast.show(context, "再按一次退出");
      return false;
    }
    return true;
  }
}
