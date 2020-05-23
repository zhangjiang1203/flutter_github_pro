/*
* mine_page created by zj 
* on 2020/5/22 6:35 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("mine_page"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('MinePage'),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}