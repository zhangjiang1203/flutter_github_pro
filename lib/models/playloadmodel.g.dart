// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playloadmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Playloadmodel _$PlayloadmodelFromJson(Map<String, dynamic> json) {
  return Playloadmodel()
    ..push_id = json['push_id'] as num
    ..size = json['size'] as num
    ..distinct_size = json['distinct_size'] as num
    ..ref = json['ref'] as String
    ..head = json['head'] as String
    ..before = json['before'] as String
    ..commits = (json['commits'] as List)
        ?.map((e) =>
            e == null ? null : Eventcommits.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..forkee = json['forkee'] == null
        ? null
        : Repo.fromJson(json['forkee'] as Map<String, dynamic>)
    ..ref_type = json['ref_type'] as String
    ..action = json['action'] as String;
}

Map<String, dynamic> _$PlayloadmodelToJson(Playloadmodel instance) =>
    <String, dynamic>{
      'push_id': instance.push_id,
      'size': instance.size,
      'distinct_size': instance.distinct_size,
      'ref': instance.ref,
      'head': instance.head,
      'before': instance.before,
      'commits': instance.commits,
      'forkee': instance.forkee,
      'ref_type': instance.ref_type,
      'action': instance.action
    };
