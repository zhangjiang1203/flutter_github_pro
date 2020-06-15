/*
* home_pages created by zj 
* on 2020/5/7 10:19 AM
* copyright on zhangjiang
*/

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/routes/indexPage/RepoItems.dart';
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
  bool _isShowBtn;
  //选中的语言
  String _chooseLang;
  //缓存数据
  List<Repoitems> _itemsData;

  //手动触发列表刷新的key
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey _button = GlobalKey();

  PopupMenuButton _popupMenuButton(){
    return PopupMenuButton(
      itemBuilder: (context) => _getPopMenuButton(context),
      onCanceled: (){
        print("取消了");
      },
      onSelected: (value){
        if(!mounted) return;
        _chooseLang = value;
        _controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
        //更新对应的listView
        refreshIndicatorKey.currentState.show();
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
    print("开始初始化");
    _chooseLang = 'Swift';
    _itemsData = [];
    _isShowBtn = false;
    _controller = new ScrollController();
    _controller.addListener(() {
      print("滚动距离===${_controller.offset}");
      if(_controller.offset < 1000 && _isShowBtn){
        setState(() {
          _isShowBtn = false;
        });
      }else if(_controller.offset >= 1000 && !_isShowBtn){
        setState(() {
          _isShowBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print("开始释放");
    _controller.dispose();
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
            icon: Icon(Icons.person),
            onPressed: () => _showPopMenu(context),
          )
        ],
      ),
      body: _buildBody(),
      floatingActionButton: !_isShowBtn ? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: (){
          _controller.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
        },
      ),
    );
  }

  Future<List<Repoitems>> _getItemData({bool isrefresh:true}) async{
    if (isrefresh){
      _itemsData.clear();
    }
    var data = await HTTPManager().getAsync<Allrepolist>(url: RequestURL.getGitHubPub,params: {
      'page':1,
      'q':'language:$_chooseLang',
      'sort':'stars'
    },options: Options(extra: {"refresh":isrefresh}));
    //包含的数据
    _itemsData.addAll(data.items);
    return Future<List<Repoitems>>.value(_itemsData);
  }

  //创建视图
  Widget _buildBody() {
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
//            var data = await HTTPManager().getAsync<Allrepolist>(url: RequestURL.getGitHubPub,params: {
//              'page':page,
//              'q':'language:$_chooseLang',
//              'sort':'stars'
//            },options: Options(extra: {"refresh":refresh}));

            //获取个人仓库信息
            var data = await RequestAPI().getUserRepo(Global.profile.user.login,{"page":page,'page_size': 30});

//            var dataLength = data.items.length;
            items.addAll(data);
            //返回的数据是否是20，不是的话就没有下一页了
            return data.length == 30;
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


