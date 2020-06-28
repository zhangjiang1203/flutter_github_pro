/*
* ChangeLocalRoute created by zj 
* on 2020/5/8 10:09 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/ProfileChangeNotifier.dart';
import 'package:fluttergithubpro/common/Translations.dart';
import 'package:provider/provider.dart';

class ChangeLocalRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localProvider = Provider.of<LocaleProvider>(context);
    Widget _buildLanguageItem(String lan,value){
      return ListTile(
        title: Text(
          lan,
          style: TextStyle(color: localProvider.locale == value ? color : null),
        ),
        trailing: localProvider.locale == value ? Icon(Icons.done,color: color) : null,
        onTap: (){
          localProvider.locale = value;
        },
      );
    };
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("change_language")),
        ),
        body: ListView(
          children: <Widget>[
            _buildLanguageItem("中文简体", "zh"),
            _buildLanguageItem("Englist", "en"),
            _buildLanguageItem("跟随系统", null),
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}