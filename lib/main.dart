import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smile/view/setting/pin_passcode.dart';

import 'provider/gratitude_provider.dart';
import 'provider/config_provider.dart';

import 'view/account/login.dart';
import 'view/setting/verify_passcode.dart';

import 'generated/i18n.dart';

import 'splash.dart';

import 'config/constant.dart';

import 'utils/sp_util.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SpUtil.getInstance();

  runZoned(() {
    /// 设置竖屏
    SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
        .then((_) {
      runApp(MultiProvider(child: MyApp(), providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => LocalProvider()..init()),
        ChangeNotifierProvider(
            create: (BuildContext context) => GratitudeProvider())
      ]));

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
  String passCodeType;

  MyApp({Key key}) : super(key: key) {
    isLogin = SpUtil.getBool(Constant.IS_LOGIN, defValue: false);
    passCode = SpUtil.getString(Constant.PASS_CODE, defValue: '');
    passCodeType = SpUtil.getString(Constant.PASS_CODE_TYPE, defValue: "");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalProvider>(
        builder: (BuildContext context, LocalProvider snapshot, Widget child) =>
            MaterialApp(
              title: 'Smile',
              theme: getThemeData(snapshot.theme),
              home: isLogin
                  ? (Utils.isNotEmptyString(passCode)
                      ? passCodeType == 'pattern'
                          ? VerifyPassCodePage(passCode: passCode)
                          : PinNumberPage(validData: passCode, isValid: true)
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
            ));
  }
}
