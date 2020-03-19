import 'package:flutter/material.dart';
import 'package:smile/models/mood.dart';

class ItemMood extends StatelessWidget {
  final Mood mood;
  final bool lightColor;
  final VoidCallback onLongPress;

  ItemMood({
    Key key,
    this.mood,
    this.lightColor,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(5),
        color: mood.color,
        child: Material(
            type: MaterialType.transparency,
            child: InkWell(
                onLongPress: onLongPress,
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(children: [
                      Text('${mood.emotionType}',
                          style: TextStyle(
                              color: lightColor ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                      SizedBox(height: 10),
                      Text('${mood.emotionNotes}',
                          style: TextStyle(
                              color: lightColor ? Colors.white : Colors.black,
                              fontSize: 14)),
                      SizedBox(height: 10),
                      Row(children: <Widget>[
                        Text('${mood.emotionScore.toInt()}',
                            style: TextStyle(
                                color: lightColor
                                    ? Colors.grey[200]
                                    : Colors.black,
                                fontSize: 12)),
                        Text('${mood.createdDate}',
                            style: TextStyle(
                                color: lightColor
                                    ? Colors.grey[200]
                                    : Colors.black,
                                fontSize: 12))
                      ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
                    ], crossAxisAlignment: CrossAxisAlignment.start)))));
  }
}
