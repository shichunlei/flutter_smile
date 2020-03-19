import 'package:flutter/material.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/global/icon_font.dart';

import 'day.dart';
import 'month.dart';
import 'week.dart';
import 'list.dart';

class LinePage extends StatefulWidget {
  LinePage({Key key}) : super(key: key);

  @override
  createState() => _LinePageState();
}

class _LinePageState extends State<LinePage>
    with AutomaticKeepAliveClientMixin {
  var isSelected = [true, false, false];

  bool showList = false;

  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(S.of(context).titleLine),
        actions: <Widget>[
          IconButton(
              icon: Icon(showList ? IconFont.line : Icons.list),
              onPressed: () {
                setState(() {
                  showList = !showList;
                });
              })
        ],
      ),
      body: showList
          ? MoodListPage()
          : Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    height: 40,
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(10),
                      children: [
                        Container(
                          child: Text(S.of(context).day),
                          width: 100.0,
                          alignment: Alignment.center,
                        ),
                        Container(
                          child: Text(S.of(context).week),
                          width: 100.0,
                          alignment: Alignment.center,
                        ),
                        Container(
                          child: Text(S.of(context).month),
                          width: 100.0,
                          alignment: Alignment.center,
                        ),
                      ],
                      onPressed: (int index) {
                        isSelected = [false, false, false];
                        isSelected[index] = true;

                        pageIndex = index;

                        setState(() {});
                      },
                      color: Color(0xFF0475FB),
                      selectedColor: Colors.white,
                      fillColor: Color(0xFF0475FB),
                      isSelected: isSelected,
                    ),
                  ),
                  Expanded(
                    child: IndexedStack(
                      children: <Widget>[DayView(), WeekView(), MonthView()],
                      index: pageIndex,
                    ),
                  )
                ],
              ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
