// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventactor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Eventactor _$EventactorFromJson(Map<String, dynamic> json) {
  return Eventactor()
    ..id = json['id'] as num
    ..login = json['login'] as String
    ..display_login = json['display_login'] as String
    ..gravatar_id = json['gravatar_id'] as String
    ..url = json['url'] as String
    ..avatar_url = json['avatar_url'] as String;
}

Map<String, dynamic> _$EventactorToJson(Eventactor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'display_login': instance.display_login,
      'gravatar_id': instance.gravatar_id,
      'url': instance.url,
      'avatar_url': instance.avatar_url
    };
