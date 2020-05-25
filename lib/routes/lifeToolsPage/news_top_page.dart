/*
* news_top_page created by zj 
* on 2020/5/25 10:57 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class NewsTopPage extends StatefulWidget {
  NewsTopPage({Key key}) : super(key: key);

  @override
  _NewsTopPageState createState() => _NewsTopPageState();
}

class _NewsTopPageState extends State<NewsTopPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("新闻头条"),
        ),
        body: Center(
          child: Column(),
        )
    );
  }
}