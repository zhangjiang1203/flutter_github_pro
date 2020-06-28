/*
* mine_page created by zj 
* on 2020/5/22 6:35 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  MinePage({Key key}) : super(key: key);

  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> with SingleTickerProviderStateMixin {

  final Map<String,IconData> showTitles = {"app_theme":Icons.theaters,"app_language":Icons.language,"app_battery":Icons.battery_full};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("mine_page开始编译");
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("mine_page")),
        ),
        body: Consumer<ThemeProvider>(
          builder: (context,themePro,child){
            return Center(
              child: ListView(
                itemExtent: 44,
                children: showTitles.keys.map((e) => ListTile(
                  title: Text(Translations.of(context).text(e),style: TextStyle(color: themePro.theme,fontSize: 18),),
                  leading: Icon(showTitles[e],color: themePro.theme,),
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
            );
          },
        )
    );


  }
}