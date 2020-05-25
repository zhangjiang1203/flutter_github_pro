/*
* news_top_page created by zj 
* on 2020/5/25 10:57 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class NewsTopPage extends StatefulWidget {
  NewsTopPage({Key key}) : super(key: key);

  @override
  _NewsTopPageState createState() => _NewsTopPageState();
}

class _NewsTopPageState extends State<NewsTopPage> with SingleTickerProviderStateMixin {

  var tabBarData = {'top':'头条',
    'shehui':'社会',
    'guonei':'国内',
    'guoji':'国际',
    'yule':'娱乐',
    'tiyu':'体育',
    'junshi':'军事',
    'keji':'科技',
    'caijing':'财经',
    'shishang':'时尚'};
  TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: tabBarData.length,vsync: this);
    _tabController.addListener(() {
      _selectedIndex = _tabController.index;
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("新闻头条"),
          bottom: TabBar(
            isScrollable:true,
            controller: _tabController,
            tabs: tabBarData.keys.map((e) => Tab(text: tabBarData[e],)).toList(),
          ),
        ),
        body:SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: tabBarData.keys.map((e){
              return Container(
                child: Text(e,textScaleFactor: 3,),
              );
            }).toList(),
          ),
        )
    );
  }
}