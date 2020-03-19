import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui show window;

import 'package:xml/xml.dart' as xml;

import 'package:flutter/services.dart';

class Utils {
  /// 获取运行平台是Android还是IOS
  static bool get isAndroid => Platform.isAndroid;

  static bool get isIOS => Platform.isIOS;

  /// 字符串转颜色
  ///
  /// [string] 字符串
  ///
  static Color strToColor(String string) {
    assert(string.length > 1);
    final int hash = string.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  /// 随机颜色
  ///
  static Color randomRGB() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
  }

  static Color randomARGB() {
    Random random = new Random();
    return Color.fromARGB(random.nextInt(180), random.nextInt(255),
        random.nextInt(255), random.nextInt(255));
  }

  /// 生成随机串
  ///
  /// [len] 字符串长度
  ///
  static String randomString(int len) {
    String character = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < len; i++) {
      left = left + character[Random().nextInt(character.length)];
    }
    return left;
  }

  /// 屏幕宽
  ///
  static double get width {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width;
  }

  /// RPX 用于屏幕适配（比例适配）
  ///
  static double get rpx {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.width / 750;
  }

  /// 屏幕高
  ///
  static double get height {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.size.height;
  }

  /// 标题栏高度（包括状态栏）
  ///
  static double get navigationBarHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top + kToolbarHeight;
  }

  /// 状态栏高度
  ///
  static double get topSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.top;
  }

  /// 底部状态栏高度
  ///
  static double get bottomSafeHeight {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    return mediaQuery.padding.bottom;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  /// 复制到剪粘板
  ///
  static copyToClipboard(String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  /// 隐藏键盘
  ///
  /// [context] 上下文
  ///
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  /// 状态栏状态
  ///
  /// [enable] true为显示；false为隐藏
  ///
  static void statusBarEnable(bool enable) {
    SystemChrome.setEnabledSystemUIOverlays(
        enable ? SystemUiOverlay.values : []);
  }

  /// 是否是空字符串
  ///
  static bool isEmptyString(String str) {
    if (str == null || str.isEmpty || str == "null") {
      return true;
    }
    return false;
  }

  /// 是否不是空字符串
  ///
  static bool isNotEmptyString(String str) {
    if (str != null && str.isNotEmpty && str != "null") {
      return true;
    }
    return false;
  }

  /// 校验邮箱
  ///
  static bool isEmail(String email) {
    if (email == null) return false;
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(
      pattern,
      caseSensitive: false,
      multiLine: false,
    );
    return regex.hasMatch(email);
  }

  static bool checkPassword(String password, String rePassword) {
    if (isEmptyString(password) || isEmptyString(rePassword)) {
      return false;
    }
    if (password == rePassword) {
      return true;
    } else {
      return false;
    }
  }

  static String analysisResult(
      var result, String responseTag, String resultTag) {
    List<dynamic> itemsList = [];

    var _document = xml.parse(result);
    Iterable<xml.XmlElement> items = _document.findAllElements(responseTag);
    items.map((xml.XmlElement item) {
      var _addResult = _getValue(item.findElements(resultTag));
      itemsList.add(_addResult);
    }).toList();

    debugPrint("itemsList=========> $itemsList");

    return itemsList.first.toString();
  }

  static _getValue(Iterable<xml.XmlElement> items) {
    var textValue;
    items.map((xml.XmlElement node) {
      textValue = node.text;
    }).toList();
    return textValue;
  }

  static Future image2Base64(String path) async {
    File file = File(path);
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }
}
