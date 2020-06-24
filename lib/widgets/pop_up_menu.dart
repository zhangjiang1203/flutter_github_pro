/*
* pop_up_menu created by zj 
* on 2020/6/24 3:07 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';

typedef PopUpMenuCallBack<String> = void Function(String value);

class PopUpMenu {

  PopUpMenu({this.buttonKey,this.itemsList,this.chooseStr});
  //获取点击的按钮的信息
  final GlobalKey buttonKey;
  //展示的按钮信息
  final List<String> itemsList;
  //默认选中的页面
  final String chooseStr;

  List<PopupMenuEntry<String>> _getPopMenuButton(BuildContext context,String chooseStr) {
    return itemsList.map((e) => CustomCheckPopupMenuItem<String>(value: e,
      child: Text(e,style: TextStyle(color: e == chooseStr ? Theme.of(context).primaryColor : Colors.grey),),
      checked: e == chooseStr,)).toList();
  }

  PopupMenuButton _popupMenuButton(String chooseStr){
    return PopupMenuButton(
      itemBuilder: (context) => _getPopMenuButton(context,chooseStr),
      onCanceled: (){
        print("取消了");
      },
      onSelected: (value){
        //直接在showMenu上进行处理了
      },
    );
  }

  void showPopMenu(BuildContext context,String chooseStr,PopUpMenuCallBack callBack) {
    //获取Position和items
    final RenderBox button = buttonKey.currentContext.findRenderObject();
    final Offset offsetA = button.localToGlobal(Offset.zero);
    //获取到按钮点击的位置信息，去绘制showView的位置
    RelativeRect position = RelativeRect.fromLTRB(offsetA.dx, offsetA.dy + button.size.height,0,0);
    var _pop = _popupMenuButton(chooseStr);
    showMenu<String>(
        context: context,
        position: position,
        items:_pop.itemBuilder(context)
    ).then((value){
      if(value == null) {
        if(_pop.onCanceled != null) _pop.onCanceled();
        return null;
      }
      if(_pop.onSelected != null){
        _pop.onSelected(value);
        callBack(value);
      }
    });
  }

}


class CustomCheckPopupMenuItem<T> extends PopupMenuItem<T> {
  CustomCheckPopupMenuItem({
    Key key,
    T value,
    this.checked = false,
    bool enabled = true,
    this.selectStyle ,
    Widget child,
  }) : assert(checked != null),
        super(
        key: key,
        value: value,
        enabled: enabled,
        child: child,
      );

  final bool checked;
  //设定默认值
  final TextStyle selectStyle;
  @override
  Widget get child => super.child;

  @override
  _CustomCheckPopupMenuItemState<T> createState() => _CustomCheckPopupMenuItemState<T>();
}

class _CustomCheckPopupMenuItemState<T> extends PopupMenuItemState<T, CustomCheckPopupMenuItem<T>>
    with SingleTickerProviderStateMixin {
  static const Duration _fadeDuration = Duration(milliseconds: 150);
  AnimationController _controller;
  Animation<double> get _opacity => _controller.view;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _fadeDuration, vsync: this)
      ..value = widget.checked ? 1.0 : 0.0
      ..addListener(() => setState(() { /* animation changed */ }));
  }

  @override
  void handleTap() {
    if (widget.checked)
      _controller.reverse();
    else
      _controller.forward();
    super.handleTap();
  }

  @override
  Widget buildChild() {
    return ListTile(
      enabled: widget.enabled,
      leading: FadeTransition(
        opacity: _opacity,
        child: Icon(
          _controller.isDismissed ? null : Icons.done,
          color: widget.selectStyle == null ? Theme.of (context).primaryColor : widget.selectStyle.color
        ),
      ),
      title: Theme(
        data: ThemeData(primaryColor: Theme.of(context).primaryColor,
        textTheme: TextTheme()),
        child: widget.child,
      )//widget.child,
    );
  }
}