import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/utils/sp_util.dart';

class LocalProvider extends ChangeNotifier {
  int _localIndex = 0;

  void init() {
    _localIndex = SpUtil.getInt(Constant.LANGUAGE, defValue: 0);
    debugPrint('config get Local $_localIndex');
  }

  int get localIndex => _localIndex;

  void setLocal(local) async {
    _localIndex = local;
    SpUtil.setInt(Constant.LANGUAGE, local);
    notifyListeners();
  }
}
