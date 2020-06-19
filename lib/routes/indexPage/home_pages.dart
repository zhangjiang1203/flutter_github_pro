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
import 'package:flutter_easyrefresh/bezier_bounce_footer.dart';
import 'package:flutter_easyrefresh/bezier_circle_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:flutter_easyrefresh/taurus_footer.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/Providers/ProvidersCollection.dart';
import 'package:fluttergithubpro/routes/indexPage/RepoItems.dart';
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


  //手动触发列表刷新的key
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey _button = GlobalKey();
  final _pageKey = PageStorageKey('pub_load_page');

  PopupMenuButton _popupMenuButton(){
    return PopupMenuButton(
      itemBuilder: (context) => _getPopMenuButton(context),
      onCanceled: (){
        print("取消了");
      },
      onSelected: (value){
        if(!mounted) return;
        print("开始加载");
        _chooseLang = value;
        _controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
        //更新对应的listView
        _refreshController.callRefresh();
      },
    );
  }

   List<PopupMenuEntry<String>> _getPopMenuButton(BuildContext context) {
    return ["Swift","Objective-C","Python","Dart","JavaScript","Java","Ruby","Shell","C","C++"]
        .map((e) => PopupMenuItem<String>(value: e,child: Text(e),)).toList();
  }

  void _showPopMenu(BuildContext context) {
    //获取Position和items
    final RenderBox button = _button.currentContext.findRenderObject();
    final Offset offsetA = button.localToGlobal(Offset.zero);
    //获取到按钮点击的位置信息，去绘制showView的位置
    RelativeRect position = RelativeRect.fromLTRB(offsetA.dx, offsetA.dy+button.size.height,0,0);// position.right, position.bottom);
    var _pop = _popupMenuButton();
    showMenu<String>(
        context: context,
        position: position,
        items:_pop.itemBuilder(context)
    ).then((value){
      if(!mounted) return null;
      if(value == null) {
        if(_pop.onCanceled != null) _pop.onCanceled();
        return null;
      }
      if(_pop.onSelected != null) _pop.onSelected(value);
    });
  }

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.show(status: "玩命加载中……");
    });
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
            onPressed: () => _showPopMenu(context),
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
                _controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
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
    EasyLoading.dismiss();
  }

  //创建视图
  Widget _buildBody() {
    print("刷新===${_itemsData.length}");
    return EasyRefresh(
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
      emptyWidget: _itemsData.length > 0 ? null : Center(child: Text('暂无数据'),),
    );

      return SafeArea(
        child: MyInfiniteListView<Repoitems>(
          emptyBuilder: (refresh,context){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("",),
                  Text('暂无数据')
                ],
              ),
            );
          },
          refreshKey: refreshIndicatorKey,
          scrollController: _controller,
          onRetrieveData: (int page,List<Repoitems> items,bool refresh) async{
            var data = await HTTPManager().getAsync<Allrepolist>(url: RequestURL.getGitHubPub,params: {
              'page':page,
              'q':'language:$_chooseLang',
              'sort':'stars'
            },options: Options(extra: {"refresh":refresh}));

            //获取个人仓库信息
//            var data = await RequestAPI().getUserRepo(userName:Global.profile.user.login,param:{"page":page,'page_size': 30});

//            var dataLength = data.items.length;
            items.addAll(data.items);
            //返回的数据是否是20，不是的话就没有下一页了
            return data.items.length == 30;
          },
          initFailBuilder: (refresh,error,context){
            return Center(child:Text(error.toString()));
          },
          itemBuilder: (List<Repoitems> data,int index,BuildContext context){
            return GitPubItems(data[index]);
          },
        ),
      );
  }
}


