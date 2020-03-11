import 'package:flutter/material.dart';
import 'package:smile/utils/sp_util.dart';

import 'package:xml/xml.dart' as xml;

import 'package:smile/splash.dart';
import 'package:smile/utils/route_util.dart';

import 'config/api.dart';
import 'config/constant.dart';
import 'widgets/dialog.dart';
import 'global/toast.dart';
import 'utils/utils.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static var username = '';
  static var password = '';

  List<dynamic> itemsList = List();

  TextEditingController _userController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  FocusNode _pwFocusNode = FocusNode();

  bool obscureText = true;

  @override
  void initState() {
    super.initState();

    _userController.addListener(() {
      setState(() {});
    });
    _pwController.addListener(() {
      setState(() {});
    });

    _userController.text = "info@yok.com.cn";
    _pwController.text = '980219';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.kPrimaryColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 40, right: 40, top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/smile_logo.png",
                width: Utils.width * 0.3, height: Utils.width * 0.3),
            SizedBox(height: 30),
            TextFormField(
              controller: _userController,
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_pwFocusNode),
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                icon: Icon(Icons.email, color: Colors.black),
                hintText: 'Email',
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 0.8)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF888888), width: 0.8)),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _pwController,
              focusNode: _pwFocusNode,
              autofocus: false,
              obscureText: obscureText,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                icon: Icon(Icons.lock, color: Colors.black),
                hintText: 'Password',
                contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor, width: 0.8)),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF888888), width: 0.8)),
                suffixIcon: IconButton(
                  color: Theme.of(context).primaryColor,
                  icon: Icon(
                      !obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 10),
              height: 45,
              width: double.infinity,
              child: RaisedButton(
                onPressed: _userController.text.isNotEmpty &&
                        _pwController.text.isNotEmpty
                    ? () {
                        showLoadingDialog(context, "登录中...");
                        _getLogin();
                      }
                    : null,
                color: Theme.of(context).accentColor,
                child: Text(
                  '登 录',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            Container(
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('忘记密码？'),
                ),
              ),
              alignment: Alignment.centerRight,
            )
          ],
        ),
      ),
    );
  }

  Future _getLogin() async {
    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <IsLogin xmlns="http://tempuri.org/">
        <username>${_userController.text.toString()}</username>
        <pw>${_pwController.text.toString()}</pw>
    </IsLogin>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/IsLogin",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      print("===========> $_response");

      await _parsing(_response);
    }
  }

  Future _parsing(var _response) async {
    var _document = xml.parse(_response);
    Iterable<xml.XmlElement> items =
        _document.findAllElements('IsLoginResponse');
    items.map((xml.XmlElement item) {
      var _addResult = _getValue(item.findElements("IsLoginResult"));
      itemsList.add(_addResult);
    }).toList();

    print("itemsList: $itemsList");

    String _testValue = itemsList.first.toString();

    print("itemsList: $_testValue");

    Navigator.pop(context);

    if (_testValue == 'ok') {
      print("登录成功！");

      Toast.show(context, '登录成功！');

      SpUtil.setString(Constant.USEREMAIL, _userController.text.toString());

      pushAndRemovePage(context, SplashPage(email: username));
    } else if (_testValue == 'error') {
      Toast.show(context, '登录失败！');

      print("登录失败！");
    }
  }

  _getValue(Iterable<xml.XmlElement> items) {
    var textValue;
    items.map((xml.XmlElement node) {
      textValue = node.text;
    }).toList();
    return textValue;
  }
}
