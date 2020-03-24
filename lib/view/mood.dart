import 'package:flutter/material.dart';
import 'package:smile/config/nets/api_service.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/utils/date_util.dart';

import '../config/constant.dart';
import '../global/toast.dart';
import '../utils/sp_util.dart';
import '../utils/utils.dart';
import '../widgets/select_text.dart';
import '../widgets/dialog.dart';

class MoodPage extends StatefulWidget {
  MoodPage({Key key}) : super(key: key);

  @override
  createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  TextEditingController _notesController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();

  String emotionType = '';
  String diaryDate = DateUtils.today();
  double emotionScore = 0;

  String email = '';

  Color contentColor;

  @override
  void initState() {
    super.initState();

    email = SpUtil.getString(Constant.USER_EMAIL);

    _notesController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _notesController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.kPrimaryColor,
        appBar: AppBar(title: Text(S.of(context).titleMood), centerTitle: true),
        body: ListView(padding: EdgeInsets.all(8), children: <Widget>[
          Form(
              onWillPop: _onBackPressed,
              key: _formKey,
              child: Column(children: <Widget>[
                SelectTextItem(
                    title: S.of(context).diaryDate,
                    content: diaryDate,
                    onTap: () {
//                      showDatePicker(
//                              context: context,
//                              firstDate: DateTime.parse("20200101"),
//                              // 初始选中日期
//                              initialDate: DateTime.now(),
//                              // 可选日期范围第一个日期
//                              lastDate: DateTime.now(),
//                              initialDatePickerMode: DatePickerMode.day)
//                          .then((dateTime) {
//                        setState(() {
//                          diaryDate =
//                              "${dateTime.year}-${dateTime.month}-${dateTime.day}";
//                        });
//                      });
                    }),
                SizedBox(height: 10),
                SelectTextItem(
                    title: S.of(context).moodType,
                    onTap: () {
                      showMoodTypeDialog(context, (value) {
                        if (value != null) {
                          debugPrint('value => ${value?.name}');
                          contentColor = value.color;
                          setState(() => emotionType = value?.name);
                        }
                      });
                    },
                    content: emotionType,
                    contentColor: contentColor),
                SizedBox(height: 20),
                Slider(
                    label: "${emotionScore.toInt()}",
                    divisions: 10,
                    value: emotionScore,
                    onChanged: (rating) {
                      setState(() => this.emotionScore = rating);
                    },
                    min: -5.0,
                    max: 5.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(children: <Widget>[
                    Text(S.of(context).negative),
                    Text(S.of(context).positive)
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ),
                SizedBox(height: 20),
                TextFormField(
                    maxLength: 200,
                    controller: _notesController,
                    maxLines: 8,
                    decoration: InputDecoration(
                        hintText: S.of(context).addMoodStory,
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    style: TextStyle(
                        color: Colors.black,
                        backgroundColor: Colors.white,
                        fontSize: 18)),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 45.0,
                    width: double.infinity,
                    child: FlatButton(
                        color: Theme.of(context).accentColor,
                        disabledColor: Colors.grey,
                        child: Text(S.of(context).submit,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                        onPressed:
                            _notesController.text.isEmpty || emotionType.isEmpty
//                            || diaryDate.isEmpty
                                ? null
                                : () {
                                    Utils.hideKeyboard(context);
                                    showLoadingDialog(
                                        context, S.of(context).saving);
                                    postData(context);
                                  }))
              ]))
        ]));
  }

  Future postData(BuildContext context) async {
    String result = await ApiService().postMood(email, diaryDate, emotionType,
        emotionScore, _notesController.text.toString().trim());

    if (result == 'ok') {
      Toast.show(context, S.of(context).saveSuccess);

      _notesController.text = "";
      emotionType = "";
      emotionScore = 0.0;

      /// diaryDate = "";

      setState(() {});
    } else {
      Toast.show(context, S.of(context).saveFailed);
    }

    Navigator.pop(context);
  }

  Future<bool> _onBackPressed() async {
    Utils.hideKeyboard(context);

    if (_notesController.text.isEmpty &&
            emotionType.isEmpty &&
            emotionScore == 0.0
//        && diaryDate.isEmpty
        ) {
      return true;
    } else {
      return showDialog(
          builder: (context) => AlertDialog(
                  title: Text(S.of(context).exitEdit),
                  actions: <Widget>[
                    FlatButton(
                        child: Text(S.of(context).cancel),
                        onPressed: () => Navigator.pop(context, false)),
                    FlatButton(
                        child: Text(S.of(context).sure),
                        onPressed: () => Navigator.pop(context, true))
                  ]),
          context: context);
    }
  }
}
