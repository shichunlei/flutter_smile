import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';

class DailyReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.kPrimaryColor,
      appBar: AppBar(
        title: Text(S.of(context).titleReminder),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Container(
              color: Colors.green,
              alignment: Alignment(0.0, 0.0),
              child: new Text("Container"),
              constraints: BoxConstraints(
                  maxHeight: 300.0,
                  maxWidth: 300.0,
                  minWidth: 200.0,
                  minHeight: 120.0),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Text("Flutter"),
            constraints: BoxConstraints.expand(width: 250.0, height: 100.0),
          ),
        ],
      ),
    );
  }
}
