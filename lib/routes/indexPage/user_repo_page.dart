/*
* user_repo_page created by zj 
* on 2020/6/16 6:05 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/RepoItems.dart';

enum UserRepoPageType{
  personal, //个人仓库
  starred,  //点赞仓库
}


class UserRepoPage extends StatefulWidget {
  UserRepoPage({Key key,@required this.devName,this.type = UserRepoPageType.personal}) : super(key: key);

  final String devName;

  final UserRepoPageType type;

  @override
  _UserRepoPageState createState() => _UserRepoPageState();
}

class _UserRepoPageState extends State<UserRepoPage> {

  int page = 1;
  EasyRefreshController _controller;
  List<Repoitems> itemsData = [];

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.show(status: "玩命加载中……");
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

    List<Repoitems> items;
    if(widget.type == UserRepoPageType.personal){
      items = await HTTPManager().getAsync<List<Repoitems>>(url: RequestURL.getRepos(widget.devName),params: {'page':page,'pageSize':30});
      print(items.first);
    }else{
      items = await RequestAPI.instance.getStarredRepos(userName:widget.devName,param:{'page':page,'pageSize':30});
    }
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
    EasyLoading.dismiss();
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
                return GitPubItems(itemsData[index]);
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