/*
* TabbarChooseNotifier created by zj 
* on 2020/6/17 1:39 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

//tabbarView添加点击provider的通知
class TabbarChooseNotifier extends ChangeNotifier {
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int index){
    _selectIndex = index;
    notifyListeners();
  }
}


//个人界面滚动NestScrollview的通知
class NestScrollViewNotifier extends ChangeNotifier {

  NestScrollViewNotifier({@required this.maxOffset}):assert(maxOffset != null,'maxOffset不能为null'),super();

  final double maxOffset;

  double _selectIndex = 0;
  bool get isShowNavBar => _selectIndex > maxOffset;
  set setOffset(double offset){
    _selectIndex = offset;
    notifyListeners();
  }
}