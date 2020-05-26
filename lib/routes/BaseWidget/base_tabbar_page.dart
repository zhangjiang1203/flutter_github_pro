/*
* base_tabbar_page created by zj 
* on 2020/5/23 11:28 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/routes/BaseWidget/common_provider.dart';
import 'package:fluttergithubpro/routes/MinePage/mine_page.dart';
import 'package:fluttergithubpro/routes/indexPage/home_pages.dart';
import 'package:fluttergithubpro/routes/lifeToolsPage/life_page.dart';
import 'package:provider/provider.dart';

class BaseTabbarPage extends StatefulWidget {
  BaseTabbarPage({Key key}) : super(key: key);

  @override
  _BaseTabbarPageState createState() => _BaseTabbarPageState();
}

class _BaseTabbarPageState extends State<BaseTabbarPage> with TickerProviderStateMixin<BaseTabbarPage> {

  //设置对应的视图
  AppHomePage _homePage = AppHomePage();
  LifePage _lifePage = LifePage();
  MinePage _minePage = MinePage();

//  MainPageProvide _provide;

  TabController _tabController;

  int indexPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3,vsync: this);
//    _provide = MainPageProvide.instance;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  ///初始化所有的tabbar
  Widget _initTabbarView() {
    return IndexedStack(
      index: indexPage,
      children: <Widget>[
        _homePage,
        _lifePage,
        _minePage],
    );
  }

  Widget _initTabBarItemsView() {
    return Theme(
      data: new ThemeData(
          canvasColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(caption:TextStyle(color: Colors.grey))
      ),
      child: BottomNavigationBar(
            fixedColor: Theme.of(context).primaryColor,
            currentIndex: indexPage,
            onTap: (index){
              setState(() {
                indexPage = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.first_page),title: Text(Translations.of(context).text("index_page"))),
              BottomNavigationBarItem(icon: Icon(Icons.room_service),title: Text(Translations.of(context).text("life_page"))),
              BottomNavigationBarItem(icon: Icon(Icons.settings),title: Text(Translations.of(context).text("mine_page"))),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _initTabbarView(),
        bottomNavigationBar: _initTabBarItemsView(),
      );
  }
}