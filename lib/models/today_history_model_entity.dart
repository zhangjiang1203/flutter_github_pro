import 'package:fluttergithubpro/generated/json/base/json_convert_content.dart';
import 'package:fluttergithubpro/generated/json/base/json_filed.dart';

class TodayHistoryModelEntity with JsonConvert<TodayHistoryModelEntity> {
	String day;
	String date;
	String title;
	@JSONField(name: "e_id")
	String eId;
}
