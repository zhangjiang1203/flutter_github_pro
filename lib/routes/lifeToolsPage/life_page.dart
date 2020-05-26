/*
* LifePage created by zj 
* on 2020/5/22 6:34 PM
* copyright on zhangjiang
*/

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/routes/lifeToolsPage/banner_detail_page.dart';
import 'package:fluttergithubpro/routes/lifeToolsPage/news_top_page.dart';
import 'package:provider/provider.dart';

class LifePage extends StatefulWidget {
  LifePage({Key key}) : super(key: key);

  @override
  _LifePage createState() => _LifePage();
}

class _LifePage extends State<LifePage> {
  var lifeDataDict = {
    'top_news':'toutiao.png',
    'constellation':'jinriyunshi.png',
    'today_oil':'jiayouzhan.png',
    'cheng_yu_zi_dian':'chengyucidian.png',
    'jokes':'xiaohuadaquan.png',
    'history_today':'yiguoqu.png',
    'car_test':'jiazhao.png',
    'weather_pro':'weather.png',};

  var bannerData = ["http://images.uiiiuiii.com/wp-content/uploads/2018/05/i-bn20180509-2-01.jpg",
    "http://images.uiiiuiii.com/wp-content/uploads/2018/03/i-bn20180305-2-01.jpg",
    "http://img.zcool.cn/community/01b3905ebebdb3a8012072005818c2.jpg@2o.jpg",
    "http://img.zcool.cn/community/01aac655fa25ea6ac7251df896e065.jpg",];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Provider.of<ThemeProvider>(context).theme,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.school),
                onPressed: ()=>{},
              )
            ],
            expandedHeight: 200,
            pinned: true, 
            flexibleSpace: FlexibleSpaceBar(
              title: Text(Translations.of(context).text('life_assist')),
              background: Swiper(
                indicator: RectangleSwiperIndicator(),
                reverse: true,
                children: bannerData.asMap().keys.map((e) => Hero(
                  tag: 'swiper_hero_action_$e',
                  child: GestureDetector(
                    onTap: (){
                      print('当前的tag==swiper_hero_action_$e');
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return BannerDetailPage(imageURL: bannerData[e],tag: 'swiper_hero_action_$e',);
                      }));
                    },
                    child: Image.network(bannerData[e],fit: BoxFit.fitHeight),
                  ),
                )).toList(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing:10.0,
              crossAxisSpacing:10,
              children: lifeDataDict.keys.map((e) => GestureDetector(
                onTap: (){
                  if ("top_news" == e){
                    Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      return NewsTopPage();
                    }));
                  }
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/${lifeDataDict[e]}',width: 50,fit: BoxFit.cover,),
                        Padding(padding: const EdgeInsets.only(top: 8),),
                        Text(Translations.of(context).text(e),style: TextStyle(color: ZJColor.StringColor('333333')),),
                      ],
                      )
                    ),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}