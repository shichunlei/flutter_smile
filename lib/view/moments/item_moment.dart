import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'package:smile/models/gratitude.dart';

import '../../widgets/expandable_text.dart';
import 'item_banner.dart';

class ItemMoment extends StatelessWidget {
  final Gratitude gratitude;
  final VoidCallback onLongPress;

  ItemMoment({
    Key key,
    @required this.gratitude,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Material(
            type: MaterialType.transparency,
            child: InkWell(
                onLongPress: onLongPress,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      gratitude.images.length > 0
                          ? gratitude.images.length > 1
                              ? AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: Swiper(
                                      autoplay: true,
                                      itemCount: gratitude.images.length,
                                      itemBuilder: (_, index) => ItemBanner(
                                          index: index, gratitude: gratitude),
                                      pagination: SwiperPagination(
                                          alignment: Alignment.bottomCenter)))
                              : ItemBanner(index: 0, gratitude: gratitude)
                          : SizedBox(),
                      Container(
                          padding: EdgeInsets.all(10.0),
                          child: ExpandableText(
                              text: gratitude.gratitudeNotes, maxLines: 3)),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, bottom: 10.0, right: 10.0),
                          child: Text('${gratitude.gratitudeTime}',
                              style: TextStyle(color: Colors.grey[400])))
                    ]))));
  }
}
