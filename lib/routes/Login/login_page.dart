/*
* LoginRoute created by zj 
* on 2020/5/14 6:36 PM
* copyright on zhangjiang
*/

import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttergithubpro/HttpManager/CommentUse.dart';
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
  bool _isShowClear = false;
  bool _isShowPWD = false;
  //全局的key
  GlobalKey _formKey = new GlobalKey<FormState>();

  void _login() async{
    EasyLoading.show(status: "loading……");
    //提交前验证数据
    if((_formKey.currentState as FormState).validate()){
      //开始登录
      User user;
      try{
        user = await RequestAPI().login(_nameController.text, _passwordController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserProvider>(context).user = user;
        print("获取的对象===$user");
      }catch (e){
        print("用户登录失败===${e.message}");
      } finally{
        EasyLoading.dismiss();
      }
      if(user != null){
        //跳转到首页，移除之前的login界面的路由
        Navigator.of(context).pushReplacementNamed("/");
      }
    }else{
      //提示用户账号密码输入不合适
      EasyLoading.showError("账号密码错误，请重试");
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //填充上一次用户的用户名和密码

    String userName = Global.preferences.getString(CommentUse.loginName);
    if(userName != null){
      _isShowClear = userName.length > 0;
      _nameController.text = userName;
    }

    String password = Global.preferences.getString(CommentUse.loginPassword);
    if(password != null){
      var temp = convert.base64Decode(password);
      password = convert.utf8.decode(temp).replaceFirst(CommentUse.base64Extra, "");
      _isShowPWD = password.length > 0;
      _passwordController.text = password;
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
                        suffixIcon: !_isShowClear ? null : IconButton(
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
                        setState(() {
                          _isShowClear = v.length > 0;
                        });
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
                        suffixIcon: !_isShowPWD ? null : IconButton(
                          icon: Icon( !_isPwdShow ? Icons.visibility : Icons.visibility_off,color: Colors.white,),
                          onPressed: ()=>setState(()=> _isPwdShow = !_isPwdShow),
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
                        hintText: '请输入密码',
                        hintStyle: TextStyle(color: Color(0xffeeeeee)),
                      ),
                      onChanged: (v){
                        setState(() {
                          _isShowPWD = v.length > 0;
                        });
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