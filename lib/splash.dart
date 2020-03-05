import 'package:flutter/material.dart';

import 'config/constant.dart';
import 'home.dart';
import 'utils/route_util.dart';
import 'utils/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
    return Scaffold(
      backgroundColor: Constant.kPrimaryColor,
      body: Container(
        padding: EdgeInsets.only(top: Utils.topSafeHeight),
        child: Column(
          children: <Widget>[
            Align(
              child: IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    pushNewPage(
                        context, HomePage(index: Constant.INDEX_SETTING));
                  }),
              alignment: Alignment.topRight,
            ),
            Image.asset("assets/smile_logo.png",
                width: Utils.width * 0.4, height: Utils.width * 0.4),
            SizedBox(height: 18),
            FloatingActionButton(
              child: Text("12", style: TextStyle(fontSize: 20.0)),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              foregroundColor: Colors.pink,
              backgroundColor: Colors.white,
              onPressed: () {
                print("F");
              },
            ),
            SizedBox(height: 24),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Row(children: <Widget>[
                GestureDetector(
                  child: Image.asset(
                    "assets/mooddiary_1.png",
                    width: Utils.width * 0.4,
                    height: Utils.width * 0.4,
                  ),
                  onTap: () {
                    pushNewPage(context, HomePage(index: Constant.INDEX_MOOD));
                  },
                ),
                GestureDetector(
                  child: Image.asset(
                    "assets/emotionline_1.png",
                    width: Utils.width * 0.4,
                    height: Utils.width * 0.4,
                  ),
                  onTap: () {
                    pushNewPage(context, HomePage(index: Constant.INDEX_LINE));
                  },
                ),
              ], mainAxisSize: MainAxisSize.min),
            ),
            Row(children: <Widget>[
              GestureDetector(
                child: Image.asset(
                  "assets/gratitudejournal_1.png",
                  width: Utils.width * 0.4,
                  height: Utils.width * 0.4,
                ),
                onTap: () {
                  pushNewPage(
                      context, HomePage(index: Constant.INDEX_GRATITUDE));
                },
              ),
              GestureDetector(
                child: Image.asset(
                  "assets/moments_1.png",
                  width: Utils.width * 0.4,
                  height: Utils.width * 0.4,
                ),
                onTap: () {
                  pushNewPage(context, HomePage(index: Constant.INDEX_MOMENTS));
                },
              ),
            ], mainAxisSize: MainAxisSize.min),
          ],
        ),
      ),
    );
  }
}
