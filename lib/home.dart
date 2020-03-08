import 'package:flutter/material.dart';
import 'package:smile/view/gratitude.dart';
import 'package:smile/view/line.dart';
import 'package:smile/view/moments.dart';
import 'package:smile/view/setting.dart';
import 'config/constant.dart';
import 'icon_font.dart';
import 'view/mood.dart';

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
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            _controller.animateToPage(index,
                curve: Curves.linear, duration: Duration(milliseconds: 100));
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Constant.kIconTabTextColor,
          unselectedItemColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text('Mood')),
            BottomNavigationBarItem(
                icon: Icon(IconFont.line), title: Text('Line')),
            BottomNavigationBarItem(
                icon: Icon(IconFont.gratitude), title: Text('Gratitude')),
            BottomNavigationBarItem(
                icon: Icon(IconFont.moment), title: Text('Moment')),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), title: Text('Setting'))
          ],
          backgroundColor: Constant.kIconTabBackgroundColor),
    );
  }
}
