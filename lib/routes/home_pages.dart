/*
* home_pages created by zj 
* on 2020/5/7 10:19 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import '../common/Translations.dart';
class AppHomePage extends StatefulWidget {
  AppHomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AppHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("home_title")),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('我是首页'),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}