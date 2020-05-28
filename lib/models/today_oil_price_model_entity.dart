import 'package:fluttergithubpro/generated/json/base/json_convert_content.dart';
import 'package:fluttergithubpro/generated/json/base/json_filed.dart';

class TodayOilPriceModelEntity with JsonConvert<TodayOilPriceModelEntity> {
	String city;
	@JSONField(name: "92h")
	String x92h;
	@JSONField(name: "95h")
	String x95h;
	@JSONField(name: "98h")
	String x98h;
	@JSONField(name: "0h")
	String x0h;
}
