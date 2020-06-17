// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventcommits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eventcommits _$EventcommitsFromJson(Map<String, dynamic> json) {
  return Eventcommits()
    ..sha = json['sha'] as String
    ..author = json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>)
    ..message = json['message'] as String
    ..distinct = json['distinct'] as bool
    ..url = json['url'] as String;
}

Map<String, dynamic> _$EventcommitsToJson(Eventcommits instance) =>
    <String, dynamic>{
      'sha': instance.sha,
      'author': instance.author,
      'message': instance.message,
      'distinct': instance.distinct,
      'url': instance.url
    };
