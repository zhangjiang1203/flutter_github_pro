/*
* home_pages created by zj 
* on 2020/5/7 10:19 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import '../common/Translations.dart';
import 'MyDrawer.dart';

GlobalKey _button = GlobalKey();

class AppHomePage extends StatefulWidget {
  AppHomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<AppHomePage> {

  PopupMenuButton _popupMenuButton(){
    return PopupMenuButton(
      itemBuilder: (context) => _getPopMenuButton(context),
      onCanceled: (){
        print("取消了");
      },
      onSelected: (value){
        print("选择的项目===$value");
        if (value == "主题"){
          Navigator.pushNamed(context,"theme_change_route");
        }else if (value == "语言"){
          Navigator.pushNamed(context,"Change_local_route");
        }
      },
//      child: RaisedButton(
//        child: Text('请选择'),
//        onPressed: (){
//
//        },
//      ),
    );
  }

   List<PopupMenuEntry<String>> _getPopMenuButton(BuildContext context) {
    return <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: '主题',
        child: Text('主题'),
      ),
      PopupMenuItem<String>(
        value: '语言',
        child: Text('语言'),
      ),
    ];
  }

  void _showPopMenu(BuildContext context) {
    //获取Position和items
    final RenderBox button = _button.currentContext.findRenderObject();
    final Offset offsetA = button.localToGlobal(Offset.zero);
//    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
//    final Offset offsetB = button.localToGlobal(button.size.bottomRight(Offset.zero),
//        ancestor: overlay);
//    RelativeRect position = RelativeRect.fromRect(
//        Rect.fromPoints(offsetA, offsetB,),
//        Offset.zero & overlay.size,
//    );
    //获取到按钮点击的位置信息，去绘制showView的位置
    RelativeRect position = RelativeRect.fromLTRB(offsetA.dx, offsetA.dy+button.size.height,0,0);// position.right, position.bottom);
    var _pop = _popupMenuButton();
    showMenu<String>(
        context: context,
        position: position,
        items:_pop.itemBuilder(context)
    ).then((value){
      if(!mounted) return null;
      if(value == null) {
        if(_pop.onCanceled != null) _pop.onCanceled();
        return null;
      }
      if(_pop.onSelected != null) _pop.onSelected(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(Translations.of(context).text("home_title")),
          actions: <Widget>[
            IconButton(
              key: _button,
              icon: Icon(Icons.select_all),
              onPressed: () => _showPopMenu(context),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              DropdownButton(
                value: 1,
                underline: Container(),
                onChanged: (value){
                  print("value change $value");
                },
                items: <DropdownMenuItem>[
                  DropdownMenuItem(
                    value: 1,
                    child: Text("哈哈哈1"),
                    onTap: (){

                    },
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text("哈哈哈2"),
                    onTap: (){

                    },
                  ),
                  DropdownMenuItem(
                    value: 3,
                    child: Text("哈哈哈3"),
                    onTap: (){

                    },
                  ),
                  DropdownMenuItem(
                    value: 4,
                    child: Text("哈哈哈4"),
                    onTap: (){

                    },
                  ),
                ],
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}