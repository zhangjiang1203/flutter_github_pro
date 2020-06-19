/*
* follow_user_page created by zj 
* on 2020/6/18 2:57 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/models/user.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/person_list_cell.dart';

enum FollowType{
  following, // username 关注的
  follower //关注username的
}

class FollowUserPage extends StatefulWidget {
  FollowUserPage({Key key,@required this.userName,this.type = FollowType.following}) : super(key: key);

  final String userName;

  final FollowType type;
  @override
  _FollowUserPageState createState() => _FollowUserPageState();
}

class _FollowUserPageState extends State<FollowUserPage> with AutomaticKeepAliveClientMixin{
  int page = 1;
  EasyRefreshController _controller;
  List<User> itemsData = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EasyRefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.show(status: "玩命加载中…………");
    });
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

    var url ;
    if(widget.type == FollowType.follower){
      url = RequestURL.getUserFollower(widget.userName);
    }else{
      url = RequestURL.getUserFollowing(widget.userName);
    }

    List<User> items = await HTTPManager().getAsync<List<User>>(url: url,params: {'page':page,'page_size':30});
    if (mounted) {
      setState(() {
        itemsData.addAll(items);
      });
    }
    if(!isrefresh){
      _controller.finishLoad(noMore: items.length < 30);
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
        controller: _controller,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(5),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: itemsData.map((e) => PersonListCell(user:e)).toList(),
            ),
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