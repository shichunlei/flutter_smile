import 'package:flutter/material.dart';
import 'package:smile/generated/i18n.dart';

class MoodType {
  int id;
  String name;
  Color color;
  String showName;

  MoodType({this.id, this.name, this.color, this.showName});
}

List<MoodType> types(BuildContext context) => [
      MoodType(
          id: 1,
          name: "Anxiety",
          color: Colors.red,
          showName: S.of(context).anxiety),
      MoodType(
          id: 2,
          name: "Happiness",
          color: Colors.orange,
          showName: S.of(context).happiness),
      MoodType(
          id: 3,
          name: "Depression",
          color: Colors.blue,
          showName: S.of(context).depression),
      MoodType(
          id: 4,
          name: "Anger",
          color: Colors.yellow,
          showName: S.of(context).anger),
      MoodType(
          id: 5,
          name: "Relaxation",
          color: Colors.green,
          showName: S.of(context).relaxation),
      MoodType(
          id: 6,
          name: "Neutrality",
          color: Colors.grey,
          showName: S.of(context).neutrality),
    ];
