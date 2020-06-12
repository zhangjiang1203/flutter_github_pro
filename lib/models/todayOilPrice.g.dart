// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todayOilPrice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodayOilPrice _$TodayOilPriceFromJson(Map<String, dynamic> json) {
  return TodayOilPrice()
    ..city = json['city'] as String
    ..oil_92h = json['oil_92h'] as String
    ..oil_95h = json['oil_95h'] as String
    ..oil_98h = json['oil_98h'] as String
    ..oil_0h = json['oil_0h'] as String;
}

Map<String, dynamic> _$TodayOilPriceToJson(TodayOilPrice instance) =>
    <String, dynamic>{
      'city': instance.city,
      'oil_92h': instance.oil_92h,
      'oil_95h': instance.oil_95h,
      'oil_98h': instance.oil_98h,
      'oil_0h': instance.oil_0h
    };
