import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smile/charts/charts.dart';
import 'package:smile/config/nets/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/models/chart.dart';
import 'package:smile/utils/date_util.dart';
import 'package:smile/utils/sp_util.dart';

import 'widgets/toggle_date.dart';

class MonthView extends StatefulWidget {
  MonthView({Key key}) : super(key: key);

  @override
  createState() => _MonthViewState();
}

class _MonthViewState extends State<MonthView>
    with AutomaticKeepAliveClientMixin {
  String username;

  List<Chart> chartData = [];

  String monthDay;

  bool showView = false;

  @override
  void initState() {
    super.initState();

    username = SpUtil.getString(Constant.USER_EMAIL);

    monthDay = DateUtils.today();

    getMonthData(monthDay);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(children: <Widget>[
      ToggleDateView(
        text:
            '${DateUtils.formatDateByStr(monthDay, formats: [yyyy, "/", mm])}',
        onNextPressed: () {
          showView = false;
          monthDay = DateUtils.nextMonth(monthDay);
          setState(() {});

          getMonthData(monthDay);
        },
        onPreviousPressed: () {
          showView = false;

          monthDay = DateUtils.prevMonth(monthDay);
          setState(() {});

          getMonthData(monthDay);
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
                      primaryYAxis: NumericAxis(minimum: -5, maximum: 5),
                      primaryXAxis: CategoryAxis(labelRotation: 60),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<Chart, String>>[
                          ScatterSeries<Chart, String>(
                              dataSource: chartData,
                              xValueMapper: (Chart sales, _) =>
                                  DateUtils.formatDateByStr(sales.diaryDate,
                                      formats: [mm, "/", dd]),
                              yValueMapper: (Chart sales, _) =>
                                  sales.emotionScore)
                        ])
                  : Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.greenAccent))))
    ]);
  }

  @override
  bool get wantKeepAlive => true;

  void getMonthData(String monthDay) async {
    List<String> monthDays = DateUtils.monthDays(monthDay);

    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=MoodQueryPeriod&PeriodType=Month&UserName=$username&InputDate=$monthDay");

    if (_response != null) {
      chartData.clear();

      monthDays.forEach((item) {
        int index = monthDays.indexOf(item);

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
