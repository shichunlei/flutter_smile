import 'package:flutter/material.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/widgets/select_text.dart';

import 'setting/account.dart';
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
      appBar: AppBar(title: Text('Setting'), centerTitle: true),
      body: Column(
        children: [
          SizedBox(height: 10),
          SelectTextItem(
            title: 'My Account',
            onTap: () {
              pushNewPage(context, AccountPage());
            },
          ),
          SizedBox(height: 3),
          SelectTextItem(
            title: 'Daily Reminder',
            onTap: () {
              pushNewPage(context, DailyReminderPage());
            },
          ),
          SizedBox(height: 3),
          SelectTextItem(
            title: 'Passcode',
            onTap: () {
              pushNewPage(context, PasscodePage());
            },
          ),
        ],
      ),
    );
  }
}
