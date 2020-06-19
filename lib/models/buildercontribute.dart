import 'package:json_annotation/json_annotation.dart';

part 'buildercontribute.g.dart';

@JsonSerializable()
class Buildercontribute {
    Buildercontribute();

    String username;
    String href;
    String avatar;
    
    factory Buildercontribute.fromJson(Map<String,dynamic> json) => _$BuildercontributeFromJson(json);
    Map<String, dynamic> toJson() => _$BuildercontributeToJson(this);
}
