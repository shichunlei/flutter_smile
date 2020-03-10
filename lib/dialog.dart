import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context, String text) async {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        /// 调用对话框
        return LoadingDialog(text: text);
      });
}

class LoadingDialog extends Dialog {
  final String text;
  final Color bgColor;

  LoadingDialog({
    Key key,
    @required this.text,
    this.bgColor: const Color(0x4b000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Center(
            child: Container(
                width: 120.0,
                height: 120.0,
                decoration: ShapeDecoration(
                    color: bgColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: CircularProgressIndicator(
                              backgroundColor: Colors.greenAccent)),
                      Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(text,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)))
                    ]))));
  }
}
