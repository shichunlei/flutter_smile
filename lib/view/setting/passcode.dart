import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/gesture_recognition/gesture_view.dart';
import 'package:smile/widgets/select_text.dart';

class PassCodePage extends StatefulWidget {
  PassCodePage({Key key}) : super(key: key);

  @override
  createState() => _PassCodePageState();
}

class _PassCodePageState extends State<PassCodePage> {
  String firstResult = '';
  String verifyResult = '';

  String passCode = '';

  String statusText = "";

  GlobalKey<GestureState> gestureStateKey = GlobalKey();

  bool immediatelyClear = false;

  bool showBottomView = false;

  @override
  void initState() {
    super.initState();

    passCode = SpUtil.getString(Constant.PASS_CODE);

    Future.microtask(() => statusText = S.of(context).drawPattern);

    debugPrint("passCode => $passCode");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.kPrimaryColor,
        appBar:
            AppBar(title: Text(S.of(context).titlePasscode), centerTitle: true),
        body: passCode.length > 0
            ? Container(
                margin: EdgeInsets.all(20),
                child: Column(children: [
                  SelectTextItem(
                      title: S.of(context).turnOffLock,
                      onTap: () {
                        showDialog(
                            builder: (context) => AlertDialog(
                                    title: Text(S.of(context).deletePassCode),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(S.of(context).cancel),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      FlatButton(
                                          child: Text(S.of(context).sure),
                                          onPressed: () {
                                            SpUtil.remove(Constant.PASS_CODE);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          })
                                    ]),
                            context: context);
                      }),
                  SizedBox(height: 3),
                  SelectTextItem(
                      title: S.of(context).changeScreenLock,
                      onTap: () => setState(() => passCode = ""))
                ]))
            : Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 40),
                child: Column(children: <Widget>[
                  Text(S.of(context).setPattern,
                      style: TextStyle(color: Colors.black, fontSize: 22.0)),
                  SizedBox(height: 20),
                  Text('$statusText',
                      style: TextStyle(color: Colors.black, fontSize: 15.0)),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    child: GestureView(
                        key: gestureStateKey,
                        size: Utils.width * 0.7,
                        onPanUp: (List<int> items) {
                          onPanUp(items);
                        },
                        onPanDown: () {
                          gestureStateKey.currentState.selectColor =
                              Colors.blue;
                          setState(() {
                            statusText = S.of(context).drawing;
                          });
                        },
                        circleRadius: 10,
                        ringRadius: 15,
                        ringWidth: .5,
                        lineWidth: 2),
                  ),
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
                                  setState(() {
                                    statusText = S.of(context).drawPattern;
                                  });
                                },
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

                                        Navigator.pop(context);
                                      }
                                    : null,
                                child: Text(S.of(context).confirm),
                                shape: const StadiumBorder()))
                      ], mainAxisAlignment: MainAxisAlignment.spaceAround))
                ])));
  }

  void onPanUp(List<int> items) {
    if (items.length < 4) {
      gestureStateKey.currentState.selectColor = Colors.red;
      setState(() {
        statusText = S.of(context).connectLeastFourDots;
      });
    } else {
      showBottomView = true;

      if (firstResult.length > 0) {
        items.forEach((item) {
          verifyResult += "$item";
        });

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
