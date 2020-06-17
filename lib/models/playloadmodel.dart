import 'package:json_annotation/json_annotation.dart';
import "eventcommits.dart";
import "repo.dart";
part 'playloadmodel.g.dart';

@JsonSerializable()
class Playloadmodel {
    Playloadmodel();

    num push_id;
    num size;
    num distinct_size;
    String ref;
    String head;
    String before;
    List<Eventcommits> commits;
    Repo forkee;
    String ref_type;
    String action;
    
    factory Playloadmodel.fromJson(Map<String,dynamic> json) => _$PlayloadmodelFromJson(json);
    Map<String, dynamic> toJson() => _$PlayloadmodelToJson(this);
}
