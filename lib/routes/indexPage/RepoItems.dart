/*
* RepoItems created by zj 
* on 2020/6/15 5:42 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/models/index.dart';
import 'package:fluttergithubpro/routes/BaseWidget/base_web_page.dart';
import '../../common/index.dart';

class GitPubItems extends StatefulWidget {
  GitPubItems(@required this.repo):super(key:ValueKey(repo.id));

  final Repoitems repo;

  @override
  _GitPubState createState() => _GitPubState();
}

class _GitPubState extends State<GitPubItems>{


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var subtitle;
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_){
          return BaseWebPage(url: widget.repo.html_url,title: widget.repo.name,);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Material(
          color: Colors.white,
          shape: BorderDirectional(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 2,
              )
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 0,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  dense: true,
                  leading: ZJAvatar(widget.repo.owner.avatar_url,width: 24,borderRadius: BorderRadius.circular(12)),
                  title: Text(widget.repo.owner.login,textScaleFactor: 0.9,),
                  subtitle: subtitle,
                  trailing: Text(widget.repo.language ?? ""),
                ),
                ///绘制标题和描述
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.repo.fork ? widget.repo.full_name : widget.repo.name,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: widget.repo.fork ? FontStyle.italic : FontStyle.normal
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8,bottom: 12),
                        child: widget.repo.description != null ?
                        Text(widget.repo.description,maxLines: 3,
                            style: TextStyle(height:1.15,color:Colors.blueGrey[700],fontSize: 13)) :
                        Text(Translations.of(context).text("no_description"),
                          style: TextStyle(fontStyle: FontStyle.italic,color: Colors.grey[700]),),
                      ),
                    ],
                  ),
                ),
                ///图标和展示数据
                _builderBottom(),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Widget _builderBottom(){
    const padding = 10;
    return IconTheme(
      data: IconThemeData(
          color: Colors.grey,
          size: 15
      ),
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.grey,fontSize: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context){
            var children =  <Widget>[
              Icon(Icons.star),
              Text(" "+widget.repo.stargazers_count.toString().padRight(padding)),
              Icon(Icons.info_outline),
              Text(" " + widget.repo.open_issues_count.toString().padRight(padding)),
              Icon(Icons.next_week),
              Text("" + widget.repo.fork.toString().padRight(padding)),
            ];
            if (widget.repo.fork){
              children.add(Text("Forked".padRight(padding)));
            }
            if(widget.repo.private == true){
              children.addAll(<Widget>[
                Icon(Icons.lock),
                Text(' private'.padRight(padding)),
              ]);
            }
            return Row(
              children: children,
            );
          }),
        ),
      ),
    );
  }
}