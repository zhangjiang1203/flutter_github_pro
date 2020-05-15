/*
* CacheObject created by zj 
* on 2020/5/7 3:34 PM
* copyright on zhangjiang
*/

import 'package:dio/dio.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'dart:collection';
import 'ZJLogTool.dart';

/*
dio包的option.extra是专门用于扩展请求参数的
refresh	bool	如果为true，则本次请求不使用缓存，但新的请求结果依然会被缓存
noCache	bool	本次请求禁用缓存，请求结果也不会被缓存。
*/
class CacheObject{
  CacheObject(this.response):
        assert(response != null),
        timeStamp = DateTime.now().millisecondsSinceEpoch;

  Response response;
  int timeStamp;

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return response.hashCode == other.hashCode;
  }

  //请求的url作为缓存的key
  int get hashCode => response.realUri.hashCode;
}

//继承interceptor
class NetCache extends Interceptor {
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
    print('''请求方式==${options.method}\n请求的url===${options.uri} \n请求参数===${options.queryParameters.toString()}
        ''');
    return options;
    //不需要缓存直接返回
//    if(!Global.profile.cache.enable) return options;
//
//    // refresh 是否是下拉刷新，是的话直接删除之前的缓存信息
//    bool refresh = options.extra['refresh'] == true;
//    if (refresh){
//      if(options.extra['list'] == true){
//        //若是list，则只要url中包含当前path的缓存全部删除
//        cache.removeWhere((key,v)=>key.contains(options.path));
//      }else{
//        //不是列表只删除uri相同的缓存
//        cache.remove(options.uri.toString());
//      }
//      return options;
//    }
//
//    if(options.extra['noCache'] != true && options.method.toLowerCase() == 'get'){
//      String key = options.extra['cacheKey'] ?? options.uri.toString();
//      var ob = cache[key];
//      if(ob != null){
//        //缓存没有过期，返回缓存内容
//        if((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) /1000 < Global.profile.cache.maxAge){
//          return cache[key].response;
//        }else{
//          //过期直接删除，重新请求
//          cache.remove(key);
//        }
//      }
//    }
  }

  @override
  // ignore: missing_return
  Future onResponse(Response response) {
//    if(Global.profile.cache.enable){
//      RequestOptions options = response.request;
//      if(options.extra["noCache"] != true && options.method.toLowerCase() == 'get'){
//        //如果缓存数量超过最大值，移除最早的一条记录
//        if(cache.length >= Global.profile.cache.maxCount){
//          cache.remove(cache[cache.keys.first]);
//        }
//        String key = options.extra["cacheKey"] ?? options.uri.toString();
//        cache[key] = CacheObject(response);
//      }
//    }
  }

}