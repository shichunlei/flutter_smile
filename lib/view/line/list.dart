import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:smile/config/nets/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/models/mood.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/widgets/empty.dart';
import 'package:smile/widgets/loading.dart';

import 'widgets/item_mood.dart';

class MoodListPage extends StatefulWidget {
  MoodListPage({Key key}) : super(key: key);

  @override
  createState() => _MoodListPageState();
}

class _MoodListPageState extends State<MoodListPage>
    with AutomaticKeepAliveClientMixin {
  String email = '';

  List<Mood> moods = [];

  int pageNo = 1;

  bool notMoreData = false;

  PageStatus status = PageStatus.Loading;

  @override
  void initState() {
    super.initState();

    email = SpUtil.getString(Constant.USER_EMAIL);

    getMoodsData(RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return status == PageStatus.Loading
        ? LoadingView()
        : EasyRefresh(
            emptyWidget: status == PageStatus.NoData ? EmptyView() : null,
            header: MaterialHeader(),
            footer: BallPulseFooter(),
            onRefresh: () async {
              pageNo = 1;
              getMoodsData(RefreshType.REFRESH);
            },
            onLoad: notMoreData || status == PageStatus.NoData
                ? null
                : () async {
                    pageNo++;
                    getMoodsData(RefreshType.LOAD_MORE);
                  },
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (_, index) {
                  bool lightColor = moods[index].color.computeLuminance() < 0.5;
                  return ItemMood(
                      mood: moods[index],
                      lightColor: lightColor,
                      onLongPress: () {
                        showDialog(
                            builder: (context) => AlertDialog(
                                    title: Text(S.of(context).deleteRecord),
                                    actions: <Widget>[
                                      FlatButton(
                                          child: Text(S.of(context).no),
                                          onPressed: () =>
                                              Navigator.pop(context)),
                                      FlatButton(
                                          child: Text(S.of(context).yes),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            showLoadingDialog(
                                                context, S.of(context).loading);
                                            deleteMood(moods[index].id, index);
                                          })
                                    ]),
                            context: context);
                      });
                },
                itemCount: moods.length));
  }

  @override
  bool get wantKeepAlive => true;

  Future getMoodsData(RefreshType type) async {
    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=MoodQuery&UserName=$email&pageno=$pageNo");

    if (_response != null) {
      if (type == RefreshType.DEFAULT || type == RefreshType.REFRESH) {
        moods.clear();

        moods
          ..addAll((json.decode(_response) as List ?? [])
              .map((o) => Mood.fromMap(context, o)));

        if (moods.length < Constant.PAGE_SIZE) {
          notMoreData = true;
        } else {
          notMoreData = false;
        }

        if (moods.length == 0) {
          status = PageStatus.NoData;
        } else {
          status = PageStatus.Succeed;
        }
      } else {
        List<Mood> _list = [];

        _list
          ..addAll((json.decode(_response) as List ?? [])
              .map((o) => Mood.fromMap(context, o)));

        if (_list.length < Constant.PAGE_SIZE) {
          notMoreData = true;
        }

        _list.forEach((item) {
          if (!moods.contains(item)) {
            moods.add(item);
          }
        });
      }

      if (!mounted) return;
      setState(() {});
    }
  }

  /// 删除Mood
  ///
  Future deleteMood(int id, int index) async {
    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=MoodDelete&moodDiaryID=$id&UserName=$email");

    if (_response != null) {
      Map<String, dynamic> _json = json.decode(_response);

      if (_json["success"] == 'ok') {
        Toast.show(context, 'Success!');
        debugPrint("Success");

        moods.removeAt(index);

        if (moods.length == 0) {
          status = PageStatus.NoData;
        }

        if (!mounted) return;
        setState(() {});
      } else {
        debugPrint("删除失败");
        Toast.show(context, 'Failed!');
      }
    }

    Navigator.pop(context);
  }
}
