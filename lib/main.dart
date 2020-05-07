import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'common/ZJColorsTool.dart';
import 'common/Translations.dart';
import 'common/LocaleTool.dart';
import 'routes/home_pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Color _themeColor;
  ///app内部修改语言
  SpecificLocalizationDelete _localizationDelete;

  void _onLocalChanged(Locale locale) {
    setState(() {
      _localizationDelete = new SpecificLocalizationDelete(locale);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localTool.getCurrentUserLanguage().then((e){
      print("当前语言==$e");
      _onLocalChanged(Locale(e,""));
    });

    ///初始化本地local
    _localizationDelete = new SpecificLocalizationDelete(null);
    /// 本地语言发生改变修改 app语言
    localTool.onLocaleChangeed = _onLocalChanged;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "我就是我",
      theme: ThemeData(
        primaryColor: ZJColor.StringColor("ff344223"),
      ),
      ///多语言设置
      onGenerateTitle: (context) {
        return Translations.of(context).text("home_title");
      },
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: localTool.supportLocales(),
      localeResolutionCallback: (deviceLocal, supportedLocales) {
        ///当前的系统语言，和支持的语言
        return deviceLocal;
      },

      ///多语言支持---end
      /// 初始化当前的路由，命名路由
      initialRoute: "/",
      /// 配置对应的路由信息
      routes: {
        "/": (context) => AppHomePage(),
      },
      /// 判断路由跳转的权限
      onGenerateRoute: (RouteSettings settings){
        return MaterialPageRoute(
          builder: (context){
            if(settings.name == ""){
              return null;
            }
            return null;
          }
        );
      },
    );
  }
}
