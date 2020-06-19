import 'package:json_annotation/json_annotation.dart';
import "buildercontribute.dart";
part 'trendrepolist.g.dart';

@JsonSerializable()
class Trendrepolist {
    Trendrepolist();

    String author;
    String name;
    String avatar;
    String url;
    String description;
    String language;
    String languageColor;
    num stars;
    num forks;
    num currentPeriodStars;
    List<Buildercontribute> builtBy;
    
    factory Trendrepolist.fromJson(Map<String,dynamic> json) => _$TrendrepolistFromJson(json);
    Map<String, dynamic> toJson() => _$TrendrepolistToJson(this);
}
