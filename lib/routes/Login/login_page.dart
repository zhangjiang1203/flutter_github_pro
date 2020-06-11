/*
* LoginRoute created by zj 
* on 2020/5/14 6:36 PM
* copyright on zhangjiang
*/

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
//    if((_formKey.currentState as FormState).validate()){
//      User user;
//      try{
//        print(user.login);
//        //保存信息
//        Provider.of<UserProvider>(context,listen: false).user = user;
//      }catch (e) {
//        if (e.response?.statusCode == 401){
//          ZJShowDialogTool.of(context).showToast("哈哈哈哈");
//        }
//      }finally{
//
//      }
////      if (user != null){
//      print("kaisi12");
//        Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
////      }
//    }else{
//      //提示用户账号密码输入不合适
//      print("kaisi34");
//      Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
//    }
  }

  @override
  Widget build(BuildContext context) {

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
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 60),
                  child:  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(width: 320, height: 50),
                    child: Platform.isIOS ? CupertinoButton(
                      color: Provider.of<ThemeProvider>(context).theme,
                      child: Text("登录"),
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      onPressed: (){},
                    ) :  RaisedButton(
                      color: Provider.of<ThemeProvider>(context).theme,
                      textColor: Colors.white,
                      child: Text("登录"),
                      onPressed: (){},
                    ),
                  ),
                ),

              ],
            ),
          ),
        )
      )
    );
  }
}



class GradientButton extends StatelessWidget {
  GradientButton({
    this.colors,
    this.width,
    this.height,
    this.borderRadius,
    this.tapCallback,
    @required this.child,
  });

  final List<Color> colors;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Widget child;
  final GestureTapCallback tapCallback;


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保数组不空
    List<Color> _colors = colors ??
        [theme.primaryColor, theme.primaryColorDark, theme.primaryColor];

    // TODO: implement build
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: LinearGradient(colors: _colors),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: borderRadius,
          onTap: tapCallback,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: width, height: height),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultTextStyle(
                  style: TextStyle(fontWeight: FontWeight.bold),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


//Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//TextFormField(
//autofocus: _nameAutoFocus,
//controller: _nameController,
//decoration: InputDecoration(
//labelText: "用户名",
//hintText: "请输入用户名",
//prefixIcon: Icon(Icons.person),
//suffixIcon: isClear ?  IconButton(
//icon: Icon(Icons.clear),
//onPressed: (){
//setState(() {
//_nameController.text = "";
//});
//},
//) : null,
//),
//onChanged: (e){
//zjPrint("开始变化$e",StackTrace.current);
//setState(() {
//isClear = e.length > 0;
//});
//},
/////校验用户名
//validator: (v){
//return v.trim().isNotEmpty ? null : "请输入用户名";
//},
//),
//TextFormField(
//autofocus: !_nameAutoFocus,
//controller: _passwordController,
//decoration: InputDecoration(
//labelText: "密码",
//hintText: "请输入密码",
//prefixIcon: Icon(Icons.lock),
////密码是否可见
//suffixIcon: IconButton(
//icon: Icon(isShowPWD ? Icons.visibility_off : Icons.visibility),
//onPressed: ()=> setState(()=> isShowPWD = !isShowPWD),
//),
//),
//obscureText: !isShowPWD,
//validator: (v){
//return v.trim().isNotEmpty ? null : "请输入密码";
//},
//),
//Padding(
//padding: const EdgeInsets.only(top: 20),
//child: ConstrainedBox(
//constraints: BoxConstraints.expand(height: 55),
//child: RaisedButton(
//textColor: Colors.white,
//color: Theme.of(context).primaryColor,
//child: Text('登录'),
//onPressed: _login,
//),
//)
//)
//],
//),