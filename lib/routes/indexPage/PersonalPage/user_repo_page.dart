/*
* user_repo_page created by zj 
* on 2020/6/16 6:05 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_empty_page.dart';
import 'package:fluttergithubpro/routes/indexPage/RepoItems.dart';

enum UserRepoPageType{
  personal, //个人仓库
  starred  //点赞仓库
}


class UserRepoPage extends StatefulWidget {
  UserRepoPage({Key key,this.devName, this.type = UserRepoPageType.personal}) : super(key: key);

  final String devName;

  final UserRepoPageType type;

  @override
  _UserRepoPageState createState() => _UserRepoPageState();
}

class _UserRepoPageState extends State<UserRepoPage> with AutomaticKeepAliveClientMixin {

  int page = 1;
  EasyRefreshController _refreshController;
  List<Repoitems> _itemsData = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        EasyLoading.show(status: "玩命加载中……");
    });
      _getItemPro();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  void _getItemPro({bool isrefresh = true}) async{

    if(isrefresh){
      page = 1;
      _itemsData.clear();
    }else{
      page++;
    }

    List<Repoitems> items;
    if(widget.type == UserRepoPageType.personal){
      items = await HTTPManager().getAsync<List<Repoitems>>(url: RequestURL.getRepos(widget.devName),params: {'page':page,'page_size':30});
      print(items.first);
    }else{
      items = await RequestAPI.instance.getStarredRepos(userName:widget.devName,param:{'page':page,'pageSize':30});
    }
    if (mounted) {
      setState(() {
        _itemsData.addAll(items);
      });
    }
    if(!isrefresh){
      _refreshController.finishLoad(noMore: items.length < 30);
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
          ),
    );
  }
}