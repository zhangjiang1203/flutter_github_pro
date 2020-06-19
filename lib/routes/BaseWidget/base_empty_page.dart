/*
* base_empty_page created by zj 
* on 2020/6/19 2:12 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class BaseEmptyPage extends StatelessWidget {
  BaseEmptyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/no_data_empty_emo.png',width: 100,fit: BoxFit.fitWidth,),
          Padding(padding: const EdgeInsets.only(top: 5),),
          Text('这里空空如也😂😂',style: TextStyle(fontSize: 20,color: Colors.grey),),
        ],
      ),
    );
  }
}