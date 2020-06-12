import 'package:json_annotation/json_annotation.dart';
import "repoitems.dart";
part 'allrepolist.g.dart';

@JsonSerializable()
class Allrepolist {
    Allrepolist();

    num total_count;
    bool incomplete_results;
    List<Repoitems> items;
    
    factory Allrepolist.fromJson(Map<String,dynamic> json) => _$AllrepolistFromJson(json);
    Map<String, dynamic> toJson() => _$AllrepolistToJson(this);
}
