import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/utils/sp_util.dart';
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

  int timeInterval = -1;

  bool showSuccessView = false;

  String email = '';

  @override
  void initState() {
    super.initState();

    timeInterval = SpUtil.getInt(Constant.TIME_INTERVAL, defValue: -1);

    if (timeInterval != -1) {
      if (DateTime.now().millisecondsSinceEpoch - timeInterval <=
          Constant.INT_TIME_INTERVAL) {
        email = SpUtil.getString(Constant.SEND_EMAIL);

        showSuccessView = true;
      }
    }

    _userController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _userController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.kPrimaryColor,
        appBar:
            AppBar(title: Text(S.of(context).titleForget), centerTitle: true),
        body: showSuccessView
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(children: [
                  Row(children: <Widget>[
                    Icon(Icons.check, color: Colors.green, size: 40),
                    SizedBox(width: 10),
                    Text('${S.of(context).emailSendSuccess}',
                        style: TextStyle(color: Colors.black, fontSize: 20))
                  ], mainAxisSize: MainAxisSize.min),
                  SizedBox(height: 20),
                  Text('${S.of(context).forgetSuccessTip(email)}',
                      style: TextStyle(
                          color: Colors.black54, fontSize: 17, height: 1.5)),
                  Container(
                      margin: EdgeInsets.only(top: 40),
                      height: 45,
                      width: double.infinity,
                      child: FlatButton(
                          onPressed: () => Navigator.pop(context, '$email'),
                          color: Theme.of(context).accentColor,
                          child: Text(S.of(context).backToLogin,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0))))
                ]))
            : SingleChildScrollView(
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
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
                              onPressed:
                                  Utils.isEmail(_userController.text.toString())
                                      ? () {
                                          showLoadingDialog(
                                              context, S.of(context).sending);
                                          Utils.hideKeyboard(context);
                                          forgetPassword();
                                        }
                                      : null,
                              color: Theme.of(context).accentColor,
                              child: Text(S.of(context).send,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0)))),
                      Container(
                          child: Text(S
                              .of(context)
                              .forgetTip(_userController.text.toString())))
                    ]))));
  }

  void forgetPassword() async {
    email = _userController.text.toString();

    String result = await ApiService().forgetPassword(email);

    if (result == 'ok') {
      SpUtil.setInt(
          Constant.TIME_INTERVAL, DateTime.now().millisecondsSinceEpoch);

      SpUtil.setString(Constant.SEND_EMAIL, email);

      setState(() {
        showSuccessView = true;
      });
    } else {
      Toast.show(context, S.of(context).sendFailed);
    }

    Navigator.pop(context);
  }
}
