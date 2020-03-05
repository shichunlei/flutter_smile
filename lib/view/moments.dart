import 'package:flutter/material.dart';

class MomentsPage extends StatefulWidget {
  MomentsPage({Key key}) : super(key: key);

  @override
  createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
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
      appBar: AppBar(centerTitle: true, title: Text('Moments'),elevation: 0.0,),
      body: null,
    );
  }
}
