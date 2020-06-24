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
import 'package:fluttergithubpro/routes/BaseWidget/base_empty_page.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/my_personal_page.dart';
import 'package:fluttergithubpro/widgets/Custom_widget.dart';

class TrendDeveloperPage extends StatefulWidget {
  TrendDeveloperPage({Key key,this.language}) : super(key: key);

  final String language;

  @override
  _TrendDeveloperPageState createState() => _TrendDeveloperPageState();
}

class _TrendDeveloperPageState extends State<TrendDeveloperPage> with AutomaticKeepAliveClientMixin {

  EasyRefreshController _refreshController;
  ScrollController _scrollController;

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      EasyLoading.show(status: "玩命加载中……");
    });
    _getTrendDeveloperData();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _getTrendDeveloperData() async{
    _developList.clear();
    var data = await HTTPManager().getAsync<List<Trenddeveloperlist>>(url: RequestURL.getTrendDevelopers("daily", widget.language ?? ""));
    if (mounted) {
      setState(() {
        _developList.addAll(data);
      });
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
          SliverPadding(
            padding: const EdgeInsets.all(5),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: _developList.map((e) => _builderHeader(e)).toList(),
            ),
          ),
        ],
        onRefresh: () async{
          _getTrendDeveloperData();
        },
        emptyWidget: _developList.length > 0 ? null : BaseEmptyPage(),
      ),
    );
  }

  Widget _builderHeader( Trenddeveloperlist e){
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return PersonalRepoPage(userName: e.username);
        }));
      },
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomWidget.showHeaderImage(e.avatar,width: 80),
            Padding(padding: const EdgeInsets.only(top: 5),),
            Text(e.username,style: TextStyle(color: Color(0xff999999),fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}