import 'package:flutter/material.dart';
import 'package:smile/utils/route_util.dart';
import 'package:smile/utils/utils.dart';

import '../view/home.dart';

class CardView extends StatelessWidget {
  final String title;
  final IconData icon;
  final int index;

  CardView({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0.5),
        color: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        child: Material(
            type: MaterialType.transparency,
            child: InkWell(
                onTap: () => pushNewPage(context, HomePage(index: index)),
                child: Container(
                    height: Utils.width * 0.35,
                    width: Utils.width * 0.35,
                    alignment: Alignment.center,
                    child: Column(children: [
                      Icon(icon,
                          color: Color(0xFFF0B2B5), size: Utils.width * 0.15),
                      SizedBox(height: 10),
                      Text('$title',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.5))
                    ], mainAxisSize: MainAxisSize.min)))));
  }
}
