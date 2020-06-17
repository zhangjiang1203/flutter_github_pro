import 'package:json_annotation/json_annotation.dart';
import "user.dart";
part 'eventcommits.g.dart';

@JsonSerializable()
class Eventcommits {
    Eventcommits();

    String sha;
    User author;
    String message;
    bool distinct;
    String url;
    
    factory Eventcommits.fromJson(Map<String,dynamic> json) => _$EventcommitsFromJson(json);
    Map<String, dynamic> toJson() => _$EventcommitsToJson(this);
}
