/*
* LoginRoute created by zj 
* on 2020/5/14 6:36 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import '../common/index.dart';
class LoginRoute extends StatefulWidget {
  LoginRoute({Key key}) : super(key: key);

  @override
  _LoginRoute createState() => _LoginRoute();
}

class _LoginRoute extends State<LoginRoute> {

  @override
  Widget build(BuildContext context) {

    TextEditingController _countController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    bool isShowPWD = false;
    bool _nameAutoFocus = true;
    //全局的key
    GlobalKey _formKey = new GlobalKey<FormState>();

    void _login() async{
      await NetWorkRequest().login('896884553@qq.com', "zj@901203").then((value) => print(value));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("LoginRoute"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child:Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(),
                TextFormField(),
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