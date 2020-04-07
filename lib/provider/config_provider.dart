import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/utils/sp_util.dart';

class LocalProvider extends ChangeNotifier {
  int _localIndex = 0;

  void init() {
    _localIndex = SpUtil.getInt(Constant.LANGUAGE, defValue: 0);
    debugPrint('config get Local $_localIndex');

    _theme = SpUtil.getString(Constant.THEME, defValue: 'light');
    debugPrint('config get Local $_theme');
  }

  int get localIndex => _localIndex;

  void setLocal(local) async {
    _localIndex = local;
    SpUtil.setInt(Constant.LANGUAGE, local);
    notifyListeners();
  }

  String _theme = 'light';

  String get theme => _theme;

  void setTheme(String theme) async {
    _theme = theme;
    SpUtil.setString(Constant.THEME, theme);
    notifyListeners();
  }
}
