import 'package:flutter/material.dart';

class LinePage extends StatefulWidget {
  LinePage({Key key}) : super(key: key);

  @override
  createState() => _LinePageState();
}

class _LinePageState extends State<LinePage> {
  var isSelected = [true, false, false];

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
          centerTitle: true, title: Text('Emotion Line'), elevation: 0.0),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30.0, bottom: 40.0),
            height: 35,
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              children: [
                Container(
                  child: Text('Day'),
                  width: 100.0,
                  alignment: Alignment.center,
                ),
                Container(
                  child: Text('Week'),
                  width: 100.0,
                  alignment: Alignment.center,
                ),
                Container(
                  child: Text('Month'),
                  width: 100.0,
                  alignment: Alignment.center,
                ),
              ],
              onPressed: (int index) {
                isSelected = [false, false, false];
                isSelected[index] = true;

                setState(() {});
              },
              color: Color(0xFF0475FB),
              selectedColor: Colors.white,
              fillColor: Color(0xFF0475FB),
              isSelected: isSelected,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(color: Color(0xFFFCF6F7)),
            ),
          )
        ],
      ),
    );
  }
}
