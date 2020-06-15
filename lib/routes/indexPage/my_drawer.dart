/*
* MyDrawer created by zj 
* on 2020/5/11 2:24 PM
* copyright on zhangjiang
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        removeTop: true,
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _builderHeaderWidget(),
              Expanded(
                child: _builderMenuItems(),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 40),
                  child: FlatButton(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                        color: Provider.of<ThemeProvider>(context).theme,
                      ),
                      height: 50,
                      child: Text('退出登录',style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                    onPressed: (){
                      //回到登录界面，取消登录状态
//                      Navigator.of(context).pushReplacementNamed("Login_route");
                      Navigator.of(context).pushNamedAndRemoveUntil("Login_route", (route) => false);
                      Provider.of<UserProvider>(context,listen: false).user = null;
                    },
                  )
                ),
              ),
            ],
          ),
      ),
    );
  }

  Widget _builderHeaderWidget(){
    return Consumer<UserProvider>(
      builder: (context,user,child){
        return GestureDetector(
          child: Container(
            color: Provider.of<ThemeProvider>(context).theme,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,50 , 8, 30),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: Global.profile.user.avatar_url,
                      width: 60,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: 5),
                    child: Text(Global.profile.user.login,style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _builderMenuItems(){
    return Consumer<UserProvider>(
      builder: (context,user,child){
        return ListView(
          itemExtent: 40,
          children: <Widget>[
            ListTile(title: Text("个人主页"),),
          ],
        );
      },
    );
  }
}