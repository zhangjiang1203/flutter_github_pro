/*
* car_licence_page created by zj 
* on 2020/5/25 11:04 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';

class CarLicencePage extends StatefulWidget {
  CarLicencePage({Key key}) : super(key: key);

  @override
  _CarLicenceState createState() => _CarLicenceState();
}

class _CarLicenceState extends State<CarLicencePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("car_test")),
        ),
        body: Center(
          child: Column(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}