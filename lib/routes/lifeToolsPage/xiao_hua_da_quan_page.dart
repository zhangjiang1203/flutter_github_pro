/*
* xiao_hua_da_quan_page created by zj 
* on 2020/5/25 11:02 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/models/jokes_data_model_entity.dart';

class XiaoHuaDaQuanPage extends StatefulWidget {
  XiaoHuaDaQuanPage({Key key}) : super(key: key);

  @override
  _XiaoHuaDaQuanState createState() => _XiaoHuaDaQuanState();
}

class _XiaoHuaDaQuanState extends State<XiaoHuaDaQuanPage> {
  Future _getJokeData() {
    int time = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return HTTPManager().getAsync<List<JokesDataModelEntity>>(url: getJokesData,params: {'time':time}, tag: "getJokesData");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("xiao_hua_da_quan_page"),
        ),
        body: FutureBuilder(
          future: _getJokeData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return Center(
                  child: Text('获取油价信息失败',textScaleFactor: 2,),
                );
              }else{
                List<JokesDataModelEntity> showData = snapshot.data;
                return ListView.builder(
                    itemCount: showData.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Material(
                            color: Colors.white,
                            shape: BorderDirectional(
                              bottom: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 0.5,
                              )
                            ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(showData[index].content),
                          ),
                        ),
                      );
                    });
              }
            }else {
              return CircularProgressIndicator();
            }
          },
        ), //  // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}