import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.kPrimaryColor,
      appBar: AppBar(
        title: Text("MyAccount"),
        centerTitle: true,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100.0,
          minHeight: 100.0,
          maxWidth: 250.0,
          maxHeight: 250.0,
        ),
        child: new Container(
          width: 300.0,
          height: 300.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
