import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';

class SelectTextItem extends StatelessWidget {
  const SelectTextItem({
    Key key,
    this.onTap,
    @required this.title,
    this.content: "",
    this.contentColor,
    this.textAlign: TextAlign.end,
    this.style,
    this.leading,
    this.subTitle: "",
    this.height: 50.0,
    this.trailing,
    this.padding: const EdgeInsets.symmetric(horizontal: 10.0),
    this.bgColor,
  })  : assert(title != null, height >= 50.0),
        super(key: key);

  final GestureTapCallback onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final TextStyle style;
  final Widget leading;
  final IconData trailing;
  final String subTitle;
  final double height;
  final EdgeInsetsGeometry padding;
  final Color bgColor;
  final Color contentColor;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: bgColor ?? viewBgColor,
        child: InkWell(
            onTap: onTap,
            child: Container(
                constraints: BoxConstraints(minHeight: 50),
                height: height,
                padding: padding,
                width: double.infinity,
                child: Row(children: <Widget>[
                  Visibility(
                      visible: leading != null,
                      child: Row(children: <Widget>[
                        leading == null ? SizedBox() : leading,
                        SizedBox(height: 8)
                      ])),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('${title ?? ""}',
                            style: TextStyle(fontSize: 14), maxLines: 1),
                        Visibility(
                            visible: subTitle.isNotEmpty,
                            child: Text(subTitle,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis))
                      ]),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: Text("${content ?? ''}",
                              maxLines: 1,
                              textAlign: textAlign,
                              overflow: TextOverflow.ellipsis,
                              style: style ??
                                  TextStyle(
                                      color: contentColor ??
                                          Theme.of(context)
                                              .textTheme
                                              .body1
                                              .color,
                                      fontSize: 12)))),
                  Visibility(
                      visible: onTap != null,
                      child: Icon(trailing ?? Icons.chevron_right, size: 22.0))
                ]))));
  }
}
