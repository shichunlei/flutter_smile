import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile/generated/i18n.dart';
import 'package:smile/provider/gratitude_provider.dart';
import 'package:smile/widgets/loading.dart';

import '../../generated/i18n.dart';

class GratitudePage extends StatefulWidget {
  GratitudePage({Key key}) : super(key: key);

  @override
  createState() => _GratitudePageState();
}

class _GratitudePageState extends State<GratitudePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    Future.microtask(() =>
        Provider.of<GratitudeProvider>(context, listen: false)
            .getGratitudeData());
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
            centerTitle: true, title: Text(S.of(context).titleGratitude)),
        body: Container(
          child: Column(children: [
            Container(
                margin: EdgeInsets.only(top: 20),
                height: 30,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: LinearProgressIndicator(
                        value: Provider.of<GratitudeProvider>(context)
                                .gratitudeCount /
                            3.0,
                        backgroundColor: Colors.white,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFF0475FB))))),
            Expanded(
                child: Container(
                    child: Provider.of<GratitudeProvider>(context).pageView ??
                        LoadingView()))
          ]),
        ));
  }
}
