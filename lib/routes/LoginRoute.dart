/*
* LoginRoute created by zj 
* on 2020/5/14 6:36 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:provider/provider.dart';
import '../common/index.dart';
import '../models/index.dart';
class LoginRoute extends StatefulWidget {
  LoginRoute({Key key}) : super(key: key);

  @override
  _LoginRoute createState() => _LoginRoute();
}

class _LoginRoute extends State<LoginRoute> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool isShowPWD = false;
  bool _nameAutoFocus = true;
  bool isClear = false;
  //全局的key
  GlobalKey _formKey = new GlobalKey<FormState>();

  void _login() async{
    //提交前验证数据
    if((_formKey.currentState as FormState).validate()){
      User user;
      try{
        user = await NetWorkRequest(context).login("896884553@qq.com", 'zj@901203');
        print(user.login);
        //保存信息
        Provider.of<UserProvider>(context,listen: false).user = user;
      }catch (e) {
        if (e.response?.statusCode == 401){
          ZJShowDialogTool.of(context).showToast("哈哈哈哈");
        }
      }finally{

      }
      if (user != null){
        Navigator.of(context).pop();
      }
    }else{
      //提示用户账号密码输入不合适
    }
  }

  @override
  Widget build(BuildContext context) {

    var locale = Translations.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(locale.text('login_title')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child:Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "请输入用户名",
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: isClear ?  IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: (){
                        setState(() {
                          _nameController.text = "";
                        });
                      },
                    ) : null,
                  ),
                  onChanged: (e){
                    zjPrint("开始变化$e",StackTrace.current);
                    setState(() {
                      isClear = e.length > 0;
                    });
                  },
                  ///校验用户名
                  validator: (v){
                    return v.trim().isNotEmpty ? null : "请输入用户名";
                  },
                ),
                TextFormField(
                  autofocus: !_nameAutoFocus,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "请输入密码",
                    prefixIcon: Icon(Icons.lock),
                    //密码是否可见
                    suffixIcon: IconButton(
                      icon: Icon(isShowPWD ? Icons.visibility_off : Icons.visibility),
                      onPressed: ()=> setState(()=> isShowPWD = !isShowPWD),
                    ),
                  ),
                  obscureText: !isShowPWD,
                  validator: (v){
                    return v.trim().isNotEmpty ? null : "请输入密码";
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text('登录'),
                      onPressed: ()=> _login(),
                    ),
                  )
                )
              ],
            ),
          ),
        ),//his trailing comma makes auto-formatting nicer for build methods.
    );
  }
}