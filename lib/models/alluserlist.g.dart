// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alluserlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alluserlist _$AlluserlistFromJson(Map<String, dynamic> json) {
  return Alluserlist()
    ..total_count = json['total_count'] as num
    ..incomplete_results = json['incomplete_results'] as bool
    ..items = (json['items'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AlluserlistToJson(Alluserlist instance) =>
    <String, dynamic>{
      'total_count': instance.total_count,
      'incomplete_results': instance.incomplete_results,
      'items': instance.items
    };
