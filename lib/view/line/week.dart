import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:smile/config/nets/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/models/chart.dart';
import 'package:smile/utils/date_util.dart';
import 'package:smile/utils/sp_util.dart';

import 'widgets/toggle_date.dart';

class WeekView extends StatefulWidget {
  WeekView({Key key}) : super(key: key);

  @override
  createState() => _WeekViewState();
}

class _WeekViewState extends State<WeekView>
    with AutomaticKeepAliveClientMixin {
  String username;

  List<Chart> chartData = [];

  String weekDay;

  bool showView = false;

  @override
  void initState() {
    super.initState();

    username = SpUtil.getString(Constant.USER_EMAIL);

    weekDay = DateUtils.today();

    getWeekData(weekDay);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        ToggleDateView(
          text: '${DateUtils.monday(dateStr: weekDay, formats: [
            mm,
            '/',
            dd
          ])}~${DateUtils.sunday(dateStr: weekDay, formats: [mm, '/', dd])}',
          onNextPressed: () {
            weekDay = DateUtils.formatDateByMs(
                DateTime.parse(weekDay).millisecondsSinceEpoch +
                    7 * MILLISECONDS,
                formats: [yyyy, "-", mm, "-", dd]);

            setState(() {
              showView = false;
            });
            getWeekData(weekDay);
          },
          onPreviousPressed: () {
            weekDay = DateUtils.formatDateByMs(
                DateTime.parse(weekDay).millisecondsSinceEpoch -
                    7 * MILLISECONDS,
                formats: [yyyy, "-", mm, "-", dd]);

            setState(() {
              showView = false;
            });
            getWeekData(weekDay);
          },
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(color: Color(0xFFFCF6F7)),
            child: showView
                ? SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    primaryYAxis: NumericAxis(minimum: -5, maximum: 5),
                    series: <ChartSeries<Chart, String>>[
                        ScatterSeries<Chart, String>(
                            dataSource: chartData,
                            xValueMapper: (Chart sales, _) =>
                                DateUtils.formatDateByStr(sales.diaryDate,
                                    formats: [EE_EN]),
                            yValueMapper: (Chart sales, _) =>
                                sales.emotionScore)
                      ])
                : Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.greenAccent)),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  void getWeekData(String weekDay) async {
    List<String> weekdays = DateUtils.weekdays(weekDay);

    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=MoodQueryPeriod&PeriodType=Week&UserName=$username&InputDate=$weekDay");

    if (_response != null) {
      chartData.clear();

      weekdays.forEach((item) {
        int index = weekdays.indexOf(item);

        chartData.add(Chart(diaryDate: item, emotionScore: null));

        (json.decode(_response) as List ?? []).forEach((chart) {
          if (chart['DiaryDate'] == item) {
            chartData[index] =
                Chart(diaryDate: item, emotionScore: chart['EmotionScore']);
          }
        });

        debugPrint("${chartData[index].toJson()}");
      });
    }

    if (!mounted) return;
    setState(() {
      showView = true;
    });
  }
}
