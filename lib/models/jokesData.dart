import 'package:json_annotation/json_annotation.dart';

part 'jokesData.g.dart';

@JsonSerializable()
class JokesData {
    JokesData();

    String content;
    String hashId;
    num unixtime;
    String updatetime;
    
    factory JokesData.fromJson(Map<String,dynamic> json) => _$JokesDataFromJson(json);
    Map<String, dynamic> toJson() => _$JokesDataToJson(this);
}
