/*
* jin_ri_yun_shi created by zj 
* on 2020/5/25 10:58 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Translations.dart';

class JinRiYunShiPage extends StatefulWidget {
  JinRiYunShiPage({Key key}) : super(key: key);

  @override
  _JinRiYunShiState createState() => _JinRiYunShiState();
}

class _JinRiYunShiState extends State<JinRiYunShiPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("constellation")),
        ),
        body: Center(
          child: Column(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}