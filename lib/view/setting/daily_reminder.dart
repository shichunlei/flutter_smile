import 'package:flutter/material.dart';

class DailyReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DailyReminder"),elevation: 0.0,centerTitle: true,
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
