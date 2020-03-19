import 'package:flutter/material.dart';
import 'package:smile/models/gratitude.dart';

import 'editable.dart';
import 'uneditable.dart';

class PostPage extends StatefulWidget {
  final bool isEdit;
  final Gratitude gratitude;
  final String email;

  PostPage({
    Key key,
    @required this.email,
    this.isEdit: true,
    this.gratitude,
  }) : super(key: key);

  @override
  createState() => _PostPageState();
}

class _PostPageState extends State<PostPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: widget.isEdit
            ? EditablePage(email: widget.email)
            : UneditablePage(gratitude: widget.gratitude));
  }

  @override
  bool get wantKeepAlive => true;
}
