/*
* user_event_page created by zj 
* on 2020/6/17 2:52 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/RepoItems.dart';


class UserEventPage extends StatefulWidget {
  UserEventPage({Key key,@required this.devName}) : super(key: key);

  final String devName;
  @override
  _UserEventPageState createState() => _UserEventPageState();
}

class _UserEventPageState extends State<UserEventPage> {

  int page = 1;
  EasyRefreshController _controller;
  List<Pubevents> itemsData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    _getItemPro();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _getItemPro({bool isrefresh = true}) async{

    if(isrefresh){
      page = 1;
      itemsData.clear();
    }else{
      page++;
    }
    List<Pubevents> items = await HTTPManager().getAsync<List<Pubevents>>(url: RequestURL.getDevEvents(widget.devName),params: {})
    print("当前返回的信息==${items.length}");
    if (mounted) {
      setState(() {
        itemsData.addAll(items);
      });
    }
    if(!isrefresh){
      _controller.finishLoad(noMore: items.length < 30);
    }
    _controller.resetLoadState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: EasyRefresh.custom(
        controller: _controller,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context,index) {
              return Container();//GitPubItems(itemsData[index]);
            }, childCount: itemsData.length),
          ),
        ],
        onRefresh: () async{
          _getItemPro();
        },
        onLoad: () async{
          _getItemPro(isrefresh: false);
        },
      ),
    );
  }
}

