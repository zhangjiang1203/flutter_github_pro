/*
* MyDrawer created by zj 
* on 2020/5/11 2:24 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        removeTop: true,
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipOval(
                            child: Image.asset("assets/images/default_avator.png",width: 50,),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(start: 5),
                            child: Text("我就是我不一样的烟火"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  itemExtent: 40,
                  children: <Widget>[
                    ListTile(title: Text("第一个"),),
                    ListTile(title: Text("第二个"),),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}