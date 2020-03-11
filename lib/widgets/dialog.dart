import 'package:flutter/material.dart';
import 'package:smile/models/mood_type.dart';
import 'package:smile/utils/utils.dart';

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

showMoodTypeDialog(
    BuildContext context, Function(MoodType value) callBack) async {
  showDialog<Null>(
      context: context, //BuildContext对象
      barrierDismissible: false,
      builder: (BuildContext context) {
        /// 调用对话框
        return MoodTypeWidget(callBack: callBack);
      });
}

class MoodTypeWidget extends Dialog {
  final Function(MoodType value) callBack;

  MoodTypeWidget({Key key, this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          width: Utils.width * 0.6,
          child: Wrap(
            runSpacing: 5,
            children: types.map((item) {
              return GestureDetector(
                onTap: () {
                  callBack(item);
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: item.color,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${item.name}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }
}
