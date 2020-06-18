import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
    User();

    String login;
    String avatar_url;
    String type;
    String name;
    String company;
    String blog;
    String location;
    String email;
    bool hireable;
    String bio;
    num public_repos;
    num followers;
    num following;
    String created_at;
    String updated_at;
    num total_private_repos;
    num owned_private_repos;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}

//login": "pranavlathigara",
//"id": 6948067,
//"node_id": "MDQ6VXNlcjY5NDgwNjc=",
//"avatar_url": "https://avatars2.githubusercontent.com/u/6948067?v=4",
//"gravatar_id": "",
//"url": "https://api.github.com/users/pranavlathigara",
//"html_url": "https://github.com/pranavlathigara",
//"followers_url": "https://api.github.com/users/pranavlathigara/followers",
//"following_url": "https://api.github.com/users/pranavlathigara/following{/other_user}",
//"gists_url": "https://api.github.com/users/pranavlathigara/gists{/gist_id}",
//"starred_url": "https://api.github.com/users/pranavlathigara/starred{/owner}{/repo}",
//"subscriptions_url": "https://api.github.com/users/pranavlathigara/subscriptions",
//"organizations_url": "https://api.github.com/users/pranavlathigara/orgs",
//"repos_url": "https://api.github.com/users/pranavlathigara/repos",
//"events_url": "https://api.github.com/users/pranavlathigara/events{/privacy}",
//"received_events_url": "https://api.github.com/users/pranavlathigara/received_events",
//"type": "User",
//"site_admin": false
