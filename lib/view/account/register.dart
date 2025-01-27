import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/icon_font.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/input.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _repwController = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _pwFocusNode = FocusNode();
  FocusNode _repwFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      setState(() {});
    });
    _nameController.addListener(() {
      setState(() {});
    });
    _pwController.addListener(() {
      setState(() {});
    });
    _repwController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _repwController?.dispose();
    _pwController?.dispose();
    _nameController?.dispose();
    _emailController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 40, right: 40, top: 80),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Hero(
                child: Image.asset("assets/logo.png",
                    width: Utils.width * .3, height: Utils.width * .3),
                tag: "logoImage"),
            SizedBox(height: 30),
            Hero(
              tag: "emailEdit",
              child: InputView(
                  controller: _emailController,
                  nextFocusNode: _nameFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  hintText: S.of(context).enterEmail),
            ),
            SizedBox(height: 10),
            InputView(
                controller: _nameController,
                nextFocusNode: _pwFocusNode,
                focusNode: _nameFocusNode,
                prefixIcon: Icon(IconFont.user),
                hintText: S.of(context).enterName),
            SizedBox(height: 10),
            Hero(
                tag: "passwordEdit",
                child: InputView(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _pwController,
                    nextFocusNode: _repwFocusNode,
                    focusNode: _pwFocusNode,
                    prefixIcon: Icon(Icons.lock),
                    hintText: S.of(context).enterPassword,
                    obscure: true)),
            SizedBox(height: 10),
            InputView(
                keyboardType: TextInputType.visiblePassword,
                controller: _repwController,
                focusNode: _repwFocusNode,
                prefixIcon: Icon(Icons.lock),
                hintText: S.of(context).confirmPassword,
                obscure: true),
            Hero(
                tag: "button",
                child: Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 45,
                    width: double.infinity,
                    child: RaisedButton(
                        onPressed:
                            Utils.isEmail(_emailController.text.toString()) &&
                                    _nameController.text.isNotEmpty &&
                                    Utils.checkPassword(_pwController.text,
                                        _repwController.text)
                                ? () {
                                    showLoadingDialog(
                                        context, S.of(context).registering);
                                    Utils.hideKeyboard(context);
                                    _signUp();
                                  }
                                : null,
                        color: Theme.of(context).accentColor,
                        child: Text(S.of(context).register,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0))))),
            Hero(
                tag: "account",
                child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: RichText(
                        text:
                            TextSpan(style: TextStyle(fontSize: 15), children: [
                      TextSpan(
                          text: S.of(context).haveAccount,
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: S.of(context).login,
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.pop(context))
                    ]))))
          ])),
    );
  }

  Future _signUp() async {
    String result = await ApiService().signUp(_emailController.text.toString(),
        _nameController.text.toString(), _pwController.text.toString());

    Navigator.pop(context);

    if (result == 'ok') {
      Toast.show(context, S.of(context).registerSuccess);
      Navigator.pop(context, _emailController.text.toString());
    } else {
      Toast.show(context, S.of(context).registerFailed);
    }
  }
}
