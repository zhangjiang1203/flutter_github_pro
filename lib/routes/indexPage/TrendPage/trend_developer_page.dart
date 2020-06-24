/*
* trend_developer_page created by zhangjiang 
* on 2020/6/19 10:56 PM
* copyright on zhangjiang
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/models/index.dart';

class TrendDeveloperPage extends StatefulWidget {
  TrendDeveloperPage({Key key,this.language}) : super(key: key);

  final String language;

  @override
  _TrendDeveloperPageState createState() => _TrendDeveloperPageState();
}

class _TrendDeveloperPageState extends State<TrendDeveloperPage> with AutomaticKeepAliveClientMixin {

  EasyRefreshController _refreshController;
  ScrollController _scrollController;
  int _page = 1;

  List<Trenddeveloperlist> _developList;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController();
    _scrollController = ScrollController();
    _developList = [];

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

  _getTrendDeveloperData({bool isRefresh = true}) async{
    if(isRefresh){
      _page = 1;
      _developList.clear();
    }else{
      _page++;
    }

    var data = await HTTPManager().getAsync<List<Trenddeveloperlist>>(url: RequestURL.getTrendDevelopers("daily", widget.language ?? ""));
    if (mounted) {
      setState(() {
        _developList.addAll(data);
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
        context: context,
        child: EasyRefresh.custom(slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 5,right: 5,left: 5),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: _developList.map((e) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xff000000).withOpacity(0.1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: CachedNetworkImage(
                        width: 80,
                        imageUrl: e.avatar,
                        placeholder: (context,url)=>Global.defaultHeaderImage(width: 80),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(e.username,maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                  ],
                ),
              )).toList(),
            )
          ),
        ])
    );

    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: EasyRefresh(
              firstRefresh: true,
              controller: _refreshController,
              header: PhoenixHeader(),
              footer: BallPulseFooter(),
              onRefresh: () async{
                await _getTrendDeveloperData();
              },
              child:Padding(

                padding: const EdgeInsets.only(left: 5,right: 5,top: 5),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: _developList.length,
                  itemBuilder: (context,index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Color(0xff000000).withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: CachedNetworkImage(
                              width: 80,
                              imageUrl: _developList[index].avatar,
                              placeholder: (context,url)=>Global.defaultHeaderImage(width: 80),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(_developList[index].username,maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 16),),
                          ),
                        ],
                      ),
                    );
                  })
          ),
        )
    );
  }
}