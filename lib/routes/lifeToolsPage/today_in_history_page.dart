/*
* today_in_history_page created by zj 
* on 2020/5/25 11:03 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/HttpManager/index.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/today_history_model_entity.dart';

class TodayInHistoryPage extends StatefulWidget {
  TodayInHistoryPage({Key key}) : super(key: key);

  @override
  _TodayInHistoryState createState() => _TodayInHistoryState();
}

class _TodayInHistoryState extends State<TodayInHistoryPage> {

  String dateTime = '1/1';

  Future _getTodayInHistoryData(){
    return HTTPManager().getAsync<List<TodayHistoryModelEntity>>(url: getTodayHistoryData,params: {'date':dateTime}, tag: 'getTodayHistoryData');
  }

  //日历选择器
  Future<DateTime> showDatePickerDialogView<T>() {

    var time = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: time ,
        firstDate: time.add(Duration(days: -30*365)),
        //可选时间为30天，设置初始时间和结束时间
        lastDate:time
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("history_today")),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.calendar_today),
              onPressed: () async {
              //弹出日历
                DateTime time = await showDatePickerDialogView();
                if(time != null){
                  int month = time.month;
                  int day = time.day;
                  setState(() {
                    dateTime = '$month/$day';
                  });
                }

            },)
          ],
        ),
        body: FutureBuilder(
          future: _getTodayInHistoryData(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return Center(
                  child: Text('获取油价信息失败',textScaleFactor: 2,),
                );
              }else{
                List<TodayHistoryModelEntity> showData = snapshot.data;
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(showData[index].date,style: TextStyle(fontSize: 15,color: ZJColor.StringColor('999999'))),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(showData[index].title,style: TextStyle(fontSize: 18),),
                                ),
                                
                              ],
                            )
                          ),
                        ),
                      );
                    });
              }
            }else {
              return CircularProgressIndicator();
            }
          },
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}