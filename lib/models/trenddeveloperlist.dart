import 'package:json_annotation/json_annotation.dart';

part 'trenddeveloperlist.g.dart';

@JsonSerializable()
class Trenddeveloperlist {
    Trenddeveloperlist();

    String username;
    String name;
    String url;
    String sponsorUrl;
    String avatar;
    Map<String,dynamic> repo;
    
    factory Trenddeveloperlist.fromJson(Map<String,dynamic> json) => _$TrenddeveloperlistFromJson(json);
    Map<String, dynamic> toJson() => _$TrenddeveloperlistToJson(this);
}
