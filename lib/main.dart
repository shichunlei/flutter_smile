import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash.dart';

import 'config/constant.dart';
import 'login.dart';
import 'utils/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SpUtil.getInstance();

  runZoned(() {
    /// 设置竖屏
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MyApp());

      if (Platform.isAndroid) {
        // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        SystemUiOverlayStyle systemUiOverlayStyle =
            SystemUiOverlayStyle(statusBarColor: Colors.transparent);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String email = SpUtil.getString(Constant.USEREMAIL);

    return MaterialApp(
      title: 'Smile',
      theme: ThemeData(
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
                    fontSize: 20)),
          )),
      home: email.isEmpty ? LoginPage() : SplashPage(email: email),
    );
  }
}
