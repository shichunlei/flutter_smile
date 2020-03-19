import 'package:flutter/material.dart';

class ToggleDateView extends StatelessWidget {
  final VoidCallback onNextPressed;
  final String text;
  final VoidCallback onPreviousPressed;
  final VoidCallback onTogglePressed;

  ToggleDateView(
      {Key key,
      @required this.onNextPressed,
      @required this.text,
      @required this.onPreviousPressed,
      this.onTogglePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: onPreviousPressed),
              Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                      onTap: onTogglePressed,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('$text')))),
              IconButton(
                  icon: Icon(Icons.arrow_forward_ios), onPressed: onNextPressed)
            ]));
  }
}
