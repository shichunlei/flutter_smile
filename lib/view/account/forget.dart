import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/input.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({Key key}) : super(key: key);

  @override
  createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _userController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _userController.addListener(() {
      setState(() {});
    });
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
            AppBar(title: Text(S.of(context).titleForget), centerTitle: true),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(children: [
              InputView(
                  controller: _userController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  hintText: S.of(context).enterEmail),
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  height: 45,
                  width: double.infinity,
                  child: RaisedButton(
                      onPressed: Utils.isEmail(_userController.text.toString())
                          ? () {
                              showLoadingDialog(context, S.of(context).sending);
                              Utils.hideKeyboard(context);
                              forgetPassword();
                            }
                          : null,
                      color: Theme.of(context).accentColor,
                      child: Text(S.of(context).send,
                          style:
                              TextStyle(color: Colors.white, fontSize: 20.0)))),
              Container(
                  child: Text(
                      S.of(context).forgetTip(_userController.text.toString())))
            ])));
  }

  void forgetPassword() async {
    String result =
        await ApiService().forgetPassword(_userController.text.toString());

    Navigator.pop(context);

    if (result == 'ok') {
      Toast.show(context, S.of(context).sendSuccess);
    } else {
      Toast.show(context, S.of(context).sendFailed);
    }
  }
}
