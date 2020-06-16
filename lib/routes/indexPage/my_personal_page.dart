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
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/my_sliver_persistent_delegate.dart';
import 'package:fluttergithubpro/routes/indexPage/user_repo_page.dart';

class PersonalRepoPage extends StatefulWidget {
  PersonalRepoPage({Key key,@required this.userName}) : super(key: key);

  final String userName;

  @override
  _PersonalRepoPageState createState() => _PersonalRepoPageState();
}

class _PersonalRepoPageState extends State<PersonalRepoPage> with SingleTickerProviderStateMixin {

  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPersonalPage(Global.profile.user),
    );

    return Scaffold(
      body: FutureBuilder(
        future: _getPersonalData(),
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.hasError){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/request_error.png",width: 60,),
                    Text(snapshot.error.toString().split("message:").last,style:TextStyle(color:Color(0xffbfbfbf))),
                  ],
                ),
              );
            }else{
              return _buildPersonalPage(snapshot.data);
            }
          }else{
           return Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 CircularProgressIndicator(),
                 Text('火速加载中'),
               ],
             ),
           );
          }
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
      headerSliverBuilder: (context,innerBoxIsScrolled){
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("你好"),//,style: ZJTextStyleTool.white_40,),
              background: Container(
                width: double.infinity,
                child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/placeholder_image.png",
                  image: user.avatar_url,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MySliverPersistentHeaderDelegate(
              minHeight: 200,
              maxHeight: 200,
              child: Stack(
                children: <Widget>[

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