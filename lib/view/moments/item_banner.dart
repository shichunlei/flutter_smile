import 'package:flutter/material.dart';
import 'package:smile/models/gratitude.dart';
import 'package:smile/utils/route_util.dart';

import '../photo_view.dart';

class ItemBanner extends StatelessWidget {
  final int index;
  final Gratitude gratitude;

  ItemBanner({Key key, this.index, this.gratitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => pushNewPage(
            context,
            PhotoViewPage(
                index: index,
                heroTag: '${gratitude?.images[index]}${gratitude.id}',
                photos: gratitude.images)),
        child: Hero(
            tag: "${gratitude?.images[index]}${gratitude.id}",
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: FadeInImage(
                  width: double.infinity,
                  placeholder: AssetImage('assets/loading.png'),
                  image: NetworkImage(gratitude?.images[index]),
                  fit: BoxFit.cover),
            )));
  }
}
