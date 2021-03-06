/*
* user_event_page created by zj 
* on 2020/6/17 2:52 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/phoenix_header.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_empty_page.dart';

import 'event_list_item.dart';


class UserEventPage extends StatefulWidget {
  UserEventPage({Key key,@required this.devName}) : super(key: key);

  final String devName;
  @override
  _UserEventPageState createState() => _UserEventPageState();
}

class _UserEventPageState extends State<UserEventPage> with AutomaticKeepAliveClientMixin {

  int page = 1;
  EasyRefreshController _controller;
  List<Pubevents> _itemsData = [];

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
      _itemsData.clear();
    }else{
      page++;
    }
    List<Pubevents> items = await HTTPManager().getAsync<List<Pubevents>>(url: RequestURL.getDevEvents(widget.devName),params: {'page':page,'page_size':30});
    if (mounted) {
      setState(() {
        _itemsData.addAll(items);
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
        header: PhoenixHeader(),
        footer: BallPulseFooter(),
        controller: _controller,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context,index) {
              return EventListItem(events: _itemsData[index]);
            }, childCount: _itemsData.length),
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

