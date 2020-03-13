import 'package:flutter/material.dart';

class InputView extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final IconData icon;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  final TextInputType keyboardType;

  final bool autofocus;
  final Widget suffixIcon;

  InputView({
    Key key,
    this.controller,
    this.hintText,
    this.obscure: false,
    this.icon,
    this.focusNode,
    this.keyboardType: TextInputType.text,
    this.nextFocusNode,
    this.autofocus: false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        autofocus: autofocus,
        obscureText: obscure,
        onEditingComplete: nextFocusNode == null
            ? null
            : () => FocusScope.of(context).requestFocus(nextFocusNode),
        decoration: InputDecoration(
            icon: icon == null ? null : Icon(icon, color: Colors.black),
            hintText: '$hintText',
            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).accentColor, width: 0.8)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF888888), width: 0.8)),
            suffixIcon: suffixIcon));
  }
}
