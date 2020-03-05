import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyAccount"),elevation: 0.0,centerTitle: true,
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
