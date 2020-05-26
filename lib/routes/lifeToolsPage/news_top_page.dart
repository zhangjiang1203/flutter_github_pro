/*
* news_top_page created by zj 
* on 2020/5/25 10:57 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/common/index.dart';

class NewsTopPage extends StatefulWidget {
  NewsTopPage({Key key}) : super(key: key);

  @override
  _NewsTopPageState createState() => _NewsTopPageState();
}

class _NewsTopPageState extends State<NewsTopPage> with SingleTickerProviderStateMixin {
//  "news_shehui": "society",
//  "news_guonei": "inland",
//  "news_guoji": "international",
//  "news_yule": "amusement",
//  "news_tiyu": "sports",
//  "news_junshi": "military science",
//  "news_keji": "science and technology",
//  "news_caijing": "finance and economics",
//  "news_shishang": "fashion",
//  "news_top": "headline"
  var tabBarData = {'news_top':'top',
    'news_shehui':'shehui',
    'news_guonei':'guonei',
    'news_guoji':'guoji',
    'news_yule':'yule',
    'news_tiyu':'tiyu',
    'news_junshi':'junshi',
    'news_keji':'keji',
    'news_caijing':'caijing',
    'news_shishang':'shishang'};
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
          title: Text(Translations.of(context).text("news_title")),
          bottom: TabBar(
            isScrollable:true,
            controller: _tabController,
            tabs: tabBarData.keys.map((e) => Tab(text:Translations.of(context).text(e))).toList(),
          ),
        ),
        body:SafeArea(
          child: TabBarView(
            controller: _tabController,
            children: tabBarData.keys.map((e){
              return Container(
                child: Text(Translations.of(context).text(e),textScaleFactor: 3,),
              );
            }).toList(),
          ),
        )
    );
  }
}


class NewsListPage extends StatelessWidget {

  NewsListPage(this.type);

  String type = 'top';

  Future getNewsItems(){
    return HTTPManager().getAsync(url: getNewsData,params: {'type':type}, tag: 'newsListPage');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: getNewsItems(),
      builder: (BuildContext context,AsyncSnapshot snapshot){
        if (snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(
              child: Text('暂无此分类信息',textScaleFactor: 2,),
            );
          }else{
            Map<String,dynamic> tempDict = snapshot.data;
            if(tempDict.containsKey("result")){
              Map<String,dynamic> resultMap = tempDict['result'];
              if(resultMap.containsKey('data')){
                List<Map<String,dynamic>> listData = resultMap['data'];
//                listData.map((e) => null)
              }
            }
            return ListView.builder(itemBuilder: (context,index){
              return ListTile(
                title:Text("nihao"),
              );
            });
          }
        }else {
          return CircularProgressIndicator();
        }
        return ListView.builder(
            itemBuilder: (context,index){
              return null;
            });
      },
    );
  }
}