import 'package:flutter/material.dart';
import 'package:smile/generated/i18n.dart';

class EmptyView extends StatelessWidget {
  final String text;

  EmptyView({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.signal_cellular_no_sim, size: 70, color: Colors.grey[300]),
          SizedBox(height: 20),
          Text(text ?? S.of(context).noData)
        ],
      ),
    );
  }
}
