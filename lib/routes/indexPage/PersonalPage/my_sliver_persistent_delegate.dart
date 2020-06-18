/*
* my_sliver_Persistent_delegate created by zj 
* on 2020/6/16 4:26 PM
* copyright on zhangjiang
*/

import 'dart:math';

import 'package:flutter/material.dart';

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {

  MySliverPersistentHeaderDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child});

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(minHeight, maxHeight);


  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxExtent || minHeight != oldDelegate.minExtent || child != oldDelegate.child;
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return SizedBox.expand(
      child: child,
    );
  }
}
