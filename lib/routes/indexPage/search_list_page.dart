/*
* search_list_page created by zhangjiang 
* on 2020/6/18 11:35 PM
* copyright on zhangjiang
*/

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

class SearchListPage extends StatefulWidget {
  SearchListPage({Key key}) : super(key: key);

  @override
  _SearchListPageState createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {

  TextEditingController _nameController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image:  ExactAssetImage("assets/images/book_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
          children: <Widget>[
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                leading: IconButton(
                  icon:Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,color: Color(0xff666666)),
                  onPressed: ()=>Navigator.of(context).pop(),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title:  Container (
                  height: 40,
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Color(0xff000000),fontSize: 18,),
                      controller: _nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 10,right: 10),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear,color: Color(0xff999999),),
                          onPressed: ()=> setState(()=>_nameController.text = ""),
                        ),
                        isDense: true,
//                        fillColor: Color(0x30cccccc),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(color: Color(0x00ff0000))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Color(0xff999999)),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: '请输入搜索内容',
                        hintStyle: TextStyle(color: Color(0xff999999f),textBaseline: TextBaseline.alphabetic),
                      ),
                      onChanged: (v){

                      },
                )
                )
              ),
              body: Container(
                child: Text("哈哈哈哈"),
              ),
            )
          ],
        ),
      );


  }
}