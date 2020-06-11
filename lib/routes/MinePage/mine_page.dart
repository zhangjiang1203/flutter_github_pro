/*
* mine_page created by zj 
* on 2020/5/22 6:35 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin {

  final List<String> titles =  ["app_theme","app_language","app_battery"];
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 5,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    print("mine_page开始编译");
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("mine_page")),
        ),
        body: Center(
          child: ListView(
            itemExtent: 44,
            children: titles.map((e) => ListTile(
              title: Text(Translations.of(context).text(e)),
              onTap: (){
                if (e == "app_theme"){
                  Navigator.pushNamed(context,"theme_change_route");
                }else if (e == "app_language"){
                  Navigator.pushNamed(context,"Change_local_route");
                }else if (e == "app_battery"){
                  Navigator.pushNamed(context,"get_battery_level");
                }
              },
            )
            ).toList(),
          ),
        )
    );
  }
}