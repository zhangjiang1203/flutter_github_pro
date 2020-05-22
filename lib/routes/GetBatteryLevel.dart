/*
* GetBatteryLevel created by zj 
* on 2020/5/22 11:44 AM
* copyright on zhangjiang
*/

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetBatteryLevel extends StatefulWidget {
  GetBatteryLevel({Key key}) : super(key: key);

  @override
  _GetBatteryLevel createState() => _GetBatteryLevel();
}

class _GetBatteryLevel extends State<GetBatteryLevel> {

  static const platform = const MethodChannel('com.zhangj.fluttergithubpro.flutter.io/battery');

  String _batteryLevel = 'unknow battery level';

  Future<Void> _getBatteryLevel() async{
    String batteryLevel ;
    try{
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = "Battery level at $result %";
    }on PlatformException catch(e){
      batteryLevel = "Failed to get battery level:${e.message}";
    }
    setState(() {
      _batteryLevel = batteryLevel;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("GetBatteryLevel"),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('当前电量$_batteryLevel'),
              RaisedButton(
                onPressed: _getBatteryLevel,
                child: Text('获取系统电量'),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}