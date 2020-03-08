import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/widgets/select_text.dart';

class MoodPage extends StatefulWidget {
  MoodPage({Key key}) : super(key: key);

  @override
  createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  TextEditingController _nameController = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();

  GlobalKey _formKey = GlobalKey<FormState>();

  double rating = 0;

  String moodType = '';

  @override
  void initState() {
    super.initState();
    // 监听输入内容的变化
    _nameController.addListener(() {
      print(_nameController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                TextFormField(
                    controller: _nameController,
                    maxLines: 1,
                    validator: (val) => (val == null || val.isEmpty)
                        ? "Can not be black"
                        : null,
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    style: TextStyle(
                        //设置文本框里面文字的样式
                        color: Colors.black,
                        backgroundColor: Colors.white,
                        fontSize: 18)),
                SizedBox(height: 20),
                SelectTextItem(
                    title: 'Mood Type',
                    onTap: () {
                      showMoodTypeDialog(context, (value) {
                        if (value != null) {
                          print('value => ${value?.name}');

                          setState(() => moodType = value?.name);
                        }
                      });
                    },
                    content: moodType),
                SizedBox(height: 20),
                Slider(
                    label: "$rating",
                    divisions: 10,
                    value: rating,
                    onChanged: (rating) {
                      setState(() => this.rating = rating);
                    }),
                SizedBox(height: 20),
                TextFormField(
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
                        //设置文本框里面文字的样式
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
                          final formState = _formKey.currentState as FormState;
                          if (formState.validate()) {
                            // 验证成功后保存表单内容
                            formState.save();
                          }
                        }))
              ]))
        ]));
  }
}
