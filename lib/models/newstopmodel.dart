import 'package:json_annotation/json_annotation.dart';

part 'newstopmodel.g.dart';

@JsonSerializable()
class Newstopmodel {
    Newstopmodel();

    String uniquekey;
    String title;
    String date;
    String category;
    String author_name;
    String url;
    String thumbnail_pic_s;
    String thumbnail_pic_s02;
    String thumbnail_pic_s03;
    
    factory Newstopmodel.fromJson(Map<String,dynamic> json) => _$NewstopmodelFromJson(json);
    Map<String, dynamic> toJson() => _$NewstopmodelToJson(this);
}
