// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trenddeveloperlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trenddeveloperlist _$TrenddeveloperlistFromJson(Map<String, dynamic> json) {
  return Trenddeveloperlist()
    ..username = json['username'] as String
    ..name = json['name'] as String
    ..url = json['url'] as String
    ..sponsorUrl = json['sponsorUrl'] as String
    ..avatar = json['avatar'] as String
    ..repo = json['repo'] as Map<String, dynamic>;
}

Map<String, dynamic> _$TrenddeveloperlistToJson(Trenddeveloperlist instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'url': instance.url,
      'sponsorUrl': instance.sponsorUrl,
      'avatar': instance.avatar,
      'repo': instance.repo
    };
