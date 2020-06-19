/*
* trend_list_page created by zhangjiang 
* on 2020/6/19 10:46 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/routes/indexPage/TrendPage/trend_developer_page.dart';
import 'package:fluttergithubpro/routes/indexPage/TrendPage/trend_repo_page.dart';

class TrendListPage extends StatefulWidget {
  TrendListPage({Key key}) : super(key: key);

  @override
  _TrendListPageState createState() => _TrendListPageState();
}

class _TrendListPageState extends State<TrendListPage> with SingleTickerProviderStateMixin{

  TabController _tabController ;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.category),
              onPressed: (){},
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
              TrendRepoPage(),
              TrendDeveloperPage()
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}