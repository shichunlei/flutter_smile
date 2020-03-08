import 'package:flutter/material.dart';

class MoodType {
  int id;
  String name;
  Color color;

  MoodType({this.id, this.name, this.color});
}

List<MoodType> types = [
  MoodType(id: 1, name: "Anxiety", color: Colors.red),
  MoodType(id: 2, name: "Happiness", color: Colors.orange),
  MoodType(id: 3, name: "Depression", color: Colors.blue),
  MoodType(id: 4, name: "Anger", color: Colors.yellow),
  MoodType(id: 5, name: "Relaxation", color: Colors.green),
  MoodType(id: 6, name: "Neutrality", color: Colors.grey),
];
