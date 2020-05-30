/*
* jin_ri_you_jia created by zj 
* on 2020/5/25 10:59 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestURLPath.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/today_oil_price_model_entity.dart';
import 'dart:math';
class JinRiYouJiaPage extends StatefulWidget {
  JinRiYouJiaPage({Key key}) : super(key: key);

  @override
  _JinRiYouJiaState createState() => _JinRiYouJiaState();
}

class _JinRiYouJiaState extends State<JinRiYouJiaPage> {

  Future _getOilPrice(){
    return HTTPManager().getAsync<List<TodayOilPriceModelEntity>>(url: getTodayOilData, tag: "getTodayOilPrice");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("today_oil")),
        ),
        body: FutureBuilder(
          future: _getOilPrice(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return Center(
                  child: Text('获取油价信息失败',textScaleFactor: 2,),
                );
              }else{
                return Text('获取成功');
              }
            }else {
              return CircularProgressIndicator();
            }
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



}