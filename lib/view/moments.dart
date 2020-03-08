import 'package:flutter/material.dart';

class MomentsPage extends StatefulWidget {
  MomentsPage({Key key}) : super(key: key);

  @override
  createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(centerTitle: true, title: Text('Moments')),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(20),
        child: ListView.builder(
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(height: 1.5, color: Colors.grey),
                        ),
                        Text('23/2/2020'),
                        Expanded(
                          child: Container(height: 1.5, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 30,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 2,
                          color: Colors.grey,
                          width: 8,
                        ),
                        SizedBox(width: 5),
                        Expanded(child: Text('Conversations with old friends')),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 2,
                          color: Colors.grey,
                          width: 8,
                        ),
                        SizedBox(width: 5),
                        Expanded(child: Text('Try new drinks')),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 2,
                          color: Colors.grey,
                          width: 8,
                        ),
                        SizedBox(width: 5),
                        Expanded(child: Text('Party night')),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 10,
        ),
      ),
    );
  }
}
