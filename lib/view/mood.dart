import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile/config/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/select_text.dart';

import '../dialog.dart';

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
  String diaryDate;
  double emotionScore = 0;

  @override
  void initState() {
    super.initState();
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

                          setState(() => emotionType = value?.name);
                        }
                      });
                    },
                    content: emotionType),
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
                        onPressed: () {
                          if (_focusNode.hasFocus) _focusNode.unfocus();
                          showLoadingDialog(context, "登录中...");
                          postData(context);
                        }))
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
    "UserName":"info@yok.com.cn"}'''
    };

    var _response = await APIs.postData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx",
        body: params);

    if (_response != null) {
      print("===========> $_response");

      Map<String, dynamic> _json = json.decode(_response);

      if (_json["success"] == 'ok') {
        print("上传成功");
      } else {
        print("上传失败");
      }
    }

    Navigator.pop(context);
  }
}
