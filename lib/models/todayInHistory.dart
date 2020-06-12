import 'package:json_annotation/json_annotation.dart';

part 'todayInHistory.g.dart';

@JsonSerializable()
class TodayInHistory {
    TodayInHistory();

    String title;
    String pic;
    num year;
    num month;
    num day;
    String des;
    String lunar;
    
    factory TodayInHistory.fromJson(Map<String,dynamic> json) => _$TodayInHistoryFromJson(json);
    Map<String, dynamic> toJson() => _$TodayInHistoryToJson(this);
}
