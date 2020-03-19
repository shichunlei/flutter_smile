import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/models/user.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/utils/utils.dart';
import 'package:smile/view/account/add_phone.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/select_text.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<dynamic> itemsList = List();

  String email;

  String mobile;

  User user;

  bool hasMobile = false;

  @override
  void initState() {
    super.initState();

    email = SpUtil.getString(Constant.USER_EMAIL);

    getUserInfo();
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
          AppBar(title: Text(S.of(context).titleAccount), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 10),
            SelectTextItem(
              title: S.of(context).userEmail,
              content: user?.userName ?? "",
            ),
            SizedBox(height: 10),
            SelectTextItem(
              title: S.of(context).userName,
              content: user?.name ?? "",
            ),
            SizedBox(height: 10),
            SelectTextItem(
              title: S.of(context).userMobile,
              content: mobile ?? "",
              onTap: () {
                if (hasMobile) {
                  debugPrint("有手机号码");
                  showDialog(
                      builder: (context) => AlertDialog(
                              title: Text(S.of(context).deletePhoneNumber),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(S.of(context).cancel),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                FlatButton(
                                    child: Text(S.of(context).sure),
                                    onPressed: () {
                                      showLoadingDialog(
                                          context, S.of(context).sending);
                                      removePhone();
                                    })
                              ]),
                      context: context);
                } else {
                  debugPrint("没有手机号码");
                  pushNewPage(context, AddPhoneNumberPage(),
                      callBack: (String value) {
                    if (Utils.isNotEmptyString(value)) {
                      setState(() {
                        hasMobile = true;
                        mobile = value;
                      });
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future getUserInfo() async {
    user = await ApiService().getUserInfo(email);

    hasMobile = Utils.isNotEmptyString(user.mobile);

    if (hasMobile) {
      mobile = user.mobile;
    }

    setState(() {});
  }

  Future removePhone() async {
    String result = await ApiService().removePhone(email);

    Navigator.pop(context);
    if (result == 'ok') {
      setState(() {
        hasMobile = false;
        mobile = "";
      });
      Toast.show(context, S.of(context).deleteSuccess);
    } else {
      Toast.show(context, S.of(context).deleteFailed);
    }
  }
}
