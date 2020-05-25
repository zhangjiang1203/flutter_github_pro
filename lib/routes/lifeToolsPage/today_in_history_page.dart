/*
* today_in_history_page created by zj 
* on 2020/5/25 11:03 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class TodayInHistoryPage extends StatefulWidget {
  TodayInHistoryPage({Key key}) : super(key: key);

  @override
  _TodayInHistoryState createState() => _TodayInHistoryState();
}

class _TodayInHistoryState extends State<TodayInHistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("today_in_history_page"),
        ),
        body: Center(
          child: Column(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}