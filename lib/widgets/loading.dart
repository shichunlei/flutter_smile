import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  LoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child:
        CircularProgressIndicator(backgroundColor: Colors.greenAccent));
  }
}
