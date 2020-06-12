// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todayInHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayInHistory _$TodayInHistoryFromJson(Map<String, dynamic> json) {
  return TodayInHistory()
    ..title = json['title'] as String
    ..pic = json['pic'] as String
    ..year = json['year'] as num
    ..month = json['month'] as num
    ..day = json['day'] as num
    ..des = json['des'] as String
    ..lunar = json['lunar'] as String;
}

Map<String, dynamic> _$TodayInHistoryToJson(TodayInHistory instance) =>
    <String, dynamic>{
      'title': instance.title,
      'pic': instance.pic,
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'des': instance.des,
      'lunar': instance.lunar
    };
