import 'package:json_annotation/json_annotation.dart';

part 'todayOilPrice.g.dart';

@JsonSerializable()
class TodayOilPrice {
    TodayOilPrice();

    String city;
    String oil_92h;
    String oil_95h;
    String oil_98h;
    String oil_0h;
    
    factory TodayOilPrice.fromJson(Map<String,dynamic> json) => _$TodayOilPriceFromJson(json);
    Map<String, dynamic> toJson() => _$TodayOilPriceToJson(this);
}
