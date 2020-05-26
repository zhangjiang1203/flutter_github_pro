import 'package:fluttergithubpro/models/temp_data_model_entity.dart';

tempDataModelEntityFromJson(TempDataModelEntity data, Map<String, dynamic> json) {
	if (json['stat'] != null) {
		data.stat = json['stat']?.toString();
	}
	if (json['data'] != null) {
		data.data = new List<TempDataModelData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new TempDataModelData().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> tempDataModelEntityToJson(TempDataModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['stat'] = entity.stat;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	return data;
}

tempDataModelDataFromJson(TempDataModelData data, Map<String, dynamic> json) {
	if (json['uniquekey'] != null) {
		data.uniquekey = json['uniquekey']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['date'] != null) {
		data.date = json['date']?.toString();
	}
	if (json['category'] != null) {
		data.category = json['category']?.toString();
	}
	if (json['author_name'] != null) {
		data.authorName = json['author_name']?.toString();
	}
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	if (json['thumbnail_pic_s'] != null) {
		data.thumbnailPicS = json['thumbnail_pic_s']?.toString();
	}
	return data;
}

Map<String, dynamic> tempDataModelDataToJson(TempDataModelData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['uniquekey'] = entity.uniquekey;
	data['title'] = entity.title;
	data['date'] = entity.date;
	data['category'] = entity.category;
	data['author_name'] = entity.authorName;
	data['url'] = entity.url;
	data['thumbnail_pic_s'] = entity.thumbnailPicS;
	return data;
}