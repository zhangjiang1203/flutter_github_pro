/*
* trend_repo_page created by zhangjiang 
* on 2020/6/19 10:56 PM
* copyright on zhangjiang
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_web_page.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/my_personal_page.dart';
import 'package:fluttergithubpro/widgets/Custom_widget.dart';

class TrendRepoPage extends StatefulWidget {
  TrendRepoPage({Key key,this.language}) : super(key: key);

  final String language;

  @override
  _TrendRepoPageState createState() => _TrendRepoPageState();
}

class _TrendRepoPageState extends State<TrendRepoPage> with AutomaticKeepAliveClientMixin{
  
  EasyRefreshController _refreshController;
  ScrollController _scrollController;
  List<Trendrepolist> _itemsData;
  int _page = 1;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
    _scrollController = ScrollController();
    _itemsData = [];

//    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//      EasyLoading.show(status: "玩命加载中……");
//    });

  }
  
  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  _getTrendRepoData({bool isRefresh = true}) async{
    if(isRefresh){
      _page = 1;
      _itemsData.clear();
    }else{
      _page++;
    }
    
    var data = await HTTPManager().getAsync<List<Trendrepolist>>(
        url: RequestURL.getTrendingRepos("daily", widget.language ?? ""));
    if (mounted) {
      setState(() {
        _itemsData.addAll(data);
      });
    }
    if(!isRefresh){
      _refreshController.finishLoad(noMore: data.length < 30);
    }
    _refreshController.resetLoadState();
//    EasyLoading.dismiss();
  }
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery.removePadding(
        removeTop: true, 
        context: context, 
        child: EasyRefresh(
          firstRefresh: true,
          controller: _refreshController,
          header: PhoenixHeader(),
          footer: BallPulseFooter(),
          onRefresh: () async{
            await _getTrendRepoData();
          },
          child: ListView.builder(
              itemCount: _itemsData.length,
              controller: _scrollController,
              itemBuilder: (context,index){
                return TrendPubCell(_itemsData[index]);//Container(child: Text(_itemsData[index].name));//GitPubItems(_itemsData[index]);
              }),
//          emptyWidget: Center(child: Text('暂无数据'),),
        )
    );
  }
}


//TODO:添加对应的trendrepoitem


class TrendPubCell extends StatefulWidget {
  TrendPubCell(@required this.repo):super(key:ValueKey(repo.name));

  final Trendrepolist repo;

  @override
  _TrendPubCellState createState() => _TrendPubCellState();
}

class _TrendPubCellState extends State<TrendPubCell>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var subtitle;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return BaseWebPage(url: widget.repo.url,title: widget.repo.name,);
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
                  leading: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return PersonalRepoPage(userName: widget.repo.author,);
                      }));
                    },
                    child:  CustomWidget.showHeaderImage(widget.repo.avatar,width: 40),//ZJAvatar(widget.repo.avatar,width: 40,borderRadius: BorderRadius.circular(20)),
                  ),
                  title: Text(widget.repo.author,textScaleFactor: 0.9,),
                  subtitle: subtitle,
                  trailing: Text(widget.repo.language ?? "",style: TextStyle(color: widget.repo.language == null ? Colors.white : Color(int.parse("0xff"+widget.repo.languageColor.substring(1)))),),
                ),
                ///绘制标题和描述
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.repo.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle:  FontStyle.italic
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
                //绘制其他贡献者
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
                  child: SingleChildScrollView(
                    child: Row(
                      children: widget.repo.builtBy.map((e) => GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return PersonalRepoPage(userName: widget.repo.author,);
                          }));
                        },
                        child:Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: CustomWidget.showHeaderImage(e.avatar,width: 30)
                        )
                      )).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    color: Colors.grey,
                    height: 0.1,
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
              Text(" "+widget.repo.stars.toString().padRight(padding)),
              Icon(Icons.next_week),
              Text("" + widget.repo.forks.toString().padRight(padding)),
              Icon(Icons.today),
              Text(" " + widget.repo.currentPeriodStars.toString().padRight(padding)),
            ];
            return Row(
              children: children,
            );
          }),
        ),
      ),
    );
  }
}