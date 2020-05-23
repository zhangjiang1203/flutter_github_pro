/*
* LifePage created by zj 
* on 2020/5/22 6:34 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class LifePage extends StatefulWidget {
  LifePage({Key key}) : super(key: key);

  @override
  _LifePage createState() => _LifePage();
}

class _LifePage extends State<LifePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LifePage"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('我就是我不一样的烟火'),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}