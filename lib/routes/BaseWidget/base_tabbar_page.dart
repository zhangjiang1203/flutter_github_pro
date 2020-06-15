/*
* base_tabbar_page created by zj 
* on 2020/5/23 11:28 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/routes/MinePage/mine_page.dart';
import 'package:fluttergithubpro/routes/indexPage/home_pages.dart';
import 'package:fluttergithubpro/routes/lifeToolsPage/life_page.dart';
import 'package:provider/provider.dart';
import '../../common/ScreenUtil.dart';
class BaseTabbarPage extends StatefulWidget {
  BaseTabbarPage({Key key}) : super(key: key);

  @override
  _BaseTabbarPageState createState() => _BaseTabbarPageState();
}

class _BaseTabbarPageState extends State<BaseTabbarPage> {

  //设置对应的视图
  AppHomePage _homePage = AppHomePage();
  LifePage _lifePage = LifePage();
  MinePage _minePage = MinePage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  ///初始化所有的tabbar
  Widget _initTabbarView(TabbarChooseNotifier tabbar) {
    return IndexedStack(
      index: tabbar.selectIndex,
      children: <Widget>[
        _homePage,
        _lifePage,
        _minePage],
    );
  }

  Widget _initTabBarItemsView(TabbarChooseNotifier tabbar) {
    return Theme(
      data: new ThemeData(
          canvasColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(caption:TextStyle(color: Colors.grey))
      ),
      child: BottomNavigationBar(
            fixedColor: Theme.of(context).primaryColor,
            currentIndex: tabbar.selectIndex,
            onTap: (index) {
              tabbar.selectIndex = index;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.first_page),
                  title: Text(Translations.of(context).text("index_page"))),
              BottomNavigationBarItem(icon: Icon(Icons.room_service),
                  title: Text(Translations.of(context).text("life_page"))),
              BottomNavigationBarItem(icon: Icon(Icons.settings),
                  title: Text(Translations.of(context).text("mine_page"))),
            ],
          ),
    );

  }

  @override
  Widget build(BuildContext context) {
    //UI相关设置
    ScreenUtil.init(context,width: 750,height: 1334,allowFontScaling: true);
      return ChangeNotifierProvider<TabbarChooseNotifier>(
        create: (context) => TabbarChooseNotifier() ,
        child: Consumer<TabbarChooseNotifier>(
          builder: (context,tabbar,child){
            return Scaffold(
              body: _initTabbarView(tabbar),
              bottomNavigationBar: _initTabBarItemsView(tabbar),
            );
          },
        )
      );
  }
}


//添加点击provider的通知
class TabbarChooseNotifier extends ChangeNotifier {
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int index){
    _selectIndex = index;
    notifyListeners();
  }
}