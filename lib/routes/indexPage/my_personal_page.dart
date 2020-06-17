/*
* my_repo_page created by zj 
* on 2020/6/16 4:04 PM
* copyright on zhangjiang
*/

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/my_sliver_persistent_delegate.dart';
import 'package:fluttergithubpro/routes/indexPage/user_repo_page.dart';
import 'package:provider/provider.dart';
import '../../Providers/ProvidersCollection.dart';


class PersonalRepoPage extends StatefulWidget {
  PersonalRepoPage({Key key,@required this.userName}) : super(key: key);

  final String userName;

  @override
  _PersonalRepoPageState createState() => _PersonalRepoPageState();
}

class _PersonalRepoPageState extends State<PersonalRepoPage> with SingleTickerProviderStateMixin {

  List<String> mTabs = <String>['personal_repos', "personal_stars", "personal_dynamic", "personal_focus", "personal_fans"];


  TabController _controller;
  ScrollController _scrollController;
  NestScrollViewNotifier _nestScrollViewNotifier;
  GlobalKey key = GlobalKey();
  bool isShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nestScrollViewNotifier = NestScrollViewNotifier(maxOffset: 200);
    _controller = TabController(length: 5,vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print('开始滚动${_scrollController.offset}');
      _nestScrollViewNotifier.setOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getPersonalData(),
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
      int index = await RequestAPI.instance.checkIsFollowSomeone(widget.userName);
    }
    return RequestAPI.instance.getUserInfo(widget.userName);
  }

  _buildPersonalPage(User user){
    return  NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 0,
            pinned: true,
            expandedHeight: 220,
            title:ChangeNotifierProvider<NestScrollViewNotifier>(
              create: (context)=> _nestScrollViewNotifier,
              child: Consumer<NestScrollViewNotifier>(
                builder: (context,nestNoti,child){
                  return !nestNoti.isShowNavBar ? Container() : TabBar(
                    isScrollable: true,
                    indicatorPadding: const EdgeInsets.all(0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 14.0),
                    unselectedLabelColor: Colors.white60,
                    indicatorColor: Colors.greenAccent,
                    controller: _controller,
                    tabs: mTabs.map((String label) => Tab(text:Translations.of(context).text(label))).toList(),
                  );
                },
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _buildPersonalHeaderInfo(user),
            ),
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
          UserRepoPage(devName: user.login),
          UserRepoPage(devName: user.login,type: UserRepoPageType.starred,),
          UserRepoPage(devName: user.login),
          UserRepoPage(devName: user.login),
          UserRepoPage(devName: user.login),
        ],
      ),
    );
  }

  _buildPersonalHeaderInfo(User user){

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
                        ClipOval(
                          child: CachedNetworkImage(
                            width: 100,
                            imageUrl: user.avatar_url,
                            placeholder: (context,url){
                              return Global.placeholder;
                            },
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 10,),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(user.login,style: TextStyle(color: Colors.white,fontSize: 22),),
                              Row(children: <Widget>[
                                Icon(Icons.location_on,size: 12,color: Colors.white,),
                                Text(user.location ?? "暂无定位",style: TextStyle(color: Colors.white,fontSize: 12),),
                              ],),
                              Row(children: <Widget>[
                                Icon(Icons.compare,size: 12,color: Colors.white,),
                                Text(user.company?? "暂无公布",style: TextStyle(color: Colors.white,fontSize: 12),),
                              ],),
                              Row(children: <Widget>[
                                Icon(Icons.link,size: 12,color: Colors.white,),
                                Text(user.blog ?? "暂无博客",style: TextStyle(color: Colors.white,fontSize: 12),),
                              ],),
                            ],
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
                      child: Text(user.created_at.substring(0,12),style: TextStyle(color: Colors.white70,fontSize: 13),),
                    ),
                  ],
                ),
              ),

            ),
          ),
        ),
      ],
    );
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.black54,
      child: Padding(
        padding: const EdgeInsets.only(top: 80,left: 20,right: 20,bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipOval(
                  child: CachedNetworkImage(
                    width: 100,
                    imageUrl: user.avatar_url,
                    placeholder: (context,url){
                      return Global.placeholder;
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(user.login,style: TextStyle(color: Colors.white,fontSize: 22),),
                      Row(children: <Widget>[
                        Icon(Icons.location_on,size: 12,color: Colors.white,),
                        Text(user.location,style: TextStyle(color: Colors.white,fontSize: 12),),
                      ],),
                      Row(children: <Widget>[
                        Icon(Icons.compare,size: 12,color: Colors.white,),
                        Text(user.location,style: TextStyle(color: Colors.white,fontSize: 12),),
                      ],),
                      Row(children: <Widget>[
                        Icon(Icons.link,size: 12,color: Colors.white,),
                        Text(user.blog,style: TextStyle(color: Colors.white,fontSize: 12),),
                      ],),
                    ],
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
              child: Text(user.created_at.substring(0,12),style: TextStyle(color: Colors.white70,fontSize: 13),),
            ),
          ],
        ),
      ),

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
