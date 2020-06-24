/*
* event_list_item created by zj 
* on 2020/6/18 9:51 AM
* copyright on zhangjiang
*/

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/DateUtilTool.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/indexPage/PersonalPage/my_personal_page.dart';
import 'package:provider/provider.dart';

class EventListItem extends StatefulWidget {
  EventListItem({Key key,@required this.events})
      :assert(events != null,"请设置events模型"),
        super(key: key);
  //数据模型
  final Pubevents events;
  @override
  _EventListItemState createState() => _EventListItemState();
}

class _EventListItemState extends State<EventListItem> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: (){},
      child:  Material(
          color: Colors.white,
          shape: BorderDirectional(
            bottom: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 2,
            )
          ),
        child:Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child:  ClipOval(
                          child: CachedNetworkImage(
                            width: 50,
                            imageUrl: widget.events.actor.avatar_url ?? "",
                            placeholder: (context,url) => Global.defaultHeaderImage(),
                          ),
                        ),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (_){
                          return PersonalRepoPage(userName: widget.events.actor.login);
                        }));
                      },
                    ),
                    Padding(padding: const EdgeInsets.only(left: 5)),
                    Expanded(
                      child: Text(widget.events.actor.login ?? "",style: TextStyle(fontSize: 18,color: Provider.of<ThemeProvider>(context).theme),),
                    ),
                    Text(DateUtilTool.formatTime(DateTime.parse(widget.events.created_at), context),style: TextStyle(color: Colors.grey,fontSize: 12),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  //事件的处理
                  child: Text(EventUtils.getActionAndDes(widget.events)["actionStr"] ?? ""),
                )
              ],
            ),
          ),
        )
    );
  }
}
