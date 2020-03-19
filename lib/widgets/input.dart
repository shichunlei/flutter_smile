import 'package:flutter/material.dart';

class InputView extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;
  final bool autofocus;
  final TextInputType keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  final bool obscure;
  final Duration duration;
  final Widget prefixIcon;
  final TextStyle hintTextStyle;
  final Widget rightView;

  InputView({
    Key key,
    @required this.controller,
    this.maxLength,
    this.autofocus: false,
    this.keyboardType: TextInputType.text,
    this.hintText: "",
    this.focusNode,
    this.nextFocusNode,
    this.obscure: false,
    this.prefixIcon,
    this.hintTextStyle,
    this.duration: const Duration(seconds: 60),
    this.rightView: const SizedBox(),
  }) : super(key: key);

  @override
  createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  bool _isShowPwd = false;
  bool _isShowDelete = true;

  @override
  void initState() {
    super.initState();

    //监听输入改变
    widget.controller.addListener(() {
      setState(() {
        _isShowDelete = widget.controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Stack(alignment: Alignment.centerRight, children: <Widget>[
          TextField(
              focusNode: widget.focusNode,
              maxLength: widget.maxLength,
              style: TextStyle(textBaseline: TextBaseline.alphabetic),
              onEditingComplete: widget.nextFocusNode == null
                  ? null
                  : () =>
                      FocusScope.of(context).requestFocus(widget.nextFocusNode),
              obscureText: widget.obscure ? !_isShowPwd : false,
              autofocus: widget.autofocus,
              controller: widget.controller,
              textInputAction: TextInputAction.done,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
                  hintText: widget.hintText,
                  hintStyle: widget.hintTextStyle ??
                      TextStyle(color: Color(0xffcccccc), fontSize: 14),
                  counterText: "",
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 0.8)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF999999), width: 0.8)),
                  prefixIcon: widget.prefixIcon)),
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Visibility(
                visible: !_isShowDelete,
                child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Icon(Icons.close, size: 18.0),
                    onTap: () => setState(() => widget.controller.text = ""))),
            Visibility(
                visible: widget.obscure,
                child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Icon(
                            _isShowPwd
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 18.0),
                        onTap: () =>
                            setState(() => _isShowPwd = !_isShowPwd)))),
            widget.rightView
          ])
        ]));
  }
}
