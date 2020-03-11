import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile/config/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/widgets/select_text.dart';

import '../widgets/dialog.dart';

class MoodPage extends StatefulWidget {
  MoodPage({Key key}) : super(key: key);

  @override
  createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  TextEditingController _notesController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  GlobalKey _formKey = GlobalKey<FormState>();

  String emotionType = '';
  String diaryDate = '';
  double emotionScore = 0;

  String email = '';

  Color contentColor;

  @override
  void initState() {
    super.initState();

    email = SpUtil.getString(Constant.USEREMAIL);

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
        appBar: AppBar(title: Text('Mood Diary'), centerTitle: true),
        body: ListView(padding: EdgeInsets.all(8), children: <Widget>[
          Form(
              onWillPop: _onBackPressed,
              key: _formKey,
              child: Column(children: <Widget>[
                SelectTextItem(
                  title: "Diary Date",
                  content: diaryDate,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      firstDate: DateTime.parse("20200101"),
                      // 初始选中日期
                      initialDate: DateTime.now(),
                      // 可选日期范围第一个日期
                      lastDate: DateTime.now(),
                      initialDatePickerMode:
                          DatePickerMode.day, //初始化选择模式，有day和year两种
                    ).then((dateTime) {
                      //选择日期后点击OK拿到的日期结果
                      debugPrint(
                          '当前选择了：${dateTime.year}年${dateTime.month}月${dateTime.day}日');

                      setState(() {
                        diaryDate =
                            "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                      });
                    });
                  },
                ),
                SizedBox(height: 10),
                SelectTextItem(
                    title: 'Mood Type',
                    onTap: () {
                      showMoodTypeDialog(context, (value) {
                        if (value != null) {
                          print('value => ${value?.name}');
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
                  min: -5,
                  max: 5.0,
                ),
                Row(
                  children: <Widget>[Text('Negative'), Text('Positive')],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(height: 20),
                TextFormField(
                    focusNode: _focusNode,
                    controller: _notesController,
                    maxLines: 8,
                    validator: (val) => (val == null || val.isEmpty)
                        ? "Can not be empty"
                        : null,
                    decoration: InputDecoration(
                        hintText: "Add your mood story here!",
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
                      color: Colors.white,
                      child: Text("Submit"),
                      onPressed: _notesController.text.isEmpty ||
                              emotionType.isEmpty ||
                              diaryDate.isEmpty
                          ? null
                          : () {
                              if (_focusNode.hasFocus) _focusNode.unfocus();
                              showLoadingDialog(context, "正在保存...");
                              postData(context);
                            },
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.white,
                    ))
              ]))
        ]));
  }

  Future postData(BuildContext context) async {
    var params = {
      "Type": "MoodSave",
      "moodJsondata": '''{"DiaryDate":"$diaryDate",
    "EmotionType":"$emotionType",
    "EmotionScore":"${emotionScore.toInt()}",
    "EmotionNotes":"${_notesController.text}",
    "UserName":"$email"}'''
    };

    var _response = await APIs.postData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx",
        body: params);

    if (_response != null) {
      print("===========> $_response");

      Map<String, dynamic> _json = json.decode(_response);

      if (_json["success"] == 'ok') {
        Toast.show(context, 'Success!');
        print("Success");

        _notesController.text = "";
        emotionType = "";
        emotionScore = 0.0;
        diaryDate = "";

        setState(() {});
      } else {
        print("保存失败");
        Toast.show(context, 'Failed!');
      }
    }

    Navigator.pop(context);
  }

  Future<bool> _onBackPressed() async {
    if (_focusNode.hasFocus) _focusNode.unfocus();

    if (_notesController.text.isEmpty &&
        emotionType.isEmpty &&
        emotionScore == 0.0 &&
        diaryDate.isEmpty) {
      return true;
    } else {
      return showDialog(
        builder: (context) => AlertDialog(
          title: Text('你编辑的心情日记没有提交，确认要退出吗？'),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context, false),
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        ),
        context: context,
      );
    }
  }
}
