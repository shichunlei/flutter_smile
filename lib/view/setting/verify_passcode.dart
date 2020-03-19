import 'package:flutter/material.dart';
import 'package:gesture_recognition/gesture_view.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/splash.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';

class VerifyPassCodePage extends StatefulWidget {
  VerifyPassCodePage({Key key}) : super(key: key);

  @override
  createState() => _VerifyPassCodePageState();
}

class _VerifyPassCodePageState extends State<VerifyPassCodePage> {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  List<String> verifyResult = [];

  List<String> passCode = [];

  @override
  void initState() {
    super.initState();

    passCode = SpUtil.getStringList(Constant.PASS_CODE);

    print(passCode);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Hero(
                child: Image.asset("assets/smile_logo.png",
                    width: Utils.width * 0.3, height: Utils.width * 0.3),
                tag: "logoImage"),
            SizedBox(height: 40),
            GestureView(
              key: gestureStateKey,
              immediatelyClear: false,
              size: Utils.width * 0.8,
              onPanUp: (List<int> items) {
                items.forEach((item) {
                  verifyResult.add("$item");
                });

                if (passCode.length == verifyResult.length) {
                  for (int i = 0; i < items.length; i++) {
                    if (passCode[i] != verifyResult[i]) break;
                  }
                  gestureStateKey.currentState.selectColor = Colors.blue;

                  pushAndRemovePage(context, SplashPage());
                } else {
                  gestureStateKey.currentState.selectColor = Colors.red;
                  verifyResult.clear();
                }
              },
              onPanDown: () {
                gestureStateKey.currentState.selectColor = Colors.blue;
              },
            ),
          ],
        ),
      ),
    );
  }
}
