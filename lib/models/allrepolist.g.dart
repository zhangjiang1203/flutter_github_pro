// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allrepolist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Allrepolist _$AllrepolistFromJson(Map<String, dynamic> json) {
  return Allrepolist()
    ..total_count = json['total_count'] as num
    ..incomplete_results = json['incomplete_results'] as bool
    ..items = (json['items'] as List)
        ?.map((e) =>
            e == null ? null : Repoitems.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AllrepolistToJson(Allrepolist instance) =>
    <String, dynamic>{
      'total_count': instance.total_count,
      'incomplete_results': instance.incomplete_results,
      'items': instance.items
    };
