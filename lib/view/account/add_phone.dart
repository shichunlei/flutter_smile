import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/icon_font.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/input.dart';

class AddPhoneNumberPage extends StatefulWidget {
  AddPhoneNumberPage({Key key}) : super(key: key);

  @override
  createState() => _AddPhoneNumberPageState();
}

class _AddPhoneNumberPageState extends State<AddPhoneNumberPage> {
  final StreamController<int> _streamController = StreamController<int>();

  String email;

  String mobile;

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  String buttonText;

  Timer _timer;

  bool isTimerCountDown = false;

  @override
  void initState() {
    super.initState();

    email = SpUtil.getString(Constant.USER_EMAIL);

    _phoneController.addListener(() {
      setState(() {});
    });

    _codeController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _streamController?.close();
    _timer?.cancel();
    _phoneController?.dispose();
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
            title: Text(S.of(context).titleAddMobile), centerTitle: true),
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(children: [
                InputView(
                    nextFocusNode: _focusNode,
                    controller: _phoneController,
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    hintText: S.of(context).enterPhoneNumber,
                    prefixIcon: Icon(Icons.phone_iphone)),
                SizedBox(height: 10),
                InputView(
                    controller: _codeController,
                    maxLength: 6,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    rightView: Container(
                        margin: EdgeInsets.only(left: 15),
                        height: 36.0,
                        width: 100.0,
                        child: StreamBuilder<int>(
                            stream: _streamController.stream,
                            initialData: 60,
                            builder: (BuildContext context,
                                AsyncSnapshot<int> snapshot) {
                              return FlatButton(
                                  onPressed: Utils.isNotEmptyString(
                                              _phoneController.text
                                                  .toString()) &&
                                          !isTimerCountDown
                                      ? () {
                                          showLoadingDialog(
                                              context, S.of(context).sending);
                                          Utils.hideKeyboard(context);
                                          getVerifyCode(
                                              _phoneController.text.toString());
                                        }
                                      : null,
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 8.0, end: 8.0),
                                  textColor: Colors.white,
                                  color: Theme.of(context).accentColor,
                                  disabledTextColor: Colors.grey[200],
                                  disabledColor: Color(0xFFcccccc),
                                  child: Text(!isTimerCountDown
                                      ? "${S.of(context).sendCode}"
                                      : "（${snapshot.data} s）"));
                            })),
                    prefixIcon: Icon(IconFont.verify_code),
                    hintText: S.of(context).enterCode),
                SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 45,
                    width: double.infinity,
                    child: RaisedButton(
                        onPressed: _phoneController.text.isNotEmpty &&
                                _codeController.text.isNotEmpty
                            ? () {
                                showLoadingDialog(
                                    context, S.of(context).loading);
                                Utils.hideKeyboard(context);
                                _verifyPhoneNumber(_phoneController.text,
                                    _codeController.text);
                              }
                            : null,
                        color: Theme.of(context).accentColor,
                        child: Text(S.of(context).submit,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0))))
              ])),
        ));
  }

  /// 获取验证码
  ///
  Future getVerifyCode(String mobile) async {
    String result = await ApiService().getVerifyCode(email, mobile);

    Navigator.pop(context);

    if (result == 'ok') {
      Toast.show(context, S.of(context).sendSuccess);

      /// 开始倒计时
      timerCountDown();
    } else {
      Toast.show(context, S.of(context).sendFailed);
    }
  }

  /// 校验并添加手机号码
  ///
  Future _verifyPhoneNumber(String mobile, String code) async {
    String result = await ApiService().verifyPhoneNumber(email, mobile, code);

    Navigator.pop(context);

    if (result == 'ok') {
      Toast.show(context, S.of(context).success);
      Utils.hideKeyboard(context);
      Navigator.pop(context, mobile);
    } else {
      Toast.show(context, S.of(context).failed);
    }
  }

  void timerCountDown() {
    _streamController.sink.add(60);
    int second = 60;
    isTimerCountDown = true;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (second < 1) {
        setState(() {
          isTimerCountDown = false;
        });
        _timer?.cancel();
      } else {
        _streamController.sink.add(--second);
      }
    });
  }
}
