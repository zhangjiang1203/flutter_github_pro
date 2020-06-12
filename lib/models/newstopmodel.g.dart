// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newstopmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Newstopmodel _$NewstopmodelFromJson(Map<String, dynamic> json) {
  return Newstopmodel()
    ..uniquekey = json['uniquekey'] as String
    ..title = json['title'] as String
    ..date = json['date'] as String
    ..category = json['category'] as String
    ..author_name = json['author_name'] as String
    ..url = json['url'] as String
    ..thumbnail_pic_s = json['thumbnail_pic_s'] as String
    ..thumbnail_pic_s02 = json['thumbnail_pic_s02'] as String
    ..thumbnail_pic_s03 = json['thumbnail_pic_s03'] as String;
}

Map<String, dynamic> _$NewstopmodelToJson(Newstopmodel instance) =>
    <String, dynamic>{
      'uniquekey': instance.uniquekey,
      'title': instance.title,
      'date': instance.date,
      'category': instance.category,
      'author_name': instance.author_name,
      'url': instance.url,
      'thumbnail_pic_s': instance.thumbnail_pic_s,
      'thumbnail_pic_s02': instance.thumbnail_pic_s02,
      'thumbnail_pic_s03': instance.thumbnail_pic_s03
    };
