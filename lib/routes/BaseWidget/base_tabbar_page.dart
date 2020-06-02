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

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3,vsync: this);
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
      index: Provider.of<TabbarChooseNotifier>(context).selectIndex,
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
            currentIndex: Provider.of<TabbarChooseNotifier>(context).selectIndex,
            onTap: (index){
              Provider.of<TabbarChooseNotifier>(context).selectIndex = index;
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

    return  Scaffold(
        body: _initTabbarView(),
        bottomNavigationBar: _initTabBarItemsView(),
    );
  }
}


//添加点击provider的通知
class TabbarChooseNotifier extends ChangeNotifier {

//  factory TabbarChooseNotifier() => _getInstance();
//  static TabbarChooseNotifier get instance => _getInstance();
//  static TabbarChooseNotifier _instance;
//  static TabbarChooseNotifier _getInstance() {
//    if (_instance == null){
//      _instance = new TabbarChooseNotifier._internal();
//    }
//  }
//
//  TabbarChooseNotifier._internal() {
//    //初始化操作
//  }


  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int index){
    _selectIndex = index;
    notifyListeners();
  }
}