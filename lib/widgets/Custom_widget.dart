/*
* Custom_widget created by zj 
* on 2020/6/24 12:43 PM
* copyright on zhangjiang
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Global.dart';

class CustomWidget{

  static Widget showHeaderImage(String url,{double width=80,double borderWidth=1}){
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red,
            width: borderWidth
          ),
          borderRadius: BorderRadius.all(Radius.circular(width*0.5)),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              offset: Offset(-2, 1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context,url)=>Global.defaultHeaderImage(width: width),
            width: width,
          ),
        )
    );
  }

}