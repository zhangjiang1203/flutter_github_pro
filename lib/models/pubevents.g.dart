// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pubevents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pubevents _$PubeventsFromJson(Map<String, dynamic> json) {
  return Pubevents()
    ..id = json['id'] as String
    ..type = json['type'] as String
    ..actor = json['actor'] == null
        ? null
        : User.fromJson(json['actor'] as Map<String, dynamic>)
    ..repo = json['repo'] == null
        ? null
        : Repo.fromJson(json['repo'] as Map<String, dynamic>)
    ..payload = json['payload'] == null
        ? null
        : Playloadmodel.fromJson(json['payload'] as Map<String, dynamic>)
    ..public = json['public'] as bool
    ..created_at = json['created_at'] as String;
}

Map<String, dynamic> _$PubeventsToJson(Pubevents instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'payload': instance.payload,
      'public': instance.public,
      'created_at': instance.created_at
    };
