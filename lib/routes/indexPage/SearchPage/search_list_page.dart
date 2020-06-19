/*
* search_list_page created by zhangjiang 
* on 2020/6/18 11:35 PM
* copyright on zhangjiang
*/

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/Providers/ProvidersCollection.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/follow_user_page.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/my_personal_page.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/user_repo_page.dart';
import 'package:fluttergithubpro/routes/indexPage/SearchPage/search_repo_page.dart';
import 'package:fluttergithubpro/routes/indexPage/SearchPage/search_user_page.dart';
import 'package:provider/provider.dart';

class SearchListPage extends StatefulWidget {
  SearchListPage({Key key}) : super(key: key);



  @override
  _SearchListPageState createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {

  TextEditingController _searchCon = new TextEditingController();
  TabController _tabController ;
  GlobalKey<SearchRepoPageState> _repoKey = GlobalKey<SearchRepoPageState>();
  GlobalKey<SearchUserPageState> _userKey = GlobalKey<SearchUserPageState>();


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2 ,vsync: this);

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
//      decoration: BoxDecoration(
//        image: DecorationImage(
//          image:  ExactAssetImage("assets/images/book_background.jpg"),
//          fit: BoxFit.cover,
//        ),
//      ),
      child: Stack(
          children: <Widget>[
//            ClipRRect(
//              child: BackdropFilter(
//                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
//                child: Container(
//                  width: double.infinity,
//                  height: double.infinity,
//                  color: Colors.black.withOpacity(0.1),
//                ),
//              ),
//            ),
            Scaffold(
                resizeToAvoidBottomPadding: false,
                appBar: AppBar(
                  leading: IconButton(
                    icon:Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,color: Color(0xffffffff)),
                    onPressed: ()=>Navigator.of(context).pop(),
                  ),
                  elevation: 0,
                  title:  Container (
                    height: 40,
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(color: Color(0xffffffff),fontSize: 18,),
                        controller: _searchCon,
                        onSubmitted: (e){
                          //点击搜索
                          print('开始搜索===$e');
                          _repoKey.currentState.reloadSearchResult(e);
                          _userKey.currentState.reloadSearchResult(e);
                        },
                        textInputAction: TextInputAction.search,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20,right: 20),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear,color: Color(0xffffffff),),
                            onPressed: ()=> setState(()=>_searchCon.text = ""),
                          ),
                          isDense: true,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(color: Color(0x00ffffff))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:Color(0xffffffff)),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: '请输入搜索内容',
                          hintStyle: TextStyle(color: Color(0xffececec),textBaseline: TextBaseline.alphabetic),
                        ),
                  )
                  ),
                  bottom: TabBar(
                    controller: _tabController,
                    labelColor: Colors.white,
                    indicatorColor: Colors.transparent,
                    labelStyle: TextStyle(fontSize: 18),
                    tabs: <Widget>[
                      Tab(text: '仓库'),
                      Tab(text: '个人',),
                    ],
                  ),
                ),
                body:  SafeArea(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        SearchRepoPage(key: _repoKey,searchText: _searchCon.text,),
                        SearchUserPage(key: _userKey,searchText: _searchCon.text,),
                      ],
                    ),
                  ),
            )
          ],
        ),
      );
  }
}