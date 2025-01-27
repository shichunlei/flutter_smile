import 'package:flutter/material.dart';
import 'package:smile/models/gratitude.dart';

import 'item_image.dart';

class UneditablePage extends StatelessWidget {
  final Gratitude gratitude;

  UneditablePage({Key key, @required this.gratitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Container(child: Text('${gratitude?.gratitudeNotes}')),
              Visibility(
                  visible: gratitude.images.length > 0,
                  child: GridView.builder(
                      padding: EdgeInsets.only(top: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 3.0,
                          mainAxisSpacing: 3.0),
                      itemBuilder: (_, index) =>
                          ItemImage(images: gratitude.images, index: index),
                      itemCount: gratitude.images.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true)),
              SizedBox(height: 10),
              Text('${gratitude?.time}', style: TextStyle(color: Colors.grey))
            ], crossAxisAlignment: CrossAxisAlignment.start)));
  }
}
