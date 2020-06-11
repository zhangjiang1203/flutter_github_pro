/*
* home_pages created by zj 
* on 2020/5/7 10:19 AM
* copyright on zhangjiang
*/

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/routes/Login/login_page.dart';
import '../Login/my_drawer.dart';
import '../../models/index.dart';
import '../../common/index.dart';
import '../BaseWidget/base_web_page.dart';
import '../../widgets/my_infinite_listview.dart';

GlobalKey _button = GlobalKey();

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
  List<RepoItemsModelEntity> _itemsData;

  GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>(debugLabel: "home_page");

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
    print("home_page 开始");
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(Translations.of(context).text("home_title")),
        actions: <Widget>[
          IconButton(
            key: _button,
            icon: Icon(Icons.select_all),
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

  Future<List<RepoItemsModelEntity>> _getItemData({bool isrefresh:true}) async{
    if (isrefresh){
      _itemsData.clear();
    }
    var itemsData = await HTTPManager().getAsync<List<RepoItemsModelEntity>>(url: getGitHubPub, tag: "getitems",params: {
      'page':1,
      'q':'language:$_chooseLang',
      'sort':'stars'
    },options: Options(extra: {"refresh":isrefresh}));
    //包含的数据
    _itemsData.addAll(itemsData);
    return Future<List<RepoItemsModelEntity>>.value(_itemsData);
  }

  //创建视图
  Widget _buildBody() {
//    return Center(
//      child: Text('你好'),
//    );
    //登录先不做
    Profile profile = Global.profile;
    if (profile.token == null) {
      return LoginRoute();
    }
//    }else{
//     return SafeArea(
//       child: Center(
//         child: FutureBuilder<List<RepoItemsModelEntity>>(
//           initialData: _itemsData,
//           future: _getItemData(),
//           builder: (context,snapshot){
//              if(snapshot.connectionState == ConnectionState.done){
//                if(snapshot.hasError){
//                  return Text('网络请求错误请重试');
//                }
//                if(snapshot.data.length <= 0){
//                  return CircularProgressIndicator();
//                }
//                return ListView.builder(
//                    controller: _controller,
//                    itemBuilder: (context,index) {
//                      return GitPubItems(snapshot.data[index]);
//                    });
//              }else{
//                return CircularProgressIndicator();
//              }
//           },
//         ),
//       ),
//     );

      return SafeArea(
        child: MyInfiniteListView(
          emptyBuilder: (refresh,context){
            return Center(
              child: Column(

              ),
            );
          },
          key: refreshIndicatorKey,
          scrollController: _controller,
//          sliver: true,
          onRetrieveData: (int page,List<RepoItemsModelEntity> items,bool refresh) async{
            var itemsData = await HTTPManager().getAsync<List<RepoItemsModelEntity>>(url: getGitHubPub, tag: "getitems",params: {
              'page':page,
              'q':'language:$_chooseLang',
              'sort':'stars'
            },options: Options(extra: {"refresh":refresh}));
            var dataLength = itemsData.length;
            items.addAll(itemsData);
            //返回的数据是否是20，不是的话就没有下一页了
            return dataLength == 30;
          },
          initFailBuilder: (refresh,error,context){
            return Center(child:Text(error.toString()));
          },
          itemBuilder: (List<RepoItemsModelEntity> data,int index,BuildContext context){
            return GitPubItems(data[index]);
          },
        ),
      );
  }
}

class GitPubItems extends StatefulWidget {
  GitPubItems(@required this.repo):super(key:ValueKey(repo.id));

  final RepoItemsModelEntity repo;

  @override
  _GitPubState createState() => _GitPubState();
}

class _GitPubState extends State<GitPubItems>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var subtitle;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return BaseWebPage(url: widget.repo.htmlUrl,title: widget.repo.name,);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Material(
          color: Colors.white,
          shape: BorderDirectional(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 2,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  dense: true,
                  leading: ZJAvatar(widget.repo.owner.avatarUrl,width: 24,borderRadius: BorderRadius.circular(12)),
                  title: Text(widget.repo.owner.login,textScaleFactor: 0.9,),
                  subtitle: subtitle,
                  trailing: Text(widget.repo.language ?? ""),
                ),
                ///绘制标题和描述
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.repo.fork ? widget.repo.fullName : widget.repo.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: widget.repo.fork ? FontStyle.italic : FontStyle.normal
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 12),
                        child: widget.repo.description != null ?
                        Text(widget.repo.description,maxLines: 3,
                            style: TextStyle(height:1.15,color:Colors.blueGrey[700],fontSize: 13)) :
                        Text(Translations.of(context).text("no_description"),
                          style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey[700]),),
                      ),
                    ],
                  ),
                ),
                ///图标和展示数据
                _builderBottom(),
              ],
            ),
          ),
        ),
      ),
     );

  }

  Widget _builderBottom(){
    const padding = 10;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 15
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey,fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context){
            var children =  <Widget>[
              Icon(Icons.star),
              Text(" "+widget.repo.stargazersCount.toString().padRight(padding)),
              Icon(Icons.info_outline),
              Text(" " + widget.repo.openIssuesCount.toString().padRight(padding)),
              Icon(Icons.next_week),
              Text("" + widget.repo.fork.toString().padRight(padding)),
            ];
            if (widget.repo.fork){
              children.add(Text("Forked".padRight(padding)));
            }
            if(widget.repo.private == true){
              children.addAll(<Widget>[
                Icon(Icons.lock),
                Text(' private'.padRight(padding)),
              ]);
            }
            return Row(
              children: children,
            );
          }),
        ),
      ),
    );
  }
}
