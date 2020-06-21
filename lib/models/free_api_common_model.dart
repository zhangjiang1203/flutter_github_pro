/*
* free_api_common_model created by zhangjiang 
* on 2020/6/21 11:31 PM
* copyright on zhangjiang
*/

import 'JsonConvert.test.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CommonUseModel<T>
{
  CommonUseModel();

  String reason;
  dynamic result;
  String error_code;

  factory CommonUseModel.fromJson(Map<String,dynamic> json) => _$CommonUseModelFromJson<T>(json);
  Map<String, dynamic> toJson() => _$CommonUseModelToJson<T>(this);


}


CommonUseModel _$CommonUseModelFromJson<T>(Map<String, dynamic> json) {
  return CommonUseModel<T>()
    ..reason = json['reason'] as String
    ..result = json['result'] == null
        ? null
        : ((json['result'] is Map) ? JsonConvert.fromJson<T>(json['result']) : JsonConvert.fromJsonAsT<T>(json["result"]))
    ..error_code = json['error_code'] as String;
}

Map<String, dynamic> _$CommonUseModelToJson<T>(CommonUseModel instance) =>
    <String, dynamic>{
      'reason': instance.reason,
      'data': JsonConvert.toJson<T>(),
      'error_code': instance.error_code
    };