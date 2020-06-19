/*
* MyDrawer created by zj 
* on 2020/5/11 2:24 PM
* copyright on zhangjiang
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/my_personal_page.dart';
import 'package:fluttergithubpro/routes/indexPage/SearchPage/search_list_page.dart';
import 'package:fluttergithubpro/routes/indexPage/TrendPage/trend_list_page.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MyDrawer extends StatelessWidget {

  Map leftData = {
    "drawer_owner":Icons.lock,
    "drawer_search":Icons.search,
    "drawer_trend":Icons.train,
    'drawer_pub_address':Icons.add};

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
              Padding(padding: const EdgeInsets.only(top: 8),),
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
                      child: Text(Translations.of(context).text("drawer_login_out"),style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                    onPressed: (){
                      //回到登录界面，取消登录状态,弹出界面提示
                      ZJShowDialogTool.of(context).showCustomAlertDialog("确定要退出当前应用吗?",(index){
//                        Navigator.of(context).pop();
                        if (index == 2){
                          Provider.of<UserProvider>(context,listen: false).user = null;
                          Navigator.of(context).pushNamedAndRemoveUntil("Login_route", (route) => false);
                        }
                      });
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
      builder: (context,userP,child){
        return GestureDetector(
          child: Container(
            color: Provider.of<ThemeProvider>(context).theme,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,30 , 8, 10),
              child: Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userP.user?.avatar_url ?? "",
                      width: 60,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 5),
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(userP.user?.login ?? "请登录",style: TextStyle(fontSize: 20,color: Colors.white),),
                          Padding(padding: const EdgeInsets.only(top: 5)),
                          Text(userP.user?.bio ?? "",style: TextStyle(fontSize: 14,color: Colors.white),maxLines: 3,)
                        ],
                      ),
                    ),
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
      builder: (context,userP,child){
        return ListView(
          itemExtent: 60,
          children: leftData.keys.map((e) => ListTile(title:Row(
              children: <Widget>[
                Icon(leftData[e],color: Provider.of<ThemeProvider>(context).theme,),
                Padding(padding: const EdgeInsets.only(left: 5),),
                Text(Translations.of(context).text(e),style: TextStyle(fontSize: 16,color: Colors.black54),)
              ]),
            trailing: Icon(Platform.isIOS ? Icons.arrow_forward_ios : Icons.arrow_forward,size: 12,),
            onTap: (){
              Navigator.of(context).pop();
              //点击跳转逻辑
              if(e == "drawer_owner"){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return PersonalRepoPage(userName:userP.user?.login ?? "");
                }));
              }else if (e == 'drawer_search'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return SearchListPage();
                }));
              }else if (e == 'drawer_trend'){
                Navigator.of(context).push(MaterialPageRoute(builder: (_){
                  return TrendListPage();
                }));
              }
            },)).toList()
        );
      },
    );
  }
}