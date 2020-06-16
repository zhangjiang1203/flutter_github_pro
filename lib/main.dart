import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_tabbar_page.dart';
import 'package:fluttergithubpro/routes/MinePage/theme_change_route.dart';
import 'common/Translations.dart';
import 'common/LocaleTool.dart';

import 'common/Global.dart';
import 'package:provider/provider.dart';
import 'common/ProfileChangeNotifier.dart';

import 'routes/indexPage/home_pages.dart';
import 'routes/MinePage/change_local_route.dart';
import 'routes/Login/login_page.dart';
import 'routes/MinePage/get_battery_level.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


///初始化相关的配置之后再runapp
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Global.init();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Map<String,WidgetBuilder> _setUpWidgetRoutes(BuildContext context) {
    return {
      "/": (context) => BaseTabbarPage(),//AppHomePage(),
      "home_page":(context)=> AppHomePage(),
      "theme_change_route": (context) => ThemeChangeRoute(),
      "Change_local_route": (context)=> ChangeLocalRoute(),
      "Login_route":(context) => LoginRoute(),
      "get_battery_level":(context)=> GetBatteryLevel(),
      };
  }

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ChangeNotifierProvider.value(value: UserProvider()),
          ChangeNotifierProvider.value(value: ThemeProvider()),
          ChangeNotifierProvider.value(value: LocaleProvider()),
        ],
        child: Consumer2<ThemeProvider,LocaleProvider>(
          builder: (BuildContext context,themeProvider,localeProvider,Widget child){
            //初始化展示的loading
            Global.configLoading(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: themeProvider.theme,
                appBarTheme: AppBarTheme(elevation: 0),
                visualDensity: VisualDensity.adaptivePlatformDensity,
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
                if(localeProvider.getLocale() != null){
                  return localeProvider.getLocale();
                }else{
                  Locale locale;
                  //跟随系统语言
                  if(supportedLocales.contains(deviceLocal)){
                    locale = deviceLocal;
                  }else{
                    locale = Locale('en','US');
                  }
                  return locale;
                }
              },
              ///多语言支持---end
              /// 初始化当前的路由，命名路由
              initialRoute: Provider.of<UserProvider>(context).isLogin ?  "/" : "Login_route",
              /// 配置对应的路由信息
              routes: _setUpWidgetRoutes(context),
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
          },
        ),
      )
    );
  }
}
