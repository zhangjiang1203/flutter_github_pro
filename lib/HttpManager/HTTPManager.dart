/*
* HTTPManager created by zj 
* on 2020/5/20 3:55 PM
* copyright on zhangjiang
*/

import 'dart:core';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_common_utils/http/http_error.dart';
import 'package:flutter_common_utils/log_util.dart';
import 'package:fluttergithubpro/generated/json/base/json_convert_content.dart';
import '../models/index.dart';


//设置成功回调
typedef HttpSuccessCallback<T> = void Function(dynamic data);
//失败回调
typedef HttpFailureCallback = void Function(HttpError error);


//数据解析
typedef T JsonParse<T>(dynamic data);

/* 使用示例
HTTPManager().get(url: "search/repositories", tag: "getitems",params: {
      'page':1,
      'page_size':20,
      'q':'language:Swift',
      'sort':'stars'
    },options: Options(extra: {"refresh":false,'noCache':false}),successCallback: (res){
      print(res);
    },failureCallback: (e){
      print(e.toString());
    });

    var response = await HTTPManager().getAsync<Map<String,dynamic>>(url: "search/repositories", tag: "getitems",params: {
      'page':1,
      'page_size':20,
      'q':'language:Swift',
      'sort':'stars'
    },options: Options(extra: {"refresh":false,'noCache':false}));
    print(response);

    /// extra中可以设置context数据，在请求错误或者失败的情况下弹出错误信息

    //登录成功之后更新公共头，此后所有的请求都会带上用户信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    //清空所有缓存
    Global.netCache.cache.clear();
    //更新用户的token信息
    Global.profile.token = basic;

* */

class HTTPManager {
  ///设置cancelToken，可用于多个请求，当一个cancelToken取消时，所有使用该cancelToken的请求都会被取消
  ///一个页面对应一个cancelToken
  Map<String,CancelToken> _cancelTokens = Map<String,CancelToken>();

  ///设置默认的超时时间
  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  Dio _client;

  static final HTTPManager _httpManager = HTTPManager._internal();

  factory HTTPManager() => _httpManager;

  Dio get client => _client;
  //网络请求错误的时候跳转都指定界面或者弹出提示
//  BuildContext context;

  ///创建实例对象
  HTTPManager._internal(){
    if(_client == null){
      BaseOptions options = BaseOptions(
        receiveTimeout: RECEIVE_TIMEOUT,
        connectTimeout: CONNECT_TIMEOUT
      );
      _client = new Dio(options);
    }
  }

  ///初始化公共属性
  void init(
  { String baseUrl,
    int connectTimeout,
    int receiveTimeout,
    List<Interceptor> interceptors}){
    _client.options = _client.options.merge(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout
    );
    if(interceptors != null && interceptors.isNotEmpty){
      _client.interceptors..addAll(interceptors);
    }
  }

  ///同步回调的get方法
  void get({
    @required String url,
    @required String tag,
    Map<String,dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback
  }) async{
    _request(
        url: url,
        tag: tag,
        method: 'GET',
        params: params,
        options: options,
        successCallback: successCallback,
        failureCallback: failureCallback
    );
  }

  ///同步回调的post方法
  void post({
    @required String url,
    @required String tag,
    data,
    Map<String,dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback
  }) async{
    _request(
        url: url,
        tag: tag,
        data: data,
        method: 'POST',
        params: params,
        options: options,
        successCallback: successCallback,
        failureCallback: failureCallback
    );
  }

  /// 同步上传upload方法
  void upload({
    @required String url,
    @required String tag,
    FormData data,
    Map<String,dynamic> params,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
    ProgressCallback onSendProgress,
  }) async{
    _request(
        url: url,
        tag: tag,
        method: 'POST',
        data: data,
        params: params,
        options: options,
        successCallback: successCallback,
        failureCallback: failureCallback,
        onSendProgress: onSendProgress
    );
  }

  ///统一网络请求（同步回调的方式）
  ///
  ///[url] 网络请求地址不包含域名
  ///[tag] 请求统一标识，用于取消网络请求
  ///[method] 请求方法
  ///[data] post请求data
  ///[params] 请求参数
  ///[options] 请求配置
  ///[successCallback] 成功的回调
  ///[failureCallback] 失败的回调
  ///[progressCallback] 进度回调
  void _request({
    @required String url,
    @required String tag,
    String method = 'GET',
    data,
    Map<String,dynamic> params,
    Options options ,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
    ProgressCallback onSendProgress,
  }) async {

    //检查网络
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none){
      if(failureCallback != null){
        failureCallback(HttpError(HttpError.NETWORK_ERROR,'网络异常，请稍后再试'));
      }
      LogUtil.v("网络异常，请稍后再试");
      return;
    }
    //设置默认值
    params = params ?? {};
    options ??= options == null
        ? Options(method: method, receiveTimeout: onSendProgress == null ? RECEIVE_TIMEOUT : 0)
        : options.merge(receiveTimeout: onSendProgress == null ? RECEIVE_TIMEOUT : 0);

    url = _restfulUrl(url, params);
    print("开始请求===");
    try{
      CancelToken cancelToken;
      if(tag != null){
        cancelToken = _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }

      //请求网络
      Response<Map<String,dynamic>> response = await _client.request(
          url,
          queryParameters: params,
          data: data,
          options: options,
          onSendProgress: onSendProgress,
          cancelToken: cancelToken,
      );
      String statusCode = response.data["flag"];
      if (statusCode == '1'){
        if(successCallback != null){
          successCallback(response.data["data"]);
        }
      }else{
        String errorDesc = response.data["message"];
        if(failureCallback != null){
          print("开始请求===失败1111");
          failureCallback(HttpError(statusCode,errorDesc));
        }
      }
    }on DioError catch(e,s){
      LogUtil.v("请求出错:$e\n$s");
      if(failureCallback != null && e.type != DioErrorType.CANCEL){
        failureCallback(HttpError.dioError(e));
      }
    }catch( e, s){
      LogUtil.v("未知异常出错:$e\n$s");
      if(failureCallback != null && e.type != DioErrorType.CANCEL){
        failureCallback(HttpError(HttpError.UNKNOWN,'网络异常，请稍后重试11'));
      }
    }
  }

  ///异步Future的get方法
  Future<T> getAsync<T>({
    @required String url,
    @required String tag,
    Map<String,dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
  }) async{
    return _requestAsync(
        url: url,
        tag: tag,
        method: "GET",
        params: params,
        options: options,
        jsonParse: jsonParse
    );
  }
  ///异步Future的post方法
  Future<T> postAsync<T>({
    @required String url,
    @required String tag,
    data,
    Map<String,dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
  }) async{
    return _requestAsync(
        url: url,
        tag: tag,
        data: data,
        method: "POST",
        params: params,
        options: options,
        jsonParse: jsonParse
    );
  }

  ///异步Future的upload方法
  Future<T> uploadAsync<T>({
    @required String url,
    @required String tag,
    FormData data,
    ProgressCallback onSendProgress,
    Map<String,dynamic> params,
    Options options,
    JsonParse<T> jsonParse,
  }) async{
    return _requestAsync(
        url: url,
        tag: tag,
        data: data,
        method: "POST",
        params: params,
        options: options,
        onSendProgress: onSendProgress,
        jsonParse: jsonParse
    );
  }


  ///异步Future的方法
  ///
  ///[url] 网络请求地址不包含域名
  ///[tag] 请求统一标识，用于取消网络请求
  ///[method] 请求方法
  ///[data] post请求data
  ///[params] 请求参数
  ///[options] 请求配置
  ///[jsonParse] json解析
  Future<T> _requestAsync<T>({
    @required String url,
    @required String tag,
    String method = 'GET',
    data,
    Map<String,dynamic> params,
    Options options,
    ProgressCallback onSendProgress,
    JsonParse<T> jsonParse,
  }) async{
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){
      LogUtil.v("请求网络异常，请稍后重试");
      throw (HttpError(HttpError.NETWORK_ERROR,"网络异常，请稍后再试"));
    }
    params = params ?? {};
    options = options ?? Options(method: method);
    options ??= options == null
        ? Options(method: method, receiveTimeout: onSendProgress == null ? RECEIVE_TIMEOUT : 0)
        : options.merge(receiveTimeout: onSendProgress == null ? RECEIVE_TIMEOUT : 0);

    url = _restfulUrl(url, params);
    try{
      CancelToken cancelToken;
      if(tag != null){
        cancelToken = _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response<Map<String,dynamic>> response = await _client.request(
        url,
        queryParameters: params,
        options: options,
        cancelToken: cancelToken,
        data: data,
        onSendProgress: onSendProgress,
      );
      if (jsonParse != null){
        return jsonParse(response.data);
      }else{
        Map<String,dynamic> tempMap = response.data;
//        print("网络返回数据===${tempMap.keys}");
        if(tempMap.containsKey('items')){
          List listRepo = tempMap['items'];
          T items = JsonConvert.fromJsonAsT<T>(listRepo);
          return items;
        }else if (tempMap.containsKey('error_code') && tempMap.containsKey('result')){
          var datasMap = tempMap['result'];
          if(datasMap is Map){
            List showData = datasMap['data'];
            T items = JsonConvert.fromJsonAsT<T>(showData);
            return items;
          }else if(datasMap is List){
//            print(datasMap);
            T items = JsonConvert.fromJsonAsT<T>(datasMap);
            return items;
          }
          return response.data as T;
        }
        return response.data as T;
      }
    } on DioError catch(e,s) {
      LogUtil.v("请求出错:$e\n$s");
      print("请求出错:$e\n$s");
      throw (HttpError.dioError(e));
    } catch (e,s){
      LogUtil.v("未知异常错误:$e\n$s");
      print("未知异常错误:$e\n$s");
      throw (HttpError(HttpError.UNKNOWN,'网络异常，请稍后再试11'));
    }
  }


  ///同步回调下载文件方法
  void download({
    @required String url,
    @required String savePath,
    @required String tag,
    ProgressCallback onReceiveProgress,
    Map<String,dynamic> params,
    data,
    Options options,
    HttpSuccessCallback successCallback,
    HttpFailureCallback failureCallback,
  }) async{
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.none){
    LogUtil.v("请求网络异常，请稍后重试");
    throw (HttpError(HttpError.NETWORK_ERROR,"网络异常，请稍后再试"));
    }
    params = params ?? {};
    ////0代表不设置超时
    int receiveTimeout = 0;
    options ??= options == null
        ? Options(receiveTimeout: receiveTimeout)
        : options.merge(receiveTimeout: receiveTimeout);

    url = _restfulUrl(url, params);

    try{
      CancelToken cancelToken;
      if(tag != null){
        cancelToken = _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      Response response = await _client.download(
        url,
        savePath,
        queryParameters: params,
        options: options,
        data: data,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken
      );
      if(successCallback != null){
        successCallback(response.data);
      }
    } on DioError catch(e,s){
      LogUtil.v("请求出错:$e\n$s");
      if(failureCallback != null){
        failureCallback(HttpError.dioError(e));
      }
    }catch(e,s){
      LogUtil.v("未知异常错误:$e\n$s");
      if(failureCallback != null){
        failureCallback(HttpError(HttpError.UNKNOWN,"网络异常，请稍后重试"));
      }
    }
  }

  ///同步回调下载文件方法
  Future<Response> downloadAsync({
    @required String url,
    @required String savePath,
    @required String tag,
    ProgressCallback onReceiveProgress,
    Map<String,dynamic> params,
    data,
    Options options,
  }) async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      LogUtil.v("请求网络异常，请稍后重试");
      throw (HttpError(HttpError.NETWORK_ERROR, "网络异常，请稍后再试"));
    }
    params = params ?? {};
    ////0代表不设置超时
    int receiveTimeout = 0;
    options ??= options == null
        ? Options(receiveTimeout: receiveTimeout)
        : options.merge(receiveTimeout: receiveTimeout);
    url = _restfulUrl(url, params);
    try {
      CancelToken cancelToken;
      if (tag != null) {
        cancelToken =
        _cancelTokens[tag] == null ? CancelToken() : _cancelTokens[tag];
        _cancelTokens[tag] = cancelToken;
      }
      return _client.download(
          url,
          savePath,
          queryParameters: params,
          options: options,
          data: data,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken
      );
    } on DioError catch (e, s) {
      LogUtil.v("请求出错:$e\n$s");
      throw HttpError.dioError(e);
    } catch (e, s) {
      LogUtil.v("未知异常错误:$e\n$s");
      throw HttpError(HttpError.UNKNOWN, "网络异常，请稍后重试");
    }
  }


  ///取消网络请求
  void cancel(String tag){
    if(_cancelTokens.containsKey(tag)){
      if(!_cancelTokens[tag].isCancelled){
        _cancelTokens[tag].cancel();
      }
      _cancelTokens.remove(tag);
    }
  }

  /// restful处理
  String _restfulUrl(String url,Map<String,dynamic>params){
    //restful请求处理
    params.forEach((key, value) {
      if(url.indexOf(key) != -1){
        url = url.replaceAll(":$key", value.toString());
      }
    });
    return url;
  }

}