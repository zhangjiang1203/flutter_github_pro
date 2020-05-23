/*
* common_provider created by zj 
* on 2020/5/23 2:17 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class MainPageProvide extends ChangeNotifier {

  //设置工厂模式
  factory MainPageProvide() => _getInstance();
  static MainPageProvide get instance => _getInstance();
  static MainPageProvide _instance;
  static MainPageProvide _getInstance(){
    if (_instance == null){
      _instance = new MainPageProvide._internal();
    }
    return _instance;
  }

  MainPageProvide._internal(){
    //初始化设置
  }

  ///首页tabbarindex变化时通知
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int currentIndex){
    _currentIndex = currentIndex;
    notifyListeners();
  }

}

