import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'config/constant.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = 'info@yok.com.cn';
  String password = '980219';

  var envelope;

  @override
  void initState() {
    super.initState();

    envelope = '''
    <?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        <IsLogin xmlns="http://tempuri.org/">
          <username>$username</username>
          <pw>$password</pw>
        </IsLogin>
      </soap:Body>
    </soap:Envelope>
    ''';
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
        child: RaisedButton(
          child: Text('登录'),
          onPressed: () {
            _getLogin();
          },
        ),
      ),
    );
  }

  Future _getLogin() async {
    var response =
        await http.post('http://www.yoksoft.com/webapi/webservice1.asmx',
            headers: {
              "Content-Type": "text/xml; charset=utf-8",
              "SOAPAction": "http://tempuri.org/IsLogin",
              "Host": "www.yoksoft.com"
            },
            body: envelope);
    var _response = response.body;
    print("===========> $_response");
  }
}
