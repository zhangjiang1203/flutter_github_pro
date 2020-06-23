/*
* search_inherited_model created by zj 
* on 2020/6/23 11:21 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class SearchInheritedModel extends InheritedWidget {

  SearchInheritedModel({Key key,this.searchText,@required Widget child}):super(key:key,child:child);

  final String searchText;

  static SearchInheritedModel of(BuildContext context){
    return  context.dependOnInheritedWidgetOfExactType<SearchInheritedModel>();
  }

  @override
  bool updateShouldNotify(SearchInheritedModel oldWidget) {
    // TODO: implement updateShouldNotify
    return searchText != oldWidget.searchText;
  }
}