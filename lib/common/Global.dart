/*
* Global created by zj 
* on 2020/5/7 11:38 AM
* copyright on zhangjiang
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/index.dart';
import '../HttpManager/index.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:typed_data';

const _themes = <String,MaterialColor>{
  "blue": Colors.blue,
  "cyan":Colors.cyan,
  "teal":Colors.teal,
  "green":Colors.green,
  "red":Colors.red
};

class Global {
  /// 定义的单例对象
  static SharedPreferences preferences;
  static Profile profile = Profile();
  ///网络缓存对象
  static NetCache netCache = NetCache();

  static Map<String,MaterialColor> get themes => _themes;

  //是否是release
  static bool get isRelease => bool.fromEnvironment('dart.vm.product');

  //头像专用placeholder
  static Image defaultHeaderImage({double width = 50}) => Image.asset("assets/images/default_avator.png",width: width,fit: BoxFit.fitWidth,);

  //无数据专用图
  static Image get emptyImage => Image.asset("assets/images/placeholder_image.png");

  //初始化全局信息
  static Future init() async {
     preferences = await SharedPreferences.getInstance();
     var _profile = preferences.getString("profile");
     if(_profile != null){
       try{
         profile = Profile.fromJson(jsonDecode(_profile));
         zjPrint("Global全局设置解析成功${jsonDecode(_profile)}",StackTrace.current);
       } catch(e){
         zjPrint("Global全局设置解析失败 $e  $Function()",StackTrace.current);
       }
     }
     //如果没有缓存策略。设置默认缓存策略
     profile.cache = profile.cache ?? CacheConfig()..enable = true
       ..maxAge = 3600
       ..maxCount = 1000;
     //初始化网络相关的配置，当前版本中baseUrl不统一，baseurl不设置
     HTTPManager().init(
//       baseUrl: 'https://api.github.com/',
       interceptors:[
         HeaderInterceptor(),
         NetCacheInterceptor(),
       ]
     );
  }

  static void configLoading(BuildContext context) {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Provider.of<ThemeProvider>(context).theme
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Color(0xff333333)
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true;
  }


  static saveProfile() {
    print("开始保存信息");
    preferences.setString("profile", jsonEncode(profile.toJson()));
  }
}

final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
