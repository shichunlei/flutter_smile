import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smile/utils/utils.dart';

import 'provider/gratitude_provider.dart';
import 'view/account/login.dart';
import 'view/setting/verify_passcode.dart';
import 'generated/i18n.dart';
import 'provider/local_provider.dart';
import 'splash.dart';

import 'config/constant.dart';
import 'utils/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SpUtil.getInstance();

  runZoned(() {
    /// 设置竖屏
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
        .then((_) {
      runApp(
        MultiProvider(
          child: MyApp(),
          providers: [
            ChangeNotifierProvider(
                create: (BuildContext context) => LocalProvider()..init()),
            ChangeNotifierProvider(
                create: (BuildContext context) => GratitudeProvider())
          ],
        ),
      );

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
  bool isLogin;
  String passCode;

  MyApp({Key key}) : super(key: key) {
    isLogin = SpUtil.getBool(Constant.IS_LOGIN, defValue: false);
    passCode = SpUtil.getString(Constant.PASS_CODE, defValue: '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalProvider>(
      builder: (BuildContext context, LocalProvider snapshot, Widget child) {
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
                          fontSize: 20)))),
          home: isLogin
              ? (Utils.isNotEmptyString(passCode)
                  ? VerifyPassCodePage()
                  : SplashPage())
              : LoginPage(),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            S.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,

          /// 不存对应locale时，默认取值Locale('zh', 'CN')
          localeResolutionCallback:
              S.delegate.resolution(fallback: const Locale('zh', 'CN')),

          locale: mapLocales[SupportLocale.values[snapshot.localIndex]],
        );
      },
    );
  }
}
