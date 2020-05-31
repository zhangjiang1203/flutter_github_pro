import 'package:fluttergithubpro/generated/json/base/json_convert_content.dart';
import 'package:fluttergithubpro/generated/json/base/json_filed.dart';

class TodayOilPriceModelEntity with JsonConvert<TodayOilPriceModelEntity> {
	String city;
	@JSONField(name: "92h")
	String oil_92h;
	@JSONField(name: "95h")
	String oil_95h;
	@JSONField(name: "98h")
	String oil_98h;
	@JSONField(name: "0h")
	String oil_0h;
}
