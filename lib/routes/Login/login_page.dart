/*
* LoginRoute created by zj 
* on 2020/5/14 6:36 PM
* copyright on zhangjiang
*/

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/HttpManager/RequestAPI.dart';
import 'package:fluttergithubpro/common/ScreenUtil.dart';
import 'package:provider/provider.dart';
import '../../common/index.dart';
import '../../models/index.dart';

class LoginRoute extends StatefulWidget {
  LoginRoute({Key key}) : super(key: key);

  @override
  _LoginRoute createState() => _LoginRoute();
}

class _LoginRoute extends State<LoginRoute> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isPwdShow = false;
  bool _nameAutoFocus = true;
  bool isClear = false;
  //全局的key
  GlobalKey _formKey = new GlobalKey<FormState>();

  void _login(){


    //提交前验证数据
    if((_formKey.currentState as FormState).validate()){
      //开始登录
      User user;
      try{
        RequestAPI().login(_nameController.text, _passwordController.text);

      }catch (e){

      } finally{

      }

      if(user != null){
        Navigator.of(context).pushReplacementNamed("/");
      }

    }else{
      //提示用户账号密码输入不合适

    }
  }

  @override
  Widget build(BuildContext context) {
    //UI相关设置
    ScreenUtil.init(context,width: 750,height: 1334,allowFontScaling: true);
    var locale = Translations.of(context);

    return Scaffold(
      //防止键盘谈起遮挡
      resizeToAvoidBottomPadding:false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage("assets/images/login_back_ground.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child:ClipOval(
                    child: Image.asset(
                      "assets/images/github_logo.png",
                      width: 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
                  child: Container(
                    height: 60,
                    child: TextField(
                      style: TextStyle(color: Colors.white,fontSize: 18),
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white,),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear,color: Colors.white,),
                          onPressed: ()=> setState(()=>_nameController.text = ""),
                        ),
                        isDense: true,
                        fillColor: Color(0x30cccccc),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(color: Color(0x00ff0000))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Color(0xffffffff)),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: '请输入用户名',
                        hintStyle: TextStyle(color: Color(0xffeeeeee)),
                      ),
                      onChanged: (v){
                        print('用户名==$v');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
                  child: Container(
                    height: 60,
                    child: TextField(
                      obscureText: !_isPwdShow,
                      style: TextStyle(color: Colors.white,fontSize: 18),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock,color: Colors.white,),
                        suffixIcon: IconButton(
                          icon: Icon(_isPwdShow ? Icons.visibility : Icons.visibility_off,color: Colors.white,),
                          onPressed: ()=>setState(()=> _isPwdShow = !_isPwdShow),
                        ),
//                        Container(
//                          width: 100,
//                          child: Row(
////                            mainAxisAlignment: MainAxisAlignment.end,
//                            children: <Widget>[
//                              IconButton(
//                                icon: Icon(Icons.clear,color: Colors.white,),
//                                onPressed: ()=> setState(()=>_passwordController.text = ""),
//                              ),
//                              IconButton(
//                                icon: Icon(_isPwdShow ? Icons.visibility : Icons.visibility_off,color: Colors.white,),
//                                onPressed: ()=>setState(()=> _isPwdShow = !_isPwdShow),
//                              ),
//                            ],
//                          ) ,
//                        ),

                        isDense: true,
                        fillColor: Color(0x30cccccc),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            borderSide: BorderSide(color: Color(0x00ff0000))
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color:Color(0xffffffff)),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: '请输入密码',
                        hintStyle: TextStyle(color: Color(0xffeeeeee)),
                      ),
                      onChanged: (v){
                        print('密码==$v');
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 80),
                  child: FlatButton(
                    child: Container(
                      alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Provider.of<ThemeProvider>(context).theme,
                        ),
                        height: 50,
                        child: Text('登录',style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                    onPressed: _login,
                  )
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}