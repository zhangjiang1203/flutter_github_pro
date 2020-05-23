/*
* LifePage created by zj 
* on 2020/5/22 6:34 PM
* copyright on zhangjiang
*/

import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/routes/lifeToolsPage/banner_detail_page.dart';

class LifePage extends StatefulWidget {
  LifePage({Key key}) : super(key: key);

  @override
  _LifePage createState() => _LifePage();
}

class _LifePage extends State<LifePage> {

  var dataList = ['1','2','3','4','5','6','7','8','11'];
  var bannerData = ["http://images.uiiiuiii.com/wp-content/uploads/2018/05/i-bn20180509-2-01.jpg",
    "http://images.uiiiuiii.com/wp-content/uploads/2018/03/i-bn20180305-2-01.jpg",
    "http://img.zcool.cn/community/01b3905ebebdb3a8012072005818c2.jpg@2o.jpg",
    "http://img.zcool.cn/community/01aac655fa25ea6ac7251df896e065.jpg",];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.school),
                onPressed: ()=>{},
              )
            ],
            expandedHeight: 200,
            pinned: true, 
            flexibleSpace: FlexibleSpaceBar(
              title: Text('生活助手'),
              background: Swiper(
                reverse: true,
                children: bannerData.map((e) => Hero(
                  tag: "swiper_hero_action",
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (_){
                        return BannerDetailPage(imageURL: e,tag: 'swiper_hero_action',);
                      }));
                    },
                    child: Image.network(e,fit: BoxFit.fitHeight),
                  ),
                )).toList(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing:10.0,
              crossAxisSpacing:10,
              children: dataList.map((e) => Container(
                color: ZJColor.randomColor(),
                alignment: Alignment.center,
                child: Text(e,style: TextStyle(color: Colors.white),),
              )).toList(),
            ),
          ),

        ],
      ),
    );
  }
}