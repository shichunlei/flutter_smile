import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/input.dart';

import 'package:smile/splash.dart';
import 'package:smile/utils/route_util.dart';

import 'forget.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  FocusNode _pwFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _userController.addListener(() {
      setState(() {});
    });
    _pwController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _userController?.dispose();
    _pwController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.kPrimaryColor,
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 40, right: 40, top: 80),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
                child: Image.asset("assets/logo.png",
                    width: Utils.width * 0.3, height: Utils.width * 0.3),
                tag: "logoImage"),
            SizedBox(height: 30),
            Hero(
                tag: "emailEdit",
                child: InputView(
                    controller: _userController,
                    nextFocusNode: _pwFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icon(Icons.email),
                    hintText: S.of(context).enterEmail)),
            SizedBox(height: 10),
            Hero(
                tag: "passwordEdit",
                child: InputView(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _pwController,
                    focusNode: _pwFocusNode,
                    prefixIcon: Icon(Icons.lock),
                    hintText: S.of(context).enterPassword,
                    obscure: true)),
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 30),
                child: InkWell(
                    onTap: () => pushNewPage(context, ForgetPasswordPage(),
                            callBack: (value) {
                          if (Utils.isNotEmptyString(value)) {
                            _userController.text = value;
                            _pwController.text = "";
                          }
                        }),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).forget,
                          style: TextStyle(color: Colors.blue),
                        ))),
                alignment: Alignment.centerRight),
            Hero(
                tag: "button",
                child: Container(
                    height: 45,
                    width: double.infinity,
                    child: RaisedButton(
                        onPressed:
                            Utils.isEmail(_userController.text.toString()) &&
                                    _pwController.text.isNotEmpty
                                ? () {
                                    showLoadingDialog(
                                        context, S.of(context).logining);
                                    Utils.hideKeyboard(context);
                                    _login();
                                  }
                                : null,
                        color: Theme.of(context).accentColor,
                        child: Text(S.of(context).login,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0))))),
            Hero(
                tag: "account",
                child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: RichText(
                        text:
                            TextSpan(style: TextStyle(fontSize: 15), children: [
                      TextSpan(
                          text: S.of(context).notAccount,
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: S.of(context).register,
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => pushNewPage(context, RegisterPage(),
                                    callBack: (value) {
                                  if (Utils.isNotEmptyString(value)) {
                                    _userController.text = value;
                                    _pwController.text = "";
                                  }
                                }))
                    ]))))
          ])),
    );
  }

  Future _login() async {
    String result = await ApiService()
        .login(_userController.text.toString(), _pwController.text.toString());

    Navigator.pop(context);

    if (result == 'ok') {
      Toast.show(context, S.of(context).loginSuccess);

      String lastUser = SpUtil.getString(Constant.USER_EMAIL, defValue: "");

      if (lastUser != _userController.text.toString()) {
        SpUtil.clear();

        SpUtil.setString(Constant.USER_EMAIL, _userController.text.toString());
      }
      SpUtil.setBool(Constant.IS_LOGIN, true);

      pushAndRemovePage(context, SplashPage());
    } else {
      Toast.show(context, S.of(context).loginFailed);
    }
  }
}
