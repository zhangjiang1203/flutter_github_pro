/*
* mine_page created by zj 
* on 2020/5/22 6:35 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class mine_page extends StatefulWidget {
  mine_page({Key key}) : super(key: key);

  @override
  _mine_page createState() => _mine_page();
}

class _mine_page extends State<mine_page> {

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