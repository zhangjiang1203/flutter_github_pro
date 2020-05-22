/*
* home_pages created by zj 
* on 2020/5/7 10:19 AM
* copyright on zhangjiang
*/

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import '../Login/my_drawer.dart';
import '../../models/index.dart';
import 'package:flukit/flukit.dart';
import '../../common/index.dart';


GlobalKey _button = GlobalKey();

class AppHomePage extends StatefulWidget {
  AppHomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AppHomePage> {

  PopupMenuButton _popupMenuButton(){
    return PopupMenuButton(
      itemBuilder: (context) => _getPopMenuButton(context),
      onCanceled: (){
        print("取消了");
      },
      onSelected: (value){
        if (value == "主题"){
          Navigator.pushNamed(context,"theme_change_route");
        }else if (value == "语言"){
          Navigator.pushNamed(context,"Change_local_route");
        }else if (value == "电量"){
          Navigator.pushNamed(context,"get_battery_level");
        }
      },
    );
  }

   List<PopupMenuEntry<String>> _getPopMenuButton(BuildContext context) {
    return ["主题","语言","电量"].map((e) => PopupMenuItem<String>(value: e,child: Text(e),)).toList();
//    return <PopupMenuEntry<String>>[
//      PopupMenuItem<String>(
//        value: '主题',
//        child: Text('主题'),
//      ),
//      PopupMenuItem<String>(
//        value: '语言',
//        child: Text('语言'),
//      ),
//      PopupMenuItem<String>(
//        value: '电量',
//        child: Text('电量'),
//      ),
//    ];
  }

  void _showPopMenu(BuildContext context) {
    //获取Position和items
    final RenderBox button = _button.currentContext.findRenderObject();
    final Offset offsetA = button.localToGlobal(Offset.zero);
//    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
//    final Offset offsetB = button.localToGlobal(button.size.bottomRight(Offset.zero),
//        ancestor: overlay);
//    RelativeRect position = RelativeRect.fromRect(
//        Rect.fromPoints(offsetA, offsetB,),
//        Offset.zero & overlay.size,
//    );
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

  void _getItems() async{
//    HTTPManager().get(url: "search/repositories", tag: "getitems",params: {
//      'page':1,
//      'page_size':20,
//      'q':'language:Swift',
//      'sort':'stars'
//    },options: Options(extra: {"refresh":false,'noCache':false}),successCallback: (res){
//      print(res);
//    },failureCallback: (e){
//      print(e.toString());
//    });
//    Allrepolist.fromJson(r.data).items
//    var response = await HTTPManager().getAsync<List<Repoitems>>(url: "search/repositories", tag: "getitems",params: {
//      'page':1,
//      'page_size':20,
//      'q':'language:Swift',
//      'sort':'stars'
//    },options: Options(extra: {"refresh":false,'noCache':false}));
//    zjPrint(response, StackTrace.current);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getItems();
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
              icon: Icon(Icons.select_all),
              onPressed: () => _showPopMenu(context),
            )
          ],
        ),
        body: _buildBody(),
    );
  }

  //创建视图
  Widget _buildBody() {
    Profile profile = Global.profile;
    if (profile.token != null){
      return Center(
        child: RaisedButton(
          child: Text("登录"),
          onPressed: () => Navigator.of(context).pushNamed("Login_route"),
        ),
      );
    }else{
      return InfiniteListView(
        onRetrieveData: (int page,List<Repoitems> items,bool refresh) async{
          zjPrint("当前page:$page", StackTrace.current);
          var itemsData = await HTTPManager().getAsync<List<Repoitems>>(url: "search/repositories", tag: "getitems",params: {
            'page':page,
            'q':'language:Swift',
            'sort':'stars'
          },options: Options(extra: {"refresh":refresh}));
          var dataLength = itemsData.length;
          items.addAll(itemsData);
          //返回的数据是否是20，不是的话就没有下一页了
          return dataLength == 30;
        },
        itemBuilder: (List<Repoitems> data,int index,BuildContext context){
          return GitPubItems(data[index]);
        },
      );
    }
  }
}

class GitPubItems extends StatefulWidget {
  GitPubItems(@required this.repo):super(key:ValueKey(repo.id));

  final Repoitems repo;

  @override
  _GitPubState createState() => _GitPubState();
}

class _GitPubState extends State<GitPubItems>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var subtitle;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 0,bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: ZJAvatar(widget.repo.owner.avatar_url,width: 24,borderRadius: BorderRadius.circular(12)),
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
                    Text(widget.repo.fork ? widget.repo.full_name : widget.repo.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontStyle: widget.repo.fork ? FontStyle.italic : FontStyle.normal
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 12),
                      child: widget.repo.description != null ? Text(widget.repo.description,maxLines: 3,style: TextStyle(height:1.15,color:Colors.blueGrey[700],fontSize: 13)) :
                      Text(Translations.of(context).text("no_description"),style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey[700]),),
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
              Text(" "+widget.repo.stargazers_count.toString().padRight(padding)),
              Icon(Icons.info_outline),
              Text(" " + widget.repo.open_issues_count.toString().padRight(padding)),
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

//DropdownButton(
//value: 1,
//underline: Container(),
//onChanged: (value){
//print("value change $value");
//},
//items: <DropdownMenuItem>[
//DropdownMenuItem(
//value: 1,
//child: Text("哈哈哈1"),
//onTap: (){
//
//},
//),
//DropdownMenuItem(
//value: 2,
//child: Text("哈哈哈2"),
//onTap: (){
//
//},
//),
//DropdownMenuItem(
//value: 3,
//child: Text("哈哈哈3"),
//onTap: (){
//
//},
//),
//DropdownMenuItem(
//value: 4,
//child: Text("哈哈哈4"),
//onTap: (){
//
//},
//),
//],
//),