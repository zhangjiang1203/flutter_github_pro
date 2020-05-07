/*
* NetWorkRequest created by zj 
* on 2020/5/7 4:42 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import '../models/index.dart';
import 'dart:io';
import 'Global.dart';

class NetWorkRequest {

  //网络请求过程中可能会用到当前的context信息，比如在请求失败的时候，打开一个新的路由
  NetWorkRequest([this.context]){
    _options = Options(extra: {"context":context});
  }

  BuildContext context;
  Options _options;

  static Dio dio = new Dio(
    BaseOptions(
      baseUrl: "https://api.github.com/",
      headers: {
        HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
        "application/vnd.github.symmetra-preview+json",
      },
    ));

  static void init(){
    //添加缓存插件
    dio.interceptors.add(Global.netCache);
    //设置用户token
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    //调试模式下需要抓包测试，使用代理 禁用HTTPS证书校验
    if(!Global.isRelease){
      //设置代理
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
        client.findProxy = (uri){
          return "PROXY 10.1.10.25:8888";
        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以禁用证书校验
        client.badCertificateCallback = (X509Certificate cert,String host,int port) => true;
      };
    }
  }

  //登录成功返回用户信息
  Future<User> login(String login,String pwd) async {
    String basic = "Basic" + base64Encode(utf8.encode('$login:$pwd'));
    //本接口禁用缓存
    var r = await dio.get("/users/$login",
          options: _options.merge(headers: {HttpHeaders.authorizationHeader:basic},
              extra: {"noCache":true}),
    );
    //登录成功之后更新公共头，此后所有的请求都会带上用户信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    Global.netCache.cache.clear();
    //更新用户的token信息
    Global.profile.token = basic;
    return User.fromJson(r.data);
  }

  //获取用户项目列表
  Future<List<Repo>> getRepos({Map<String,dynamic> parameters,refresh = false}) async{

    if(refresh){
      //清空缓存，拦截器中或读取这些信息清空缓存
      _options.extra.addAll({"refresh":true,"list":true});
    }
    var r = await dio.get("user/repos",queryParameters: parameters,options: _options);
    return r.data.map((e)=>Repo.fromJson(e)).toList();
  }


}