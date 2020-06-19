// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trendrepolist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trendrepolist _$TrendrepolistFromJson(Map<String, dynamic> json) {
  return Trendrepolist()
    ..author = json['author'] as String
    ..name = json['name'] as String
    ..avatar = json['avatar'] as String
    ..url = json['url'] as String
    ..description = json['description'] as String
    ..language = json['language'] as String
    ..languageColor = json['languageColor'] as String
    ..stars = json['stars'] as num
    ..forks = json['forks'] as num
    ..currentPeriodStars = json['currentPeriodStars'] as num
    ..builtBy = (json['builtBy'] as List)
        ?.map((e) => e == null
            ? null
            : Buildercontribute.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$TrendrepolistToJson(Trendrepolist instance) =>
    <String, dynamic>{
      'author': instance.author,
      'name': instance.name,
      'avatar': instance.avatar,
      'url': instance.url,
      'description': instance.description,
      'language': instance.language,
      'languageColor': instance.languageColor,
      'stars': instance.stars,
      'forks': instance.forks,
      'currentPeriodStars': instance.currentPeriodStars,
      'builtBy': instance.builtBy
    };
