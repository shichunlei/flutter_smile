import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';

class PasscodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.kPrimaryColor,
      appBar: AppBar(
        title: Text("Passcode"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          FloatingActionButton(
            child: Text("FloatingActionButton"),
            //child: Icon(Icons.add),
            onPressed: () {
              print("F");
            },
          ),
          IconButton(
            color: Colors.red,
            icon: Icon(Icons.favorite),
            onPressed: () {
              print("IconButton");
            },
          ),
          RaisedButton.icon(
            icon: Icon(Icons.favorite),
            label: Text("收藏"),
            onPressed: () {
              print("带Icon的文字按钮");
            },
          ),
        ],
      ),
    );
  }
}
