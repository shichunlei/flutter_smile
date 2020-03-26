import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:smile/config/nets/api.dart';
import 'package:smile/config/constant.dart';
import 'package:smile/models/chart.dart';
import 'package:smile/utils/date_util.dart';
import 'package:smile/utils/sp_util.dart';

import 'widgets/toggle_date.dart';

class DayView extends StatefulWidget {
  DayView({Key key}) : super(key: key);

  @override
  createState() => _DayViewState();
}

class _DayViewState extends State<DayView> with AutomaticKeepAliveClientMixin {
  String username;

  List<Chart> chartData = [];

  String day;

  bool showView = false;

  @override
  void initState() {
    super.initState();

    username = SpUtil.getString(Constant.USER_EMAIL);

    day = DateUtils.today();

    getDayData(day);
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
        text: '$day',
        onPreviousPressed: () {
          day = DateUtils.formatDateByMs(
              DateTime.parse(day).millisecondsSinceEpoch - MILLISECONDS,
              formats: [yyyy, "-", mm, "-", dd]);

          setState(() {
            showView = false;
          });
          getDayData(day);
        },
        onNextPressed: () {
          day = DateUtils.formatDateByMs(
              DateTime.parse(day).millisecondsSinceEpoch + MILLISECONDS,
              formats: [yyyy, "-", mm, "-", dd]);

          setState(() {
            showView = false;
          });
          getDayData(day);
        },
        onTogglePressed: () {
          showDatePicker(
            context: context,
            firstDate: DateTime.parse("20200101"),
            // 初始选中日期
            initialDate: DateTime.parse(day),
            // 可选日期范围第一个日期
            lastDate: DateTime.now(),
            initialDatePickerMode: DatePickerMode.day, //初始化选择模式，有day和year两种
          ).then((dateTime) {
            setState(() {
              day = DateUtils.formatDate(dateTime,
                  formats: [yyyy, "-", mm, "-", dd]);

              showView = false;
            });
            getDayData(day);
          });
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
                      borderWidth: 0.0,
                      // X轴设置
                      primaryXAxis: CategoryAxis(),
                      // X轴设置
                      primaryYAxis: NumericAxis(minimum: -5, maximum: 5),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<Chart, String>>[
                          ScatterSeries<Chart, String>(
                              dataSource: chartData,
                              xValueMapper: (Chart sales, _) =>
                                  DateUtils.formatDateByStr(sales.diaryDate,
                                      formats: [HH, ":", nn]),
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

  void getDayData(String day) async {
    var _response = await APIs.getData(
        "http://www.yoksoft.com/webapi/smile/SmileApi.ashx?Type=MoodQueryPeriod&PeriodType=Day&UserName=$username&InputDate=$day");

    if (_response != null) {
      chartData.clear();

      List<Chart> _list = [];

      _list
        ..addAll((json.decode(_response) as List ?? [])
            .map((o) => Chart.fromMap(o)));

      chartData.addAll(_list.reversed);
    }

    if (!mounted) return;
    setState(() {
      showView = true;
    });
  }
}
