/*
* base_web_page created by zj 
* on 2020/5/22 6:39 PM
* copyright on zhangjiang
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/index.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BaseWebPage extends StatefulWidget {
  BaseWebPage({Key key,@required this.url,this.title}) : assert(url != null), super(key: key);

  String title;
  String url;

  @override
  _BaseWebPageState createState() => _BaseWebPageState();
}

class _BaseWebPageState extends State<BaseWebPage> {

  WebViewController _controller;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    JavascriptChannel _channel(BuildContext context){
      return JavascriptChannel(
        name: "toast",
        onMessageReceived: (message){
          zjPrint("js====%message", StackTrace.current);
        }
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title ?? ""),
        ),
        body:SafeArea(
          child:Stack(
            children: <Widget>[
              WebView(
                initialUrl: widget.url,
                onPageStarted: (e){
                  setState(() {
                    isLoading = true;
                  });
                },
                onPageFinished: (e){
                  _controller.evaluateJavascript("document.title").then((result){
                    setState(() {
                      widget.title = result;
                      isLoading = false;
                    });
                  });
                },
                onWebViewCreated: (controller){
                  _controller = controller;
                  zjPrint(controller, StackTrace.current);
                },
                javascriptMode: JavascriptMode.unrestricted,
                javascriptChannels: [
                  _channel(context),
                ].toSet(),
                navigationDelegate: (request){
                  //是否相应请求--黑白名单过滤
                  return NavigationDecision.navigate;
                },
              ),
              isLoading ? Container(child:Center(child:CircularProgressIndicator())) : Container(),
            ],
          )
        )
    );
  }
}