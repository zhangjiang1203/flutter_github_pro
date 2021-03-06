/*
* home_pages created by zj 
* on 2020/5/7 10:19 AM
* copyright on zhangjiang
*/

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/Providers/ProvidersCollection.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_empty_page.dart';
import 'package:fluttergithubpro/routes/indexPage/RepoItems.dart';
import 'package:fluttergithubpro/widgets/custom_skeleton.dart';
import 'package:fluttergithubpro/widgets/pop_up_menu.dart';
import 'package:provider/provider.dart';
import 'my_drawer.dart';
import '../../models/index.dart';
import '../../common/index.dart';
import '../../widgets/my_infinite_listview.dart';



class AppHomePage extends StatefulWidget {
  AppHomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AppHomePage> {

  ScrollController _controller ;
  EasyRefreshController _refreshController;
  //滚动控制
  NestScrollViewNotifier _nestScrollViewNotifier;
  bool _isShowBtn;
  //选中的语言
  String _chooseLang;
  //缓存数据
  List<Repoitems> _itemsData;
  int _page = 1;
  //弹出视图
  PopUpMenu _popUpMenu;

  //手动触发列表刷新的key
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey _button = GlobalKey();
  final _pageKey = PageStorageKey('pub_load_page');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chooseLang = 'Swift';
    _itemsData = [];
    _isShowBtn = false;
    _refreshController = EasyRefreshController();
    _nestScrollViewNotifier = NestScrollViewNotifier(maxOffset: 1000);
    _controller = new ScrollController();
    //初始化popMenu
    _popUpMenu = PopUpMenu(buttonKey: _button,
        itemsList:["Swift","Objective-C","Python","Dart","JavaScript","Java","Ruby","Shell","C","C++"],
        chooseStr: 'Swift');
    _getItemData();
    _controller.addListener(() {
      _nestScrollViewNotifier.setOffset = _controller.offset;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(Translations.of(context).text("home_title")),
        actions: <Widget>[
          IconButton(
            key: _button,
            icon: Icon(Icons.category),
            onPressed: () => _popUpMenu.showPopMenu(context,_chooseLang, (value) {
              _chooseLang = value;
              _controller.animateTo(0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.ease);
              //更新对应的listView
              _refreshController.callRefresh();
            })//_showPopMenu(context),
          )
        ],
      ),
      body: _buildBody(),
      floatingActionButton: ChangeNotifierProvider<NestScrollViewNotifier>(
        create: (context)=> _nestScrollViewNotifier,
        child: Consumer<NestScrollViewNotifier>(
          builder: (context,nestNoti,child) {
            return !nestNoti.isShowNavBar ? Container() : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: (){
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.ease);
              },
            );
          })
      ),
    );
  }

  void _getItemData({bool isrefresh:true}) async{
    if (isrefresh){
      _itemsData.clear();
      _page = 1;
    }else{
      _page++;
    }
    var data = await HTTPManager().getAsync<Allrepolist>(url: RequestURL.getGitHubPub,params: {
      'page':_page,
      'q':'language:$_chooseLang',
      'sort':'stars'
    },options: Options(extra: {"refresh":isrefresh}));
    //包含的数据
//    return Future<List<Repoitems>>.value(_itemsData);
    if (mounted) {
      setState(() {
        _itemsData.addAll(data.items);
      });
    }
    if(!isrefresh){
      _refreshController.finishLoad(noMore: data.items.length < 30);
    }
    _refreshController.resetLoadState();
  }

  //创建视图
  Widget _buildBody() {
    print("首页返回的数据==${_itemsData.length}");
    return _itemsData.length <= 0 ? CustomSkeleton.multiCardListSkeleton() : EasyRefresh(
      key: _pageKey,
      child:  ListView.builder(
        //ListView的Item
          itemCount: _itemsData.length,
          itemBuilder: (BuildContext context, int index) {
            return GitPubItems(_itemsData[index]);
          }),
      controller: _refreshController,
      scrollController: _controller,
      header: PhoenixHeader(),
      footer: BallPulseFooter(),
      onLoad: () async{
         _getItemData(isrefresh: false);
      },
      onRefresh: () async{
        _getItemData();
      },
      emptyWidget: _itemsData.length > 0 ? null : BaseEmptyPage(),
    );
  }
}


