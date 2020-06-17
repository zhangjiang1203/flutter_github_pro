import 'package:json_annotation/json_annotation.dart';

part 'eventactor.g.dart';

@JsonSerializable()
class Eventactor {
    Eventactor();

    num id;
    String login;
    String display_login;
    String gravatar_id;
    String url;
    String avatar_url;
    
    factory Eventactor.fromJson(Map<String,dynamic> json) => _$EventactorFromJson(json);
    Map<String, dynamic> toJson() => _$EventactorToJson(this);
}
