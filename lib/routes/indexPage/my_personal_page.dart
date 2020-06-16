/*
* my_repo_page created by zj 
* on 2020/6/16 4:04 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/common/ScreenUtil.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/my_sliver_persistent_delegate.dart';
import 'package:fluttergithubpro/routes/indexPage/user_repo_page.dart';
import 'package:provider/provider.dart';


class PersonalRepoPage extends StatefulWidget {
  PersonalRepoPage({Key key,@required this.userName}) : super(key: key);

  final String userName;

  @override
  _PersonalRepoPageState createState() => _PersonalRepoPageState();
}

class _PersonalRepoPageState extends State<PersonalRepoPage> with SingleTickerProviderStateMixin {

  TabController _controller;
  ScrollController _scrollController;
  GlobalKey key = GlobalKey();
  bool isShowNav = false;

  bool isShow = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5,vsync: this);
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      print('开始滚动${_scrollController.offset}');
      if(_scrollController.offset > 250){
        setState(() {
          isShow = true;
        });

      }else{
        setState(() {
          isShow = false;
        });
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    var mTabs = <String>['仓库', "星标", "动态", "关注", "粉丝"];

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              elevation: 0,
              pinned: true,
              expandedHeight: 300,//ScreenUtil.statusBarHeight,
              backgroundColor:isShow ? Provider.of<ThemeProvider>(context).theme : Color(0x00000000),
              flexibleSpace:  Stack(
                children: <Widget>[
                  Image.asset("assets/images/github_logo.png",fit: BoxFit.cover,),
                  Positioned(
                    bottom:7,
                    left: 40,
                    width: ScreenUtil.screenWidthDp-80,
                    height: 44,
                    child: TabBar(
                      labelColor: Colors.white,
                      labelStyle: TextStyle(fontSize: 15.0),
                      unselectedLabelColor: Colors.white60,
                      indicatorColor: Colors.greenAccent,
                      controller: _controller,
                      tabs: mTabs
                          .map((String label) => Tab(
                        text: label,
                      ))
                          .toList(),
                    )
                  ),
                ],
              ),

            ),
            //tab栏
            SliverPersistentHeader(
              pinned: false,
              delegate: MySliverPersistentHeaderDelegate(
                minHeight: 50,
                maxHeight: 50,
                child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: TabBar(
                      labelColor: Colors.white,
                      labelStyle: TextStyle(fontSize: 15.0),
                      unselectedLabelColor: Colors.white60,
                      indicatorColor: Colors.greenAccent,
                      controller: _controller,
                      tabs: mTabs
                          .map((String label) => Tab(
                        text: label,
                      ))
                          .toList(),
                    )),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            UserRepoPage(),
            UserRepoPage(),
            UserRepoPage(),
            UserRepoPage(),
            UserRepoPage(),

          ],
        ),
      )
    );
//    return Scaffold(
//      body: FutureBuilder(
//        future: _getPersonalData(),
//        builder: (context,snapshot){
//          if(snapshot.connectionState == ConnectionState.done){
//            if(snapshot.hasError){
//              return Center(
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Image.asset("assets/images/request_error.png",width: 60,),
//                    Text(snapshot.error.toString().split("message:").last,style:TextStyle(color:Color(0xffbfbfbf))),
//                  ],
//                ),
//              );
//            }else{
//              return _buildPersonalPage(snapshot.data);
//            }
//          }else{
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 CircularProgressIndicator(),
//                 Text('火速加载中'),
//               ],
//             ),
//           );
//          }
//        },
//      ),
//    );
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
      headerSliverBuilder: (context,innerBoxIsScrolled){
        return <Widget>[
//          SliverAppBar(
//            expandedHeight: 200,
//            pinned: true,
//            flexibleSpace: FlexibleSpaceBar(
//              title: Text("你好"),//,style: ZJTextStyleTool.white_40,),
//              background: Container(
//                width: double.infinity,
//                child: FadeInImage.assetNetwork(
//                  placeholder: "assets/images/placeholder_image.png",
//                  image: user.avatar_url,
//                  fit: BoxFit.cover,
//                ),
//              ),
//            ),
//          ),
          SliverPersistentHeader(
            pinned: false,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 200 ,
              maxHeight: 200,
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 30 ,
              maxHeight: 30,
              child: TabBar(
                controller: _controller,
                labelColor: Colors.black,
                tabs: <Widget>[
                  Tab(text: '咨询',),
                  Tab(text: "技术",),
                  Tab(text: '新闻',),
                  Tab(text: '娱乐',),
                  Tab(text: '科技',)
                ],
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        children: <Widget>[
          UserRepoPage(),
          UserRepoPage(),
          UserRepoPage(),
          UserRepoPage(),
          UserRepoPage(),
        ],
        controller: _controller,
      ),
    );
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
