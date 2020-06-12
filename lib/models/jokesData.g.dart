// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jokesData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JokesData _$JokesDataFromJson(Map<String, dynamic> json) {
  return JokesData()
    ..content = json['content'] as String
    ..hashId = json['hashId'] as String
    ..unixtime = json['unixtime'] as num
    ..updatetime = json['updatetime'] as String;
}

Map<String, dynamic> _$JokesDataToJson(JokesData instance) => <String, dynamic>{
      'content': instance.content,
      'hashId': instance.hashId,
      'unixtime': instance.unixtime,
      'updatetime': instance.updatetime
    };
