import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/splash.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/gesture_recognition/gesture_view.dart';

class VerifyPassCodePage extends StatefulWidget {
  VerifyPassCodePage({Key key}) : super(key: key);

  @override
  createState() => _VerifyPassCodePageState();
}

class _VerifyPassCodePageState extends State<VerifyPassCodePage> {
  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  String verifyResult = '';

  String passCode = '';

  @override
  void initState() {
    super.initState();

    passCode = SpUtil.getString(Constant.PASS_CODE, defValue: '');

    debugPrint("passCode ===> $passCode");
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
              size: Utils.width * 0.8,
              onPanUp: (List<int> items) {
                items.forEach((item) {
                  verifyResult += "$item";
                });

                if (passCode == verifyResult) {
                  gestureStateKey.currentState.selectColor = Colors.blue;

                  pushAndRemovePage(context, SplashPage());
                } else {
                  gestureStateKey.currentState.selectColor = Colors.red;
                  verifyResult = '';
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
