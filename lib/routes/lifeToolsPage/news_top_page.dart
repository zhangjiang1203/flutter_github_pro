/*
* news_top_page created by zj 
* on 2020/5/25 10:57 AM
* copyright on zhangjiang
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_web_page.dart';

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
            //是否可以滚动
//            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: tabBarData.keys.map((e){
              return Center(
                child: NewsListPage(tabBarData[e]),// Text(Translations.of(context).text(e),textScaleFactor: 3,),
              );
            }).toList(),
          ),
        )
    );
  }
}


class NewsListPage extends StatefulWidget {

  NewsListPage(this.type);
  String type = 'top';

  @override
  _NewsListPageState createState() => _NewsListPageState();
}


class _NewsListPageState extends State<NewsListPage>{


  Future getNewsItems(){
    return HTTPManager().getAsync<List<Newstopmodel>>(url: RequestURL.getNewsData,params: {'type':widget.type});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            List<Newstopmodel> showData = snapshot.data;
            return ListView.builder(
                itemCount: showData.length,
                itemBuilder: (context,index){
                  return NewsTopItemWidget(showData[index]);
            });
          }
        }else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}


class NewsTopItemWidget extends StatelessWidget{
  NewsTopItemWidget(this.newsModel);

  final Newstopmodel newsModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    List<String> imageURls = [];
    if(newsModel.thumbnail_pic_s != null){
      imageURls.add(newsModel.thumbnail_pic_s);
    }
    if(newsModel.thumbnail_pic_s02 != null){
      imageURls.add(newsModel.thumbnail_pic_s02);
    }
    if(newsModel.thumbnail_pic_s03 != null){
      imageURls.add(newsModel.thumbnail_pic_s03);
    }
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return BaseWebPage(url: newsModel.url);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Material(
          color: Colors.white,
          shape: BorderDirectional(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 0.5,
              )
          ),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(newsModel.title,style: TextStyle(fontSize: 18,fontWeight:FontWeight.w500 ),),
                Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: imageURls.map((e){
                      return Padding(
                        padding: const EdgeInsets.only(right: 5,left: 5),
                        child: CachedNetworkImage(
                          imageUrl: e,
                          width: (width-50)/3,
                          fit: BoxFit.fitHeight,
                        ),
                      );
                    } ).toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(newsModel.date),
                    ],
                  )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

}