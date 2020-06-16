/*
* user_repo_page created by zj 
* on 2020/6/16 6:05 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class UserRepoPage extends StatefulWidget {
  UserRepoPage({Key key}) : super(key: key);

  @override
  _UserRepoPageState createState() => _UserRepoPageState();
}

class _UserRepoPageState extends State<UserRepoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: EasyRefresh.custom(
            slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 50,
                delegate: SliverChildBuilderDelegate((context,index) {
                  return Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.centerLeft,
                    color: Colors.red[100*(index%9)],
                    child: Text("listView==$index"),
                  );
                },
                    childCount: 50),
              ),
            ]),
    );
  }
}