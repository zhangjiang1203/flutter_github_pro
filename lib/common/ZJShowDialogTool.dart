/*
* ZJShowDialogTool created by zj 
* on 2020/5/15 11:38 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

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

}