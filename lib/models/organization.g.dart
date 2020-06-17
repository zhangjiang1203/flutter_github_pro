// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization()
    ..id = json['id'] as num
    ..login = json['login'] as String
    ..gravatar_id = json['gravatar_id'] as String
    ..url = json['url'] as String
    ..avatar_url = json['avatar_url'] as String;
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'gravatar_id': instance.gravatar_id,
      'url': instance.url,
      'avatar_url': instance.avatar_url
    };
