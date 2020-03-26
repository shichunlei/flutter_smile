import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/config/nets/api.dart';
import 'package:smile/models/gratitude.dart';
import 'package:smile/utils/date_util.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/view/gratitude/post.dart';

class GratitudeProvider extends ChangeNotifier {
  List<Gratitude> _moments = [];

  PageView _pageView;

  PageView get pageView => _pageView;

  int _gratitudeCount = 0;

  int get gratitudeCount => _gratitudeCount;

  PageController controller;

  int _currentPageIndex = 0;

  int get currentPageIndex => _currentPageIndex;

  Future getGratitudeData() async {
    String today = DateUtils.today();
    String email = SpUtil.getString(Constant.USER_EMAIL);

    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=GetDayList&username=$email&date=$today");

    if (_response != null) {
      _moments.clear();

      _moments
        ..addAll((json.decode(_response) as List ?? [])
            .map((o) => Gratitude.fromMap(o)));
    }

    _gratitudeCount = _moments.length;

    int pagesCount =
        _gratitudeCount > 2 ? _gratitudeCount : (_gratitudeCount + 1);

    debugPrint("========> $pagesCount================> $_gratitudeCount");

    controller = PageController(initialPage: pagesCount - 1);

    List<Widget> pages = [];

    for (int i = 0; i < pagesCount; i++) {
      debugPrint("$i");
      if (_gratitudeCount > 2) {
        pages
            .add(PostPage(email: email, isEdit: false, gratitude: _moments[i]));
      } else {
        pages.add(PostPage(
            email: email,
            isEdit: pagesCount == i + 1,
            gratitude: pagesCount == i + 1 ? null : _moments[i]));
      }
    }

    debugPrint("pages => ${pages.length}");

    _pageView = PageView(
        children: pages,
        controller: controller,
        onPageChanged: (index) {
          _currentPageIndex = index;
          notifyListeners();
        });

    notifyListeners();
  }
}
