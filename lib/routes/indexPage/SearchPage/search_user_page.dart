/*
* search_user_page created by zj 
* on 2020/6/19 5:29 PM
* copyright on zhangjiang
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/Providers/EventStreamSet.dart';
import 'package:fluttergithubpro/models/alluserlist.dart';
import 'package:fluttergithubpro/models/user.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_empty_page.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/person_list_cell.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';


class SearchUserPage extends StatefulWidget {
  SearchUserPage({Key key,this.searchText}) : super(key: key);

  final String searchText;
  @override
  SearchUserPageState createState() => SearchUserPageState();
}

class SearchUserPageState extends State<SearchUserPage> with AutomaticKeepAliveClientMixin{
  int _page = 1;
  EasyRefreshController _controller;
  List<User> _itemsData = [];
  //类型为搜索时才会用到
  String searchText;
  //监控搜索文字变化
  StreamSubscription<SearchEvent> _subscription;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    searchText = widget.searchText;
    _subscription = eventBus.on<SearchEvent>().listen((event) {
      reloadSearchResult(event.searchText);
    });
  }

  ///刷新列表
  void reloadSearchResult(String text){
    searchText = text;
    _getItemPro();
  }

  @override
  void dispose() {
    _controller.dispose();
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
    Map<String,dynamic> searchP = {'page':_page,'pageSize':30,'order':'desc','sort':'best match','q':searchText};
    Alluserlist data = await HTTPManager().getAsync<Alluserlist>(url: RequestURL.getGitHubUser,params: searchP);

    if (mounted) {
      setState(() {
        _itemsData.addAll(data.items);
      });
    }
    if(!isrefresh){
      _controller.finishLoad(noMore: data.items.length < 30);
    }
    _controller.resetLoadState();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: EasyRefresh.custom(
        header: PhoenixHeader(),
        footer: BallPulseFooter(),
        controller: _controller,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(5),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: _itemsData.map((e) => PersonListCell(user:e)).toList(),
            ),
          ),
        ],
        onRefresh: () async{
          _getItemPro();
        },
        onLoad: () async{
          _getItemPro(isrefresh: false);
        },
        emptyWidget: _itemsData.length > 0 ? null : BaseEmptyPage(),
      ),
    );
  }
}