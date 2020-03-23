import 'package:flutter/material.dart';
import 'package:smile/config/nets/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/input.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key}) : super(key: key);

  @override
  createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  List<dynamic> itemsList = List();

  TextEditingController _oldController = TextEditingController();
  TextEditingController _newController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  String username;

  @override
  void initState() {
    super.initState();

    username = SpUtil.getString(Constant.USER_EMAIL);

    _oldController.addListener(() {
      setState(() {});
    });
    _newController.addListener(() {
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
        appBar: AppBar(
            title: Text(S.of(context).titleChangePassword), centerTitle: true),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                InputView(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _oldController,
                    nextFocusNode: _focusNode,
                    prefixIcon: Icon(Icons.lock),
                    hintText: S.of(context).enterOldPassword,
                    obscure: true),
                SizedBox(height: 10),
                InputView(
                    keyboardType: TextInputType.visiblePassword,
                    controller: _newController,
                    focusNode: _focusNode,
                    prefixIcon: Icon(Icons.lock),
                    hintText: S.of(context).enterNewPassword,
                    obscure: true),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 45,
                    width: double.infinity,
                    child: RaisedButton(
                        onPressed: _oldController.text.isNotEmpty &&
                                _newController.text.isNotEmpty
                            ? () {
                                showLoadingDialog(
                                    context, S.of(context).loading);
                                Utils.hideKeyboard(context);
                                _changePassword();
                              }
                            : null,
                        color: Theme.of(context).accentColor,
                        child: Text(S.of(context).submit,
                            style: TextStyle(
                                color: Colors.white, fontSize: 20.0))))
              ],
            ),
          ),
        ));
  }

  Future _changePassword() async {
    var body = '''
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ChangePassword xmlns="http://tempuri.org/">
      <username>$username</username>
      <oldpw>${_oldController.text.toString()}</oldpw>
      <newpw>${_newController.text.toString()}</newpw>
    </ChangePassword>
  </soap:Body>
</soap:Envelope>
''';

    var _response = await APIs.postData(
      "http://www.yoksoft.com/webapi/webservice1.asmx",
      body: body,
      headers: {
        "Content-Type": "text/xml; charset=utf-8",
        "SOAPAction": "http://tempuri.org/ChangePassword",
        "Host": "www.yoksoft.com"
      },
    );

    if (_response != null) {
      debugPrint("===========> $_response");

      String _testValue = Utils.analysisResult(
          _response, "ChangePasswordResponse", "ChangePasswordResult");

      debugPrint("itemsList: $_testValue");

      Navigator.pop(context);

      if (_testValue == 'ok') {
        debugPrint("修改成功！");

        Toast.show(context, S.of(context).updateSuccess);
        Utils.hideKeyboard(context);
        Navigator.pop(context);
      } else {
        Toast.show(context, '$_testValue');

        debugPrint("修改失败！");
      }
    }
  }
}
