import 'package:fluttergithubpro/models/today_oil_price_model_entity.dart';

todayOilPriceModelEntityFromJson(TodayOilPriceModelEntity data, Map<String, dynamic> json) {
	if (json['city'] != null) {
		data.city = json['city']?.toString();
	}
	if (json['92h'] != null) {
		data.oil_92h = json['92h']?.toString();
	}
	if (json['95h'] != null) {
		data.oil_95h = json['95h']?.toString();
	}
	if (json['98h'] != null) {
		data.oil_98h = json['98h']?.toString();
	}
	if (json['0h'] != null) {
		data.oil_0h = json['0h']?.toString();
	}
	return data;
}

Map<String, dynamic> todayOilPriceModelEntityToJson(TodayOilPriceModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['city'] = entity.city;
	data['92h'] = entity.oil_92h;
	data['95h'] = entity.oil_95h;
	data['98h'] = entity.oil_98h;
	data['0h'] = entity.oil_0h;
	return data;
}