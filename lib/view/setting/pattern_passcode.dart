import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/gesture_recognition/gesture_view.dart';

class PatternPassCodePage extends StatefulWidget {
  PatternPassCodePage({Key key}) : super(key: key);

  @override
  createState() => _PatternPassCodePageState();
}

class _PatternPassCodePageState extends State<PatternPassCodePage> {
  String firstResult = '';
  String verifyResult = '';

  String passCode = '';

  String statusText = "";

  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  bool showBottomView = false;

  @override
  void initState() {
    super.initState();

    passCode = SpUtil.getString(Constant.PASS_CODE);

    Future.microtask(() => statusText = S.of(context).drawPattern);

    debugPrint("passCode => $passCode");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar:
            AppBar(title: Text(S.of(context).titlePasscode), centerTitle: true),
        body: Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 40),
            child: Column(children: <Widget>[
              Text(S.of(context).setPattern,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                      fontSize: 22.0)),
              SizedBox(height: 20),
              Text('$statusText',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.title.color,
                      fontSize: 15.0)),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  child: GestureView(
                      key: gestureStateKey,
                      size: Utils.width * 0.7,
                      onPanUp: (List<int> items) {
                        onPanUp(items);
                      },
                      onPanDown: () {
                        gestureStateKey.currentState.selectColor = Colors.blue;
                        setState(() {
                          statusText = S.of(context).drawing;
                        });
                      },
                      circleRadius: 10,
                      ringRadius: 15,
                      ringWidth: .5,
                      lineWidth: 2)),
              Visibility(
                  visible: showBottomView,
                  child: Row(children: <Widget>[
                    Container(
                        width: 120.0,
                        child: RaisedButton(
                            onPressed: () {
                              firstResult = '';
                              verifyResult = '';
                              showBottomView = false;
                              gestureStateKey.currentState.clearAllData();
                              setState(
                                  () => statusText = S.of(context).drawPattern);
                            },
                            elevation: .0,
                            color: Theme.of(context).accentColor,
                            child: Text(S.of(context).clear),
                            shape: const StadiumBorder())),
                    Container(
                        width: 120.0,
                        child: RaisedButton(
                            onPressed: verifyResult.length > 0 &&
                                    verifyResult == firstResult
                                ? () {
                                    SpUtil.setString(
                                        Constant.PASS_CODE, verifyResult);
                                    SpUtil.setString(
                                        Constant.PASS_CODE_TYPE, 'pattern');

                                    Navigator.pop(context);
                                  }
                                : null,
                            elevation: .0,
                            color: Theme.of(context).accentColor,
                            child: Text(S.of(context).confirm),
                            shape: const StadiumBorder()))
                  ], mainAxisAlignment: MainAxisAlignment.spaceAround))
            ])));
  }

  void onPanUp(List<int> items) {
    if (items.length < 4) {
      gestureStateKey.currentState.selectColor = Colors.red;
      setState(() => statusText = S.of(context).connectLeastFourDots);
    } else {
      showBottomView = true;

      if (firstResult.length > 0) {
        items.forEach((item) => verifyResult += "$item");

        debugPrint("第二次画的结果：${verifyResult.toString()}");

        if (verifyResult == firstResult) {
          gestureStateKey.currentState.selectColor = Colors.blue;
          setState(() {
            statusText = S.of(context).newPattern;
          });
        } else {
          gestureStateKey.currentState.selectColor = Colors.red;
          verifyResult = '';
          statusText = S.of(context).tryAgain;
        }

        setState(() {});
      } else {
        items.forEach((item) {
          firstResult += "$item";
        });
        debugPrint("第一次画的结果：${firstResult.toString()}");
        setState(() {
          statusText = S.of(context).patternRecorded;
        });
        Timer(Duration(milliseconds: 500), () {
          gestureStateKey.currentState.clearAllData();
          setState(() {
            statusText = S.of(context).drawAgain;
          });
        });
      }
    }
  }
}
