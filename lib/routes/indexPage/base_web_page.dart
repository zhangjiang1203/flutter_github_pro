/*
* base_web_page created by zj 
* on 2020/5/22 6:39 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class base_web_page extends StatefulWidget {
  base_web_page({Key key}) : super(key: key);

  @override
  _base_web_page createState() => _base_web_page();
}

class _base_web_page extends State<base_web_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("base_web_page"),
        ),
        body: Center(
          child: Column(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}