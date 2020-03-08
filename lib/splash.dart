import 'package:flutter/material.dart';

import 'config/constant.dart';
import 'home.dart';
import 'utils/route_util.dart';
import 'utils/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  Animation<double> _animation, _opacityAnimation, _scaleAnimation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 3000))
          ..addListener(() => setState(() {}))
          ..addStatusListener((state) {});

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
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: FloatingActionButton(
                      child: Text("12", style: TextStyle(fontSize: 20.0)),
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      foregroundColor: Colors.pink,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        print("F");
                      }),
                  scale: _scaleAnimation))
        ]));
  }
}
