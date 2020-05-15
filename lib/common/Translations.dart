/*
* TranslationsLanauage created by zj 
* on 2020/4/24 2:55 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'LocaleTool.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'Global.dart';

/// Class for Translate
///
/// For example:
///
/// import 'package:workout/translations.dart';
///
/// ```dart
/// For TextField content
/// Translations.of(context).text("home_page_title");
/// ```
///
/// ```dart
/// For speak string
/// Note: Tts will speak english if currentLanguage[# Tts's parameter] can't support
///
/// Translations.of(context).speakText("home_page_title");
/// ```
///
/// "home_page_title" is the key for text value
///


class Translations {

  Translations(Locale locale){
    this.locale = locale;
    _localizedValues = null;
  }

  Locale locale;
  static Map<dynamic,dynamic> _localizedValues;

  //便利构造方法
  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context,Translations);
  }

  String text(String key){
    try{
      String value = _localizedValues[key];
      if(value == null || value.isEmpty){
        return key;
      }else{
        return value;
      }
    }catch (e){
      return key;
    }
  }

  static Future<Translations> load(Locale locale) async {
    Translations translationsLanguage = new Translations(locale);

    print("当前语言==="+locale.languageCode);
    String jsonContent = await rootBundle.loadString("assets/languages/i18n_${locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);
    return translationsLanguage;
  }

  get currentLanguage => locale.languageCode;

  //获取title
  get title => text("title");
  get loginName => text("login_name");
  get password  => text("password_text");
}

//遵循这两个代理
class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    localTool.languageCode = locale.languageCode;
    return localTool.supportLangs.contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) {
    //加载配置文件中的设置
    if(Global.profile.locale == null){
      return Translations.load(Locale('en',''));
    }
    return Translations.load(Locale(Global.profile.locale,''));
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) {
    return true;
  }
}


/// Delegate类的实现，每次选择一种新的语言时，强制初始化一个新的Translations类
class SpecificLocalizationDelete extends LocalizationsDelegate<Translations> {
  const SpecificLocalizationDelete(this.overriddenLocal);
  ///当前的语言
  final Locale overriddenLocal;
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return overriddenLocal != null;
  }

  @override
  Future<Translations> load(Locale locale) {
    // TODO: implement load
    return Translations.load(overriddenLocal);
  }

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) {
    // TODO: implement shouldReload
    return true;
  }
}
