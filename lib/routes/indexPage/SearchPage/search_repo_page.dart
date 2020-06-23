/*
* search_repo_page created by zj 
* on 2020/6/19 5:07 PM
* copyright on zhangjiang
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/Providers/EventStreamSet.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_empty_page.dart';
import 'package:fluttergithubpro/routes/indexPage/RepoItems.dart';


class SearchRepoPage extends StatefulWidget {
  SearchRepoPage({Key key,this.searchText}) : super(key: key);

  final String searchText;
  @override
  SearchRepoPageState createState() => SearchRepoPageState();
}

class SearchRepoPageState extends State<SearchRepoPage> with AutomaticKeepAliveClientMixin {

  int _page = 1;
  EasyRefreshController _refreshController;
  List<Repoitems> _itemsData = [];

  //类型为搜索时才会用到
  String _searchText;
  //监听数据的改变
  StreamSubscription<SearchEvent> _subscription;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
    _searchText = widget.searchText;
    _subscription = eventBus.on<SearchEvent>().listen((event) {
      reloadSearchResult(event.searchText);
//      setState(() {
//        _searchText = event.searchText;
//        print("开始刷新===repo");
//      });
    });
  }

  ///刷新列表
  void reloadSearchResult(String text){
    _searchText = text;
    _getItemPro();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _subscription.cancel();
    super.dispose();
  }

  void _getItemPro({bool isrefresh = true}) async{
    if(isrefresh){
      _page = 1;
      _itemsData.clear();
    }else{
      _page++;
    }
    zjPrint("开始搜索${_searchText}", StackTrace.current);
    Map<String,dynamic> searchP = {'page':_page,'pageSize':30,"order":"desc","sort":"best match","q":_searchText};
    Allrepolist data = await HTTPManager().getAsync<Allrepolist>(url: RequestURL.getGitHubPub,params: searchP);

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

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: EasyRefresh.custom(
          header: PhoenixHeader(),
          footer: BallPulseFooter(),
          controller: _refreshController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((context,index) {
                return GitPubItems(_itemsData[index]);
              }, childCount: _itemsData.length),
            ),
          ],
          onRefresh: () async{
            _getItemPro();
          },
          onLoad: () async{
            _getItemPro(isrefresh: false);
          },
          emptyWidget:_itemsData.length > 0 ? null : BaseEmptyPage(),
        )
    );
  }
}