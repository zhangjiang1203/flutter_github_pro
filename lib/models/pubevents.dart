import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "repo.dart";
import "playloadmodel.dart";
part 'pubevents.g.dart';

@JsonSerializable()
class Pubevents {
    Pubevents();

    String id;
    String type;
    User actor;
    Repo repo;
    Playloadmodel payload;
    bool public;
    String created_at;
    
    factory Pubevents.fromJson(Map<String,dynamic> json) => _$PubeventsFromJson(json);
    Map<String, dynamic> toJson() => _$PubeventsToJson(this);
}
