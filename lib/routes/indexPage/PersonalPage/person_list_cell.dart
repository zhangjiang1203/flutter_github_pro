/*
* PersonListCell created by zj 
* on 2020/6/18 3:01 PM
* copyright on zhangjiang
*/

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/my_personal_page.dart';
import 'package:provider/provider.dart';

class PersonListCell extends StatefulWidget {
  PersonListCell({Key key,@required this.user}) : super(key: key);

  final User user;
  @override
  _PersonListCell createState() => _PersonListCell();
}

class _PersonListCell extends State<PersonListCell> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return PersonalRepoPage(userName: widget.user.login);
        }));
      },
      child: Material(
//        type: MaterialType.circle,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        shadowColor: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: widget.user.avatar_url,
                placeholder: (context,url)=>Global.placeholder(width: 80),
                width: 80,
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 5),),
            Text(widget.user.login,style: TextStyle(color: Color(0xff999999),fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}