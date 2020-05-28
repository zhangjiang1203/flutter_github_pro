import 'package:fluttergithubpro/models/today_history_model_entity.dart';

todayHistoryModelEntityFromJson(TodayHistoryModelEntity data, Map<String, dynamic> json) {
	if (json['day'] != null) {
		data.day = json['day']?.toString();
	}
	if (json['date'] != null) {
		data.date = json['date']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['e_id'] != null) {
		data.eId = json['e_id']?.toString();
	}
	return data;
}

Map<String, dynamic> todayHistoryModelEntityToJson(TodayHistoryModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['day'] = entity.day;
	data['date'] = entity.date;
	data['title'] = entity.title;
	data['e_id'] = entity.eId;
	return data;
}