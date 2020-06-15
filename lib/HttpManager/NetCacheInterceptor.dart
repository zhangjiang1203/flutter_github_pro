/*
* LogInterceptor created by zj 
* on 2020/5/21 3:06 PM
* copyright on zhangjiang
*/
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:collection';
import '../common/index.dart';
import 'CommentUse.dart';

//继承interceptor
class NetCacheInterceptor extends Interceptor {
  //为了保证迭代器顺序和对象插入时间一致，顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String,CacheObject>();

  @override
  Future onError(DioError err) async{
    // TODO: implement onError
    // 错误状态不存储
    return super.onError(err);
  }

  @override
  Future onRequest(RequestOptions options) async {
    // TODO: implement onRequest
    zjPrint('''请求方式==${options.method}\n请求的url===${options.uri} \n请求参数===${options.queryParameters.toString()}
        ''',StackTrace.current);
    //不需要缓存直接返回
    if(!Global.profile.cache.enable) return options;
    // refresh 是否是下拉刷新，是的话直接删除之前的缓存信息
    bool refresh = options.extra['refresh'] == true;
    if (refresh){
      if(options.extra['list'] == true){
        //若是list，则只要url中包含当前path的缓存全部删除
        cache.removeWhere((key,v)=>key.contains(options.path));
      }else{
        //不是列表只删除uri相同的缓存
        cache.remove(options.uri.toString());
      }
      return options;
    }

    if(options.extra['noCache'] != true && options.method.toLowerCase() == 'get'){
      String key = options.extra['cacheKey'] ?? options.uri.toString();
      var ob = cache[key];
      if(ob != null){
        //缓存没有过期，返回缓存内容
        if((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) /1000 < Global.profile.cache.maxAge){
          return cache[key].response;
        }else{
          //过期直接删除，重新请求
          cache.remove(key);
        }
      }
    }
  }

  @override
  Future onResponse(Response response) async{
    if(Global.profile.cache.enable){
      RequestOptions options = response.request;
      if(options.extra["noCache"] != true && options.method.toLowerCase() == 'get'){
        //如果缓存数量超过最大值，移除最早的一条记录
        if(cache.length >= Global.profile.cache.maxCount){
          cache.remove(cache[cache.keys.first]);
        }
        String key = options.extra["cacheKey"] ?? options.uri.toString();
        //保存对应的response
        cache[key] = CacheObject(response);
      }
    }
    return response;
  }
}


class HeaderInterceptor extends Interceptor {

  @override
  Future onRequest(RequestOptions options) async {
    if(Global.profile.user != null) {
      print("拼接header");
      String userName = Global.preferences.getString(CommentUse.loginName);
      String password = Global.preferences.getString(CommentUse.loginPassword);
      var temp = convert.base64Decode(password);
      password =
          convert.utf8.decode(temp).replaceFirst(CommentUse.base64Extra, "");
      String basic = "Basic" +
          base64.encode(utf8.encode('$userName:$password'));
      options.headers.addAll({"Authorization": basic});
    }

    return options;
  }

}