/*
* NetWorkRequest created by zj 
* on 2020/5/7 4:42 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/index.dart';
import 'dart:io';
import 'Global.dart';
import 'dart:math' as math;
import 'ZJLogTool.dart';

class NetWorkRequest {

  //网络请求过程中可能会用到当前的context信息，比如在请求失败的时候，打开一个新的路由
  NetWorkRequest(this.context){
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
//    dio.interceptors.add(CustomDioLogger());
    dio.interceptors.add(Global.netCache);
//  dio.interceptors.add(InterceptorsWrapper(
//      onRequest: (options){
////        zjPrint("当前url==${options.uri}",StackTrace.current);
//         return options;
//      },
//      onResponse: (response){
//        return response;
//      },
//      onError:(error){
//        print(error.toString());
//        return error;
//      }
//  ));
    //设置用户token
//    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
    //调试模式下需要抓包测试，使用代理 禁用HTTPS证书校验
    if(!Global.isRelease){
      //设置代理
//      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){
//        client.findProxy = (uri){
//          return "PROXY 10.1.10.25:8888";
//        };
        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以禁用证书校验
//        client.badCertificateCallback = (X509Certificate cert,String host,int port) => true;
//      };
    }
  }

  //登录成功返回用户信息
  Future<User> login(String login,String pwd) async {
    String basic = "Basic" + base64.encode(utf8.encode('$login:$pwd'));
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
  Future<List<Repoitems>> getRepos({Map<String,dynamic> parameters,refresh = false}) async{

    if(refresh){
      //清空缓存，拦截器中或读取这些信息清空缓存
      _options.extra.addAll({"refresh":true,"list":true});
    }
    var r = await dio.get("search/repositories",queryParameters: parameters,options: _options);
    var list = Allrepolist.fromJson(r.data).items;
    return list;
  }


}





///
/// author: 小强程序设计
/// date：2020/1/19 10:37
/// description: Dio 日志拦截器
/// 参考 【pretty_dio_logger: any】，修改而来
///
class CustomDioLogger extends Interceptor {
  /// Print request [Options]
  final bool request;

  /// Print request header [Options.headers]
  final bool requestHeader;

  /// Print request data [Options.data]
  final bool requestBody;

  /// Print [Response.data]
  final bool responseBody;

  /// Print [Response.headers]
  final bool responseHeader;

  /// Print error message
  final bool error;

  /// InitialTab count to logPrint json response
  static const int initialTab = 1;

  /// 1 tab length
  static const String tabStep = '    ';

  /// Print compact json response
  final bool compact;

  /// Width size per logPrint
  final int maxWidth;

  /// Log printer; defaults logPrint log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file.
  void Function(Object object) logPrint;

  CustomDioLogger(
      {this.request = true,
        this.requestHeader = false,
        this.requestBody = false,
        this.responseHeader = false,
        this.responseBody = true,
        this.error = true,
        this.maxWidth = 90,
        this.compact = true,
        this.logPrint = print});

  @override
  Future onRequest(RequestOptions options) async {
    if (request) {
      _printRequestHeader(options);
    }
    if (requestHeader) {
      _printMapAsTable(options.queryParameters, header: 'Query Parameters');
      final requestHeaders = Map();
      if (options.headers != null) {
        requestHeaders.addAll(options.headers);
      }
      requestHeaders['contentType'] = options.contentType?.toString();
      requestHeaders['responseType'] = options.responseType?.toString();
      requestHeaders['followRedirects'] = options.followRedirects;
      requestHeaders['connectTimeout'] = options.connectTimeout;
      requestHeaders['receiveTimeout'] = options.receiveTimeout;
      _printMapAsTable(requestHeaders, header: 'Headers');
      _printMapAsTable(options.extra, header: 'Extras');
    }
    if (requestBody && options.method != 'GET') {
      final data = options.data;
      if (data != null) {
        if (data is Map) _printMapAsTable(options.data, header: 'Body');
        if (data is FormData) {
          final formDataMap = Map()
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(formDataMap, header: 'Form data | ${data.boundary}');
        } else
          _printBlock(data.toString());
      }
    }

    return options;
  }

  @override
  Future onError(DioError err) async {
    if (error) {
      if (err.type == DioErrorType.RESPONSE) {
        final uri = err.response.request.uri;
        _printBoxed(
            header:
            'DioError ║ Status: ${err.response.statusCode} ${err.response.statusMessage}',
            text: uri.toString());
        if (err.response != null && err.response.data != null) {
          logPrint('╔ ${err.type.toString()}');
          _printResponse(err.response);
        }
        _printLine('╚');
        logPrint('');
      } else
        _printBoxed(header: 'DioError ║ ${err.type}', text: err.message);
    }
    return err;
  }

  @override
  Future onResponse(Response response) async {
    if (responseHeader) {
      final responseHeaders = Map<String, String>();
      response.headers
          .forEach((k, list) => responseHeaders[k] = list.toString());
      _printMapAsTable(responseHeaders, header: 'Headers');
    }

    if (responseBody) {
      _printResponseHeader(response);
      logPrint('╔ Body');
      logPrint('║');
      _printResponse(response);
      logPrint('║');
      _printLine('╚');
    }

    return response;
  }

  void _printBoxed({String header, String text}) {
    logPrint('');
    logPrint('╔╣ $header');
    logPrint('║  $text');
    _printLine('╚');
  }

  void _printResponse(Response response) {
    if (response.data != null) {
      if (response.data is Map)
        _printPrettyMap(response.data);
      else if (response.data is List) {
        logPrint('║${_indent()}[');
        _printList(response.data);
        logPrint('║${_indent()}[');
      } else
        _printBlock(response.data.toString());
    }
  }

  void _printResponseHeader(Response response) {
    final uri = response?.request?.uri;
    final method = response.request.method;
    //添加以下代码，防止多接口请求时 response的header和body被分开打印
    String header =
        'Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}';
    logPrint('╔╣ $header' + ('═' * 70));
    logPrint('║  ${uri.toString()}');
    logPrint('║  ');
    // 去掉以下代码
    /* _printBoxed(
        header:
            'Response ║ $method ║ Status: ${response.statusCode} ${response.statusMessage}',
        text: uri.toString());*/
  }

  void _printRequestHeader(RequestOptions options) {
    final uri = options?.uri;
    final method = options?.method;
    _printBoxed(header: 'Request ║ $method ', text: uri.toString());
  }

  void _printLine([String pre = '', String suf = '╝']) =>
      logPrint('$pre${'═' * maxWidth}');

  void _printKV(String key, Object v) {
    final pre = '╟ $key: ';
    final msg = v.toString();

    if (pre.length + msg.length > maxWidth) {
      logPrint(pre);
      _printBlock(msg);
    } else
      logPrint('$pre$msg');
  }

  void _printBlock(String msg) {
    int lines = (msg.length / maxWidth).ceil();
    for (int i = 0; i < lines; ++i) {
      logPrint((i >= 0 ? '║ ' : '') +
          msg.substring(i * maxWidth,
              math.min<int>(i * maxWidth + maxWidth, msg.length)));
    }
  }

  String _indent([int tabCount = initialTab]) => tabStep * tabCount;

  void _printPrettyMap(Map data,
      {int tabs = initialTab, bool isListItem = false, bool isLast = false}) {
    final bool isRoot = tabs == initialTab;
    final initialIndent = _indent(tabs);
    tabs++;

    if (isRoot || isListItem) logPrint('║$initialIndent{');

    data.keys.toList().asMap().forEach((index, key) {
      final isLast = index == data.length - 1;
      var value = data[key];
//      key = '\"$key\"';
      if (value is String) value = '\"$value\"';
      if (value is Map) {
        if (compact && _canFlattenMap(value))
          logPrint('║${_indent(tabs)} $key: $value${!isLast ? ',' : ''}');
        else {
          logPrint('║${_indent(tabs)} $key: {');
          _printPrettyMap(value, tabs: tabs);
        }
      } else if (value is List) {
        if (compact && _canFlattenList(value))
          logPrint('║${_indent(tabs)} $key: ${value.toString()}');
        else {
          logPrint('║${_indent(tabs)} $key: [');
          _printList(value, tabs: tabs);
          logPrint('║${_indent(tabs)} ]${isLast ? '' : ','}');
        }
      } else {
        final msg = value.toString().replaceAll('\n', '');
        final indent = _indent(tabs);
        final linWidth = maxWidth - indent.length;
        if (msg.length + indent.length > linWidth) {
          int lines = (msg.length / linWidth).ceil();
          for (int i = 0; i < lines; ++i) {
            logPrint(
                '║${_indent(tabs)} ${msg.substring(i * linWidth, math.min<int>(i * linWidth + linWidth, msg.length))}');
          }
        } else
          logPrint('║${_indent(tabs)} $key: $msg${!isLast ? ',' : ''}');
      }
    });

    logPrint('║$initialIndent}${isListItem && !isLast ? ',' : ''}');
  }

  void _printList(List list, {int tabs = initialTab}) {
    list.asMap().forEach((i, e) {
      final isLast = i == list.length - 1;
      if (e is Map) {
        if (compact && _canFlattenMap(e))
          logPrint('║${_indent(tabs)}  $e${!isLast ? ',' : ''}');
        else
          _printPrettyMap(e, tabs: tabs + 1, isListItem: true, isLast: isLast);
      } else
        logPrint('║${_indent(tabs + 2)} $e${isLast ? '' : ','}');
    });
  }

  bool _canFlattenMap(Map map) {
    return map.values.where((val) => val is Map || val is List).isEmpty &&
        map.toString().length < maxWidth;
  }

  bool _canFlattenList(List list) {
    return (list.length < 10 && list.toString().length < maxWidth);
  }

  void _printMapAsTable(Map map, {String header}) {
    if (map == null || map.isEmpty) return;
    logPrint('╔ $header ');
    map.forEach((key, value) => _printKV(key, value));
    _printLine('╚');
  }
}