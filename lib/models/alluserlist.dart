import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'alluserlist.g.dart';

@JsonSerializable()
class Alluserlist {
    Alluserlist();

    num total_count;
    bool incomplete_results;
    List<User> items;
    
    factory Alluserlist.fromJson(Map<String,dynamic> json) => _$AlluserlistFromJson(json);
    Map<String, dynamic> toJson() => _$AlluserlistToJson(this);
}
