import 'package:fluttergithubpro/models/jokes_data_model_entity.dart';

jokesDataModelEntityFromJson(JokesDataModelEntity data, Map<String, dynamic> json) {
	if (json['content'] != null) {
		data.content = json['content']?.toString();
	}
	if (json['hashId'] != null) {
		data.hashId = json['hashId']?.toString();
	}
	if (json['unixtime'] != null) {
		data.unixtime = json['unixtime']?.toInt();
	}
	if (json['updatetime'] != null) {
		data.updatetime = json['updatetime']?.toString();
	}
	return data;
}

Map<String, dynamic> jokesDataModelEntityToJson(JokesDataModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['content'] = entity.content;
	data['hashId'] = entity.hashId;
	data['unixtime'] = entity.unixtime;
	data['updatetime'] = entity.updatetime;
	return data;
}