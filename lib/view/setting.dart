import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/constant.dart';

import '../provider/config_provider.dart';

import '../generated/i18n.dart';

import '../widgets/dialog.dart';
import '../widgets/select_text.dart';

import '../utils/route_util.dart';

import 'account/account.dart';
import 'setting/change_password.dart';
import 'setting/passcode.dart';

class SettingPage extends StatelessWidget {
  SettingPage({Key key}) : super(key: key);

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
              SelectTextItem(
                  title: S.of(context).theme,
                  onTap: () => openThemeSelectMenu(context),
                  content: Provider.of<LocalProvider>(context).theme == 'light'
                      ? S.of(context).light
                      : S.of(context).dark),
              SizedBox(height: 3),
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
                  onTap: () => exitAppDialog(context))
            ])));
  }
}
