/*
* weather_prediction_page created by zj 
* on 2020/5/25 11:05 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Translations.dart';

class WeatherPredictionPage extends StatefulWidget {
  WeatherPredictionPage({Key key}) : super(key: key);

  @override
  _WeatherPredictionState createState() => _WeatherPredictionState();
}

class _WeatherPredictionState extends State<WeatherPredictionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("weather_pro")),
        ),
        body: Center(
          child: Column(),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}