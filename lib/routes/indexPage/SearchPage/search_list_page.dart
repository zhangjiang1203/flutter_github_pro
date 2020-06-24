/*
* search_list_page created by zhangjiang 
* on 2020/6/18 11:35 PM
* copyright on zhangjiang
*/

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/Providers/EventStreamSet.dart';
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
  TabController _tabController;

  GlobalKey<SearchUserPageState> _userKey = GlobalKey<SearchUserPageState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2 ,vsync: this);
    _tabController.addListener(() {
      if(_tabController.index == 1){
        _userKey.currentState.reloadSearchResult(_searchCon.text,isNotice: true);
      }
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _searchCon.dispose();
    super.dispose();
  }

  Widget _buildMySearchText(){
    return Container (
        height: 40,
        child: TextField(
          autofocus: true,
          style: TextStyle(color: Color(0xffffffff),fontSize: 18,),
          controller: _searchCon,
          onSubmitted: (e){
            if(e.length > 0){
              eventBus.fire(SearchEvent(searchText: e));
            }
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
    );
  }

  Widget _buildMySearchBody(){
      return  TabBarView(
          controller: _tabController,
          children: <Widget>[
            SearchRepoPage(searchText: _searchCon.text),
            SearchUserPage(key:_userKey,searchText: _searchCon.text),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,color: Color(0xffffffff)),
          onPressed: ()=>Navigator.of(context).pop(),
        ),
        elevation: 0,
        title:  _buildMySearchText(),
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
      body: _buildMySearchBody(),
  );
  }
}