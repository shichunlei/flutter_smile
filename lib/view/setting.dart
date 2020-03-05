import 'package:flutter/material.dart';
import 'package:smile/utils/route_util.dart';

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
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(height: 3),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                pushNewPage(context, AccountPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text('My Account'),
                    Icon(Icons.arrow_right),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                height: 55.0,
              ),
            ),
          ),
          SizedBox(height: 3),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                pushNewPage(context, DailyReminderPage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text('Daily Reminder'),
                    Icon(Icons.arrow_right),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                height: 55.0,
              ),
            ),
          ),
          SizedBox(height: 3),
          Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                pushNewPage(context, PasscodePage());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: <Widget>[
                    Text('Passcode'),
                    Icon(Icons.arrow_right),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                height: 55.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
