import 'package:flutter/material.dart';

class GratitudePage extends StatefulWidget {
  GratitudePage({Key key}) : super(key: key);

  @override
  createState() => _GratitudePageState();
}

class _GratitudePageState extends State<GratitudePage> {
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
      appBar:
          AppBar(centerTitle: true, elevation: 0.0, title: Text('Gratitude')),
      body: null,
    );
  }
}
