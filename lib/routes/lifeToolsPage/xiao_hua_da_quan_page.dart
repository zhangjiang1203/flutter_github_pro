/*
* xiao_hua_da_quan_page created by zj 
* on 2020/5/25 11:02 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class XiaoHuaDaQuanPage extends StatefulWidget {
  XiaoHuaDaQuanPage({Key key}) : super(key: key);

  @override
  _XiaoHuaDaQuanState createState() => _XiaoHuaDaQuanState();
}

class _XiaoHuaDaQuanState extends State<XiaoHuaDaQuanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("xiao_hua_da_quan_page"),
        ),
        body: Center(
          child: Column(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}