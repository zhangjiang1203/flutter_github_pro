import 'package:fluttergithubpro/generated/json/base/json_convert_content.dart';
import 'package:fluttergithubpro/generated/json/base/json_filed.dart';

class NewsTopModelEntity with JsonConvert<NewsTopModelEntity> {
	String uniquekey;
	String title;
	String date;
	String category;
	@JSONField(name: "author_name")
	String authorName;
	String url;
	@JSONField(name: "thumbnail_pic_s")
	String thumbnailPicS;
}
