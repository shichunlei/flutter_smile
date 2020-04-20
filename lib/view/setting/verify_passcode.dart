import 'package:flutter/material.dart';
import 'package:smile/splash.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/gesture_recognition/gesture_view.dart';

class VerifyPassCodePage extends StatefulWidget {
  final String passCode;

  VerifyPassCodePage({Key key, @required this.passCode}) : super(key: key);

  @override
  createState() => _VerifyPassCodePageState();
}

class _VerifyPassCodePageState extends State<VerifyPassCodePage> {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  String verifyResult = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Hero(
                child: Image.asset("assets/logo.png",
                    width: Utils.width * .3, height: Utils.width * .3),
                tag: "logoImage"),
            SizedBox(height: 40),
            GestureView(
                key: gestureStateKey,
                size: Utils.width * .8,
                onPanUp: (List<int> items) {
                  items.forEach((item) {
                    verifyResult += "$item";
                  });

                  if (widget.passCode == verifyResult) {
                    gestureStateKey.currentState.selectColor = Colors.blue;

                    pushAndRemovePage(context, SplashPage());
                  } else {
                    gestureStateKey.currentState.selectColor = Colors.red;
                    verifyResult = '';
                  }
                },
                onPanDown: () =>
                    gestureStateKey.currentState.selectColor = Colors.blue)
          ]),
        ));
  }
}
