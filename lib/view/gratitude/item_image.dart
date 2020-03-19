import 'package:flutter/material.dart';
import 'package:smile/utils/route_util.dart';

import '../photo_view.dart';

class ItemImage extends StatelessWidget {
  final List<String> images;
  final int index;
  final VoidCallback deletePressed;

  ItemImage(
      {Key key,
      @required this.images,
      @required this.index,
      this.deletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        padding: deletePressed != null
            ? EdgeInsets.only(top: 10, right: 10)
            : EdgeInsets.zero,
        child: GestureDetector(
            onTap: () => pushNewPage(
                context,
                PhotoViewPage(
                    photos: images, heroTag: "${images[index]}", index: index)),
            child: Hero(
                tag: "${images[index]}",
                child: FadeInImage(
                    width: double.infinity,
                    height: double.infinity,
                    placeholder: AssetImage('assets/loading.png'),
                    image: NetworkImage(images[index].toString()),
                    fit: BoxFit.cover))),
      ),
      Visibility(
        visible: deletePressed != null,
        child: Positioned(
            child: GestureDetector(
                child: Icon(Icons.cancel, size: 30), onTap: deletePressed),
            right: 0,
            top: 0),
      )
    ]);
  }
}
