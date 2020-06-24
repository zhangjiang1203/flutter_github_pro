/*
* my_repo_page created by zj 
* on 2020/6/16 4:04 PM
* copyright on zhangjiang
*/

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/follow_user_page.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/my_sliver_persistent_delegate.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/user_event_page.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/user_repo_page.dart';
import 'package:fluttergithubpro/widgets/Custom_widget.dart';
import 'package:provider/provider.dart';
import '../../../Providers/ProvidersCollection.dart';




class PersonalRepoPage extends StatefulWidget {
  PersonalRepoPage({Key key,@required this.userName}) : super(key: key);

  final String userName;

  @override
  _PersonalRepoPageState createState() => _PersonalRepoPageState();
}

class _PersonalRepoPageState extends State<PersonalRepoPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  List<String> mTabs = <String>['personal_repos', "personal_stars", "personal_dynamic", "personal_focus", "personal_fans"];

  var _personalKey = PageStorageKey('_personalKey');
  var _starredKey = PageStorageKey('_starredKey');
  var _eventKey = PageStorageKey('_eventKey');
  var _followingKey = PageStorageKey('_followingKey');
  var _followerKey = PageStorageKey('personalPage');

  TabController _controller;
  ScrollController _scrollController;
  NestScrollViewNotifier _nestNotifier;
  GlobalKey key = GlobalKey();
  bool isShow = false;
  //防止重绘
  var _futureBuilder;

  //配合AutomaticKeepAliveClientMixin,延长生命周期
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nestNotifier = NestScrollViewNotifier(maxOffset: 200);
    _controller = TabController(length: 5,vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      _nestNotifier.setOffset = _scrollController.offset;
    });
    _futureBuilder = _getPersonalData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder(
        future: _futureBuilder,
        builder: (context,snapdata){
          if(snapdata.connectionState == ConnectionState.done){
            if(snapdata.hasError){
              return Center(child: Global.emptyImage,);
            }
            return _buildPersonalPage(snapdata.data);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton:!isShow ? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: (){
          _scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
        },
      ),
    );
  }

  Future<User> _getPersonalData() async{
    //判断是否关注过
    if(Global.profile.user.login != widget.userName){
      RequestAPI.instance.checkIsFollowSomeone(widget.userName,(value){
        print("是否关注12121===$value,_nestNotifier.isFollow==${_nestNotifier.isFollow}");
        _nestNotifier.setIsFollow = (value == 204);
      });
    }
    return RequestAPI.instance.getUserInfo(widget.userName);
  }

  Future _followOrUnfollowUser() async{
    int follow = await RequestAPI.instance.followOrUnfollow(username: widget.userName,isFollow: _nestNotifier.isFollow);
    //进行取反
    if(follow == 204){
      _nestNotifier.setIsFollow = !_nestNotifier.isFollow;
      print("是否关注===$follow,_nestNotifier.isFollow==${_nestNotifier.isFollow}");
    }else{
      EasyLoading.showError('请求失败，请稍后重试');
    }
  }

  _buildPersonalPage(User user){
    return  NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          ChangeNotifierProvider<NestScrollViewNotifier>(
            create: (_)=>_nestNotifier,
            child: Consumer<NestScrollViewNotifier>(
              builder: (context,nestNoti,child){
                return SliverAppBar(
                  elevation: 0,
                  pinned: true,
                  expandedHeight: 220,
                  title: !nestNoti.isShowNavBar ? Container() : TabBar(
                      isScrollable: true,
                      indicatorPadding: const EdgeInsets.all(0),
                      indicatorSize: TabBarIndicatorSize.tab,
                      labelColor: Colors.white,
                      labelStyle: TextStyle(fontSize: 14.0),
                      unselectedLabelColor: Colors.white60,
                      indicatorColor: Colors.greenAccent,
                      controller: _controller,
                      tabs: mTabs.map((String label) => Tab(text:Translations.of(context).text(label))).toList(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: _buildPersonalHeaderInfo(user,nestNoti),
                  ),
                );
              }),
          ),

          //tab栏
          SliverPersistentHeader(
            pinned: false,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 50,
              maxHeight: 50,
              child: Consumer<ThemeProvider>(
                builder: (context,themePro,child){
                  return Container(
                      decoration: BoxDecoration(
                        color: themePro.theme,
                      ),
                      child: TabBar(
                        labelColor: Colors.white,
                        labelStyle: TextStyle(fontSize: 16.0),
                        unselectedLabelColor: Colors.white60,
                        indicatorColor: Colors.greenAccent,
                        controller: _controller,
                        tabs: mTabs.map((String label) => Tab(text:Translations.of(context).text(label))).toList(),
                      )
                  );
                },
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          UserRepoPage(key: _personalKey,devName: user.login),
          UserRepoPage(key: _starredKey,devName: user.login,type: UserRepoPageType.starred,),
          UserEventPage(key: _eventKey,devName: user.login),
          FollowUserPage(key: _followingKey,userName: user.login),
          FollowUserPage(key: _followerKey,userName: user.login,type: FollowType.follower,)
        ],
      ),
    );
  }

  _buildPersonalHeaderInfo(User user,NestScrollViewNotifier notifier){
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: user.avatar_url,
              fit: BoxFit.cover),
        ),
        //第二层是当前主题色的半透明处理
        Container(
          color: Color(0xffffffff).withOpacity(0.1),
          width: double.infinity,
        ),
        //第三层是对前两层背景做高斯模糊处理，然后显示上面的内容
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Container(
              width: double.infinity,
              height: 280,
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.only(top: 80,left: 20,right: 20,bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CustomWidget.showHeaderImage(user.avatar_url ?? "",width: 100),
                        Expanded(
                          child:  Padding(
                            padding: const EdgeInsets.only(left: 10,),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(user.login,style: TextStyle(color: Colors.white,fontSize: 22),),
                                Padding(padding: const EdgeInsets.only(top: 5),),
                                Row(children: <Widget>[
                                  Icon(Icons.location_on,size: 12,color: Colors.white,),
                                  Padding(padding: const EdgeInsets.only(left: 5),),
                                  Text(user.location ?? "暂无定位",style: TextStyle(color: Colors.white,fontSize: 12),),
                                ],),
                                Padding(padding: const EdgeInsets.only(top: 5),),
                                Row(children: <Widget>[
                                  Icon(Icons.compare,size: 12,color: Colors.white,),
                                  Padding(padding: const EdgeInsets.only(left: 5),),
                                  Text(user.company?? "暂无公布",style: TextStyle(color: Colors.white,fontSize: 12),),
                                ],),
                                Padding(padding: const EdgeInsets.only(top: 5),),
                                Row(children: <Widget>[
                                  Icon(Icons.link,size: 12,color: Colors.white,),
                                  Padding(padding: const EdgeInsets.only(left: 5),),
                                  Text(user.blog ?? "暂无博客",style: TextStyle(color: Colors.white,fontSize: 12),),
                                ],),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !(user.login == Global.profile.user.login),
                          child: InkWell(
                            onTap: _followOrUnfollowUser,
                            child: Icon(
                                notifier.isFollow ? Icons.favorite : Icons.favorite_border ,
                                size: 35,
                                color: notifier.isFollow ? Colors.red : Colors.white),
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(user.name,style: TextStyle(color: Colors.white70,fontSize: 15),)
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(user.created_at.substring(0,10),style: TextStyle(color: Colors.white70,fontSize: 13),),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: this.child,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
