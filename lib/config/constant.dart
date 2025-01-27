import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smile/generated/i18n.dart';

/// 常量配置类
class Constant {
  /// 存储用户邮箱
  static const String IS_LOGIN = "_IS_LOGIN_";

  /// 存储用户邮箱
  static const String USER_EMAIL = "_USER_EMAIL_";

  /// 存储PassCode
  static const String PASS_CODE = "_PASSCODE_";

  static const String PASS_CODE_TYPE = "_PASSCODE_TYPE_";

  /// 存储语言
  static const String LANGUAGE = "_LANGUAGE_";

  /// 存储主题
  static const String THEME = '_THEME_';

  static const String SEND_EMAIL = '_SEND_EMAIL_';

  static const String TIME_INTERVAL = '_TIME_INTERVAL_';

  static const int INT_TIME_INTERVAL = 30 * 60 * 1000;

  static const String IMAGE_BASE_URL = "http://www.yoksoft.com/";

  static const String IMAGE_PATH = "/SimleImg/";

  static const int INDEX_MOOD = 0;
  static const int INDEX_LINE = 1;
  static const int INDEX_GRATITUDE = 2;
  static const int INDEX_MOMENTS = 3;
  static const int INDEX_SETTING = 4;

  static const int IMAGE_MAX_COUNT = 5;

  static Color kPrimaryColor = const Color.fromARGB(255, 246, 229, 231);
  static Color kIconTabTextColor = const Color.fromARGB(255, 0, 118, 255);
  static Color kIconTabBackgroundColor =
      const Color.fromARGB(255, 247, 243, 243);

  static const int PAGE_SIZE = 16;
}

enum RefreshType { LOAD_MORE, DEFAULT, REFRESH }

enum PageStatus { NoAction, Loading, Succeed, Failed, NoData }

/// 枚举: 支持的语言种类
enum SupportLocale { FOLLOW_SYSTEM, SIMPLIFIED_CHINESE, ENGLISH }

/// SupportLocale -> locale
Map<SupportLocale, Locale> mapLocales = {
  SupportLocale.FOLLOW_SYSTEM: null,
  SupportLocale.SIMPLIFIED_CHINESE: Locale("zh", "CN"),
  SupportLocale.ENGLISH: Locale("en", "")
};

/// SupportLocale 对应的含义
Map<SupportLocale, String> mapSupportLocale(BuildContext context) => {
      SupportLocale.FOLLOW_SYSTEM: S.of(context).FOLLOW_SYSTEM,
      SupportLocale.SIMPLIFIED_CHINESE: S.of(context).SIMPLIFIED_CHINESE,
      SupportLocale.ENGLISH: S.of(context).ENGLISH
    };

Color viewBgColor;

ThemeData getThemeData(String theme) {
  ThemeData themeData;
  if (theme == 'light') {
    viewBgColor = Colors.white;
    themeData = ThemeData(
        brightness: Brightness.light,
        backgroundColor: Constant.kPrimaryColor,
        primaryColor: Color(0xFF0475FB),
        accentColor: Colors.cyan[300],
        appBarTheme: AppBarTheme(
            color: Constant.kPrimaryColor,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Color(0xFF0475FB)),
            textTheme: TextTheme(
                title: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20))),
        bottomAppBarColor: Constant.kIconTabBackgroundColor);
  } else {
    viewBgColor = Colors.grey[800];
    themeData = ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF0475FB),
        accentColor: Colors.cyan[300],
        appBarTheme: AppBarTheme(color: Colors.black54));
  }
  return themeData;
}
