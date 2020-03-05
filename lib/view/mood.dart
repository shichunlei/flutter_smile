import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';

class MoodPage extends StatefulWidget {
  MoodPage({Key key}) : super(key: key);

  @override
  createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  TextEditingController _nameController = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();

  GlobalKey _formKey = GlobalKey<FormState>();

  String _selectType;
  double rating = 0;

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
      appBar: AppBar(
        title: Text('Mood Diary'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  controller: _nameController,
                  maxLines: 1,
                  validator: (val) =>
                      (val == null || val.isEmpty) ? "Can not be black" : null,
                  focusNode: _nameFocusNode,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  style: TextStyle(
                    //设置文本框里面文字的样式
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                DropdownButtonHideUnderline(
                  child: Container(
                      color: Colors.white,
                      child: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: Text('Anxiety'),
                            value: 'Anxiety',
                          ),
                          DropdownMenuItem(
                            child: Text('Happiness'),
                            value: 'Happiness',
                          ),
                          DropdownMenuItem(
                            child: Text('Depression'),
                            value: 'Depression',
                          ),
                          DropdownMenuItem(
                            child: Text('Anger'),
                            value: 'Anger',
                          ),
                          DropdownMenuItem(
                            child: Text('Relaxation'),
                            value: 'Relaxation',
                          ),
                          DropdownMenuItem(
                            child: Text('Neutrality'),
                            value: 'Neutrality',
                          ),
                        ],
                        hint: Text('Please select'),
                        onChanged: (value) {
                          setState(() {
                            _selectType = value;
                          });
                        },
                        value: _selectType,
                        elevation: 24,
                        //设置阴影的高度
                        style: TextStyle(
                          //设置文本框里面文字的样式
                          color: Colors.black,
                          backgroundColor: Colors.white,
                          fontSize: 12,
                        ),
                        isDense: false,
                        //减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                        iconSize: 40.0,
                      )),
                ),
                SizedBox(height: 20),
                Slider(
                  label: "$rating",
                  divisions: 10,
                  value: rating,
                  onChanged: (rating) {
                    setState(() => this.rating = rating);
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
//                  autofocus: true,
                  controller: _nameController,
                  maxLines: 8,
                  validator: (val) =>
                      (val == null || val.isEmpty) ? "Can not be black" : null,
                  focusNode: _nameFocusNode,
                  decoration: InputDecoration(
                    hintText: "Add your mood story here!",
                    prefixIcon: Icon(Icons.pages),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  style: TextStyle(
                    //设置文本框里面文字的样式
                    color: Colors.black,
                    backgroundColor: Colors.white,
                    fontSize: 18,
                  ),
                ),
                RaisedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    final formState = _formKey.currentState as FormState;
                    if (formState.validate()) {
                      // 验证成功后保存表单内容
                      formState.save();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
