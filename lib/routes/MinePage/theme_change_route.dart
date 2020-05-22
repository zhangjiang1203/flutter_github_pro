/*
* ThemeChangeRoute created by zj 
* on 2020/5/7 5:51 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:provider/provider.dart';
import '../../common/ProfileChangeNotifier.dart';
class ThemeChangeRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ThemeChangeRoute"),
        ),
        body: ListView(
          children: Global.themes.keys.map<Widget>((e){
            return GestureDetector(
              child: Padding(
                padding:const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
                child: Container(
                  color: Global.themes[e],
                  height: 40,
                  alignment: Alignment.center,
                  child: Text(e,style: TextStyle(color: Colors.white,fontSize: 18),),
                  ),
                ),
              onTap: (){
                //更新主题
                Provider.of<ThemeProvider>(context).theme = Global.themes[e];
              },
            );
          }).toList(),
        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}