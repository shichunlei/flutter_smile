import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:provider/provider.dart';

import 'package:smile/config/nets/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/provider/gratitude_provider.dart';
import 'package:smile/utils/date_util.dart';
import 'package:smile/widgets/dialog.dart';
import 'package:smile/global/toast.dart';
import 'package:smile/models/gratitude.dart';
import 'package:smile/utils/sp_util.dart';
import 'package:smile/widgets/empty.dart';
import 'package:smile/view/moments/item_moment.dart';
import 'package:smile/widgets/loading.dart';

class MomentsPage extends StatefulWidget {
  MomentsPage({Key key}) : super(key: key);

  @override
  createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage>
    with AutomaticKeepAliveClientMixin {
  List<Gratitude> moments = [];

  String email = '';

  int pageNo = 1;

  bool notMoreData = false;

  PageStatus status = PageStatus.Loading;

  @override
  void initState() {
    super.initState();

    email = SpUtil.getString(Constant.USER_EMAIL);

    getGratitudeQuery(RefreshType.DEFAULT);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar:
            AppBar(centerTitle: true, title: Text(S.of(context).titleMoment)),
        body: status == PageStatus.Loading
            ? LoadingView()
            : EasyRefresh(
                emptyWidget: status == PageStatus.NoData ? EmptyView() : null,
                header: MaterialHeader(),
                footer: BallPulseFooter(),
                onRefresh: status == PageStatus.NoData
                    ? null
                    : () async {
                        pageNo = 1;
                        getGratitudeQuery(RefreshType.REFRESH);
                      },
                onLoad: notMoreData || status == PageStatus.NoData
                    ? null
                    : () async {
                        pageNo++;
                        getGratitudeQuery(RefreshType.LOAD_MORE);
                      },
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      return ItemMoment(
                          gratitude: moments[index],
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
                                                showLoadingDialog(context,
                                                    S.of(context).loading);
                                                deleteGratitude(
                                                    moments[index].id, index);
                                              })
                                        ]),
                                context: context);
                          });
                    },
                    itemCount: moments.length)));
  }

  Future getGratitudeQuery(RefreshType type) async {
    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=GratitudeQuery&UserName=$email&pageno=$pageNo");

    if (_response != null) {
      if (type == RefreshType.DEFAULT || type == RefreshType.REFRESH) {
        moments.clear();

        moments
          ..addAll((json.decode(_response) as List ?? [])
              .map((o) => Gratitude.fromMap(o)));

        if (moments.length < Constant.PAGE_SIZE) {
          notMoreData = true;
        } else {
          notMoreData = false;
        }

        if (moments.length == 0) {
          status = PageStatus.NoData;
        } else {
          status = PageStatus.Succeed;
        }
      } else {
        List<Gratitude> _list = [];

        _list
          ..addAll((json.decode(_response) as List ?? [])
              .map((o) => Gratitude.fromMap(o)));

        if (_list.length < Constant.PAGE_SIZE) {
          notMoreData = true;
        }

        _list.forEach((item) {
          if (!moments.contains(item)) {
            moments.add(item);
          }
        });
      }

      if (!mounted) return;
      setState(() {});
    }
  }

  Future deleteGratitude(int id, int index) async {
    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=GratitudeDelete&gratitudeID=$id&UserName=$email");

    if (_response != null) {
      Map<String, dynamic> _json = json.decode(_response);

      if (_json["success"] == 'ok') {
        if (DateUtils.isToday(moments[index].gratitudeTime)) {
          Provider.of<GratitudeProvider>(context).getGratitudeData();
        }

        Toast.show(context, S.of(context).deleteSuccess);
        moments.removeAt(index);

        if (!mounted) return;
        setState(() {});
      } else {
        Toast.show(context, S.of(context).deleteFailed);
      }
    }

    Navigator.pop(context);
  }

  @override
  bool get wantKeepAlive => true;
}
