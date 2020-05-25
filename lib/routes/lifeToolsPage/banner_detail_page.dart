/*
* banner_detail_page created by zj 
* on 2020/5/23 5:47 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';

class BannerDetailPage extends StatefulWidget {
  BannerDetailPage(
      {
        Key key,
        @required this.imageURL,
        @required this.tag
      })
      :assert(imageURL != null),
        assert(tag != null),
        super(key: key);

  String imageURL;
  String tag;

  @override
  _BannerDetailPageState createState() => _BannerDetailPageState();
}

class _BannerDetailPageState extends State<BannerDetailPage> {

  @override
  Widget build(BuildContext context) {
    zjPrint('当前tag===${widget.tag}', StackTrace.current);
    return Scaffold(
        appBar: AppBar(
          title: Text("banner_detail_page"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: widget.tag,
                child: Image.network(widget.imageURL,fit: BoxFit.fitWidth,),
              ),
            ],
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}