/*
* EventStreamSet created by zj 
* on 2020/6/23 11:49 AM
* copyright on zhangjiang
*/

import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

///搜索的event监听
class SearchEvent {
  String searchText;
  SearchEvent({this.searchText});

}