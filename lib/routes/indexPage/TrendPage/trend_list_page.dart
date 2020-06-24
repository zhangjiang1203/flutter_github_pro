/*
* trend_list_page created by zhangjiang 
* on 2020/6/19 10:46 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/Providers/EventStreamSet.dart';
import 'package:fluttergithubpro/routes/indexPage/TrendPage/trend_developer_page.dart';
import 'package:fluttergithubpro/routes/indexPage/TrendPage/trend_repo_page.dart';
import 'package:fluttergithubpro/widgets/pop_up_menu.dart';

class TrendListPage extends StatefulWidget {
  TrendListPage({Key key}) : super(key: key);

  @override
  _TrendListPageState createState() => _TrendListPageState();
}

class _TrendListPageState extends State<TrendListPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

  GlobalKey _globalKey = GlobalKey();
  GlobalKey<TrendDeveloperPageState> _trendKey = GlobalKey<TrendDeveloperPageState>();
  TabController _tabController ;
  PopUpMenu _popUpMenu;
  String _chooseLang;


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2,vsync: this);
    _tabController.addListener(() {
      if(_tabController.index == 1){
        print("当前的text===$_chooseLang");
        _trendKey.currentState.reloadEventResult(_chooseLang == 'All' ? '' : _chooseLang,isNotice: true);
      }
    });

    _popUpMenu = PopUpMenu(buttonKey:_globalKey,
        itemsList:["All","Swift","Objective-C","Python","Dart","JavaScript","Java","Ruby","Shell","C","C++"],
        chooseStr: 'All');
    _chooseLang = 'All';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              key: _globalKey,
              icon: Icon(Icons.category),
              onPressed: (){
                _popUpMenu.showPopMenu(context, _chooseLang, (value) {
                  _chooseLang = value == 'All' ? '' : value;
                  eventBus.fire(ChangeLanguageEvent(language:_chooseLang));
                });
              },
            )
          ],
          title:Container(
            width: 250,
            child: TabBar(
              controller: _tabController,
              labelStyle: TextStyle(fontSize: 16),
              indicatorColor: Colors.transparent,
              tabs: <Widget>[
                Tab(text: 'repos'),
                Tab(text: 'developers'),
              ],
            ),
          )
        ),
        body: SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              TrendRepoPage(language: _chooseLang == 'All' ? "" : _chooseLang,),
              TrendDeveloperPage(key:_trendKey,language: _chooseLang == 'All' ? "" : _chooseLang,)
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}