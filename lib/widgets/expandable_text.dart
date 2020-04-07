import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle style;
  final bool expand;

  const ExpandableText({
    Key key,
    this.text,
    this.maxLines,
    this.style,
    this.expand: false,
  }) : super(key: key);

  @override
  createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool expand = false;

  @override
  void initState() {
    super.initState();

    this.expand = widget.expand;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => setState(() => this.expand = !this.expand),
        behavior: HitTestBehavior.translucent,
        child: Container(
            child: this.expand
                ? Text(widget.text ?? '',
                    style: widget.style ??
                        TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.body1.color))
                : Text(widget.text ?? '',
                    maxLines: widget.maxLines,
                    overflow: TextOverflow.ellipsis,
                    style: widget.style ??
                        TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.body1.color))));
  }
}
