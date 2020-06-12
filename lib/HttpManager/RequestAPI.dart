/*
* RequestAPI created by zj 
* on 2020/6/12 4:23 PM
* copyright on zhangjiang
*/

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/HTTPManager.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'RequestURLPath.dart';
import 'CommentUse.dart';

class GithubAPI{

  //github OAuth认证需要，没有认证某些接口访问次数限制为60次/小时，认证后为5000次/小时
  final Map oAuthParams = {
    "scopes": ['user', 'repo'],
    "note": "admin_script",
    "client_id": URLAPI.GithubClientId,
    "client_secret": URLAPI.GithubClientSecret
  };

  getAuthorization(){
    String basic = Global.preferences.get(CommentUse.basic);
    return basic;
  }

  //获取token
  void getPassToken() async{
    Options options = Options(headers: {"Authorization":getAuthorization()});
    var r = await HTTPManager().postAsync(url: URLAPI.githubAuthirizations,data: json.encode(oAuthParams),options: options );
    if(r['token'] != null){
      //更新token
      Global.profile.token = r['token'];
    }
  }


  //登录接口
  void login(String userName,String password) async {
    //组装请求的格式
    String basic = "Basic" + base64.encode(utf8.encode('$userName"$password'));
    //保存用户名和密码
    Global.preferences.setString(CommentUse.loginName, userName);
    Global.preferences.setString(CommentUse.loginPassword, base64.encode(utf8.encode(password+CommentUse.base64Extra)));
    Global.preferences.setString(CommentUse.basic, basic);
    getPassToken();
     var user = await HTTPManager().getAsync<User>(url: URLAPI.getUser(userName));
     print('获取用户信息$user');
//     Global.preferences.setString(CommentUse.RealName, user.login);
//     return user;
  }

}

class OpenNetAPI{

}



class RequestAPI extends GithubAPI with OpenNetAPI {

  static RequestAPI _instance ;
  static RequestAPI get instance =>_getInstance();
  factory RequestAPI() => _getInstance();

  RequestAPI._internal();

  static RequestAPI _getInstance(){
    if (_instance == null){
      _instance = RequestAPI._internal();
    }
    return _instance;
  }

}