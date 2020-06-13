/*
* commandFile created by zhangjiang 
* on 2020/6/13 3:53 PM
* copyright on zhangjiang
*/
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
const TAG="\$";
const SRC="./jsons"; //JSON 目录
const DIST="lib/models/"; //输出model目录
//定义替换的内容
const getFromJson = "%{getFromJson}";
const modelToJson = "%{modelToJson}";
const singleJsonToModel = "%{singleJsonToModel}";
const listModel = "%{listModel}";

void walk() { //遍历JSON目录生成模板
  var src = new Directory(SRC);
  List<FileSystemEntity> list = src.listSync();
  File file;
  StringBuffer modelToJsonStr = new StringBuffer();
  StringBuffer jsonTomodelStr = new StringBuffer();
  StringBuffer signalModelStr = new StringBuffer();
  StringBuffer listModelStr = new StringBuffer();
  StringBuffer indexStr = new StringBuffer();
  list.forEach((f) {
    if (FileSystemEntity.isFileSync(f.path)) {
      file = new File(f.path);
      var paths = path.basename(f.path).split(".");
      String name = paths.first;
      String className = name[0].toUpperCase() + name.substring(1);
      if (paths.last.toLowerCase() != "json" || name.startsWith("_")) return;
      if (name.startsWith("_")) return;
      //设置jsonTomodel
      jsonTomodelStr.write('     case $className:\r\n');
      jsonTomodelStr.write("            return $className.fromJson(json) as T;\r\n");

      //设置modelToJson
      modelToJsonStr.write('     case $className:\r\n');
      modelToJsonStr.write("            return (data as $className).toJson();\r\n");

      //singleModel
      signalModelStr.write("     case '$className':\r\n");
      signalModelStr.write('            return $className.fromJson(json);\r\n');

      //listModel
      listModelStr.write("     case '$className':\r\n");
      listModelStr.write('            return List<$className>();\r\n');

      //添加索引,文件名不用大写
      indexStr.write("export '$name.dart' ; \r\n");
    }
  });
  var content = _getTemplateContent();
  content = content.replaceFirst("$getFromJson",jsonTomodelStr.toString());
  content = content.replaceFirst("$modelToJson",modelToJsonStr.toString());
  content = content.replaceFirst("$singleJsonToModel",signalModelStr.toString());
  content = content.replaceFirst("$listModel",listModelStr.toString());

  //将生成的模板输出
  new File("$DIST/index.dart").writeAsStringSync(indexStr.toString());
  new File("$DIST/JsonConvert.test.dart").writeAsStringSync(content);
}


String _getTemplateContent(){
  return '''
  
import '../models/index.dart';
class ConvertTemplate<T> {
  T fromJson(Map<String, dynamic> json) {
    return _getFromJson<T>(runtimeType, this, json);
  }

  Map<String, dynamic> toJson() {
    return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {
    $getFromJson
  }
    return data as T;
  }

  static _getToJson<T>(Type type,data) {
    switch (type) {
     $modelToJson
    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {
      $singleJsonToModel
    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {
      $listModel
    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}
  ''';
}

void main(){
  walk();
}