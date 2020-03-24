import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/icon_font.dart';
import 'package:smile/models/mood_type.dart';
import 'package:smile/provider/local_provider.dart';
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
          width: Utils.width * 0.8,
          child: Wrap(
            runSpacing: 5,
            children: types(context).map((item) {
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
                    '${item.showName}',
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

/// 国际化
void openLanguageSelectMenu(BuildContext context) async {
  await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) => Container(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: SupportLocale.values.map((local) {
                  int index = SupportLocale.values.indexOf(local);
                  return ListTile(
                      title: Text("${mapSupportLocale(context)[local]}"),
                      onTap: () {
                        Provider.of<LocalProvider>(context, listen: false)
                            .setLocal(index);
                        Navigator.pop(context);
                      },
                      selected:
                          Provider.of<LocalProvider>(context).localIndex ==
                              index);
                }).toList()),
            padding: EdgeInsets.only(bottom: Utils.bottomSafeHeight),
          ));
}

void showBottomView(
    BuildContext context, Function(ImageSource source) callBack) async {
  Utils.hideKeyboard(context);
  await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) => Container(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                  leading: Icon(IconFont.camera),
                  title: Text(S.of(context).camera),
                  onTap: () {
                    callBack(ImageSource.camera);
                    Navigator.pop(context);
                  }),
              ListTile(
                  leading: Icon(IconFont.gallery),
                  title: Text(S.of(context).gallery),
                  onTap: () {
                    callBack(ImageSource.gallery);
                    Navigator.pop(context);
                  })
            ]),
            padding: EdgeInsets.only(bottom: Utils.bottomSafeHeight),
          ));
}
