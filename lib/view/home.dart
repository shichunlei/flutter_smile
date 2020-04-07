import 'package:flutter/material.dart';
import 'package:smile/view/gratitude/home.dart';
import 'package:smile/view/line/home.dart';
import 'package:smile/view/moments/home.dart';
import 'package:smile/view/setting.dart';
import '../config/constant.dart';
import '../generated/i18n.dart';
import '../global/icon_font.dart';
import 'mood.dart';

class HomePage extends StatefulWidget {
  final int index;

  HomePage({Key key, @required this.index})
      : assert(index != null),
        super(key: key);

  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex;

  PageController _controller;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index;

    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
            children: <Widget>[
              MoodPage(),
              LinePage(),
              GratitudePage(),
              MomentsPage(),
              SettingPage()
            ],
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            physics: NeverScrollableScrollPhysics()),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              _controller.animateToPage(index,
                  curve: Curves.linear, duration: Duration(milliseconds: 100));
              setState(() => _currentIndex = index);
            },
            selectedItemColor: Constant.kIconTabTextColor,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text(S.of(context).tabMood)),
              BottomNavigationBarItem(
                  icon: Icon(IconFont.line),
                  title: Text(S.of(context).tabLine)),
              BottomNavigationBarItem(
                  icon: Icon(IconFont.gratitude),
                  title: Text(S.of(context).tabGratitude)),
              BottomNavigationBarItem(
                  icon: Icon(IconFont.moment),
                  title: Text(S.of(context).tabMoment)),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text(S.of(context).tabSetting))
            ]));
  }
}
