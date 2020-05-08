/*
* ProfileChangeNotifier created by zj 
* on 2020/5/7 2:08 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'Global.dart';

class ProfileChangeNotifier extends ChangeNotifier {

  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}


///用户状态改变通知依赖项
class UserProvider extends ProfileChangeNotifier {
  User get _user => _profile.user;

  ///是否登录
  bool get isLogin => _user != null;

  ///用户信息发生变化，通知依赖的widget更新
  set user(User user){
    if(user?.login != _user.login){
      _profile.lastLogin = _user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

///当前主题发生变化
class ThemeProvider extends ProfileChangeNotifier {
  //获取当前主题
  ColorSwatch get theme => Global.themes.values.firstWhere((e) => e.value == _profile.theme,orElse: ()=>Colors.blue);

  ///主题改变后通知依赖项
  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

///当前语言发生变化
class LocaleProvider extends ProfileChangeNotifier {

  //获取当前的locale，如果为null，跟随当前系统
  Locale getLocale(){
    if(_profile.locale == null) return null;
    var t = _profile.locale.split('_');
    if (t.length <= 2) return null;
    return Locale(t[0],t[1]);
  }

  String get locale => _profile.locale;

  set locale(String loc) {
    if(loc != locale){
      _profile.locale = loc;
      notifyListeners();
    }
  }
}
