/*
* ZJShowDialogTool created by zj 
* on 2020/5/15 11:38 AM
* copyright on zhangjiang
*/
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

//按钮点击的回调
typedef AlertClickAction<T> = void Function(dynamic data);

class ZJShowDialogTool {

  ZJShowDialogTool({@required this.context});

  BuildContext context;

  static ZJShowDialogTool of(BuildContext context){
    return ZJShowDialogTool(context: context);
  }

  void showLoading(String string){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(string),
                ),
              ],
            ),
          );
        }
    );
  }

  void showToast(String string){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(string),
              ),
            ],
          ),
        );
      }
    );
    Future.delayed(const Duration(seconds: 2),(){
      Navigator.of(context).pop();
    });
  }

  /*记得在回调方法中pop到当前的alert*/
  void showCustomAlertDialog(String content,AlertClickAction clickAction){

    if(Platform.isIOS){
      showCupertinoDialog(
        context: context,
        builder: (context){
          return  CupertinoAlertDialog(
            title: Text("提示"),
            content: Text(content),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: (){
                  clickAction(1);
                }
              ),
              CupertinoDialogAction(
                child: Text('确定'),
                  onPressed: (){
                    clickAction(2);
                  }
              ),
            ],
          );
        }
      );
    }else if(Platform.isAndroid){
      showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("提示"),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text('取消'),
                  onPressed: (){
                    clickAction(1);
                  }
              ),
              FlatButton(
                child: Text('确定'),
                  onPressed: (){
                    clickAction(2);
                  }
              ),
            ],
          );
      });
    }
  }

}