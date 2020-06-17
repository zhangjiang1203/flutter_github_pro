import 'package:json_annotation/json_annotation.dart';

part 'organization.g.dart';

@JsonSerializable()
class Organization {
    Organization();

    num id;
    String login;
    String gravatar_id;
    String url;
    String avatar_url;
    
    factory Organization.fromJson(Map<String,dynamic> json) => _$OrganizationFromJson(json);
    Map<String, dynamic> toJson() => _$OrganizationToJson(this);
}
