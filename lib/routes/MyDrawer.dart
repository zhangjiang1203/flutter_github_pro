/*
* MyDrawer created by zj 
* on 2020/5/11 2:24 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawer createState() => _MyDrawer();
}

class _MyDrawer extends State<MyDrawer> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("MyDrawer"),
        ),
        body: Center(
          child: Column(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}