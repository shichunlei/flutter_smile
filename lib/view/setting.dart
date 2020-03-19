import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/provider/local_provider.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/select_text.dart';

import 'account/account.dart';
import 'account/login.dart';
import 'setting/change_password.dart';
import 'setting/daily_reminder.dart';

import 'setting/passcode.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar:
            AppBar(title: Text(S.of(context).titleSetting), centerTitle: true),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(height: 10),
              SelectTextItem(
                  title: S.of(context).titleAccount,
                  onTap: () => pushNewPage(context, AccountPage())),
              SizedBox(height: 3),
//              SelectTextItem(
//                  title: S.of(context).titleReminder,
//                  onTap: () => pushNewPage(context, DailyReminderPage())),
//              SizedBox(height: 3),
              SelectTextItem(
                  title: S.of(context).language,
                  onTap: () => openLanguageSelectMenu(context),
                  content: mapSupportLocale(context)[SupportLocale
                      .values[Provider.of<LocalProvider>(context).localIndex]]),
              SizedBox(height: 3),
              SelectTextItem(
                  title: S.of(context).titleChangePassword,
                  onTap: () => pushNewPage(context, ChangePasswordPage())),
              SizedBox(height: 3),
              SelectTextItem(
                  title: S.of(context).titlePasscode,
                  onTap: () => pushNewPage(context, PassCodePage())),
              SizedBox(height: 3),
              SelectTextItem(
                  title: S.of(context).exit,
                  onTap: () {
                    showDialog(
                        builder: (context) => AlertDialog(
                                title: Text(S.of(context).exitAccount),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(S.of(context).cancel),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  FlatButton(
                                      child: Text(S.of(context).sure),
                                      onPressed: () {
                                        SpUtil.remove(Constant.IS_LOGIN);
                                        Navigator.of(context).pop();
                                        pushAndRemovePage(context, LoginPage());
                                      })
                                ]),
                        context: context);
                  })
            ])));
  }
}
