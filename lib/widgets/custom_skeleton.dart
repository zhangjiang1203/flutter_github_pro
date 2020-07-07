/*
* custom_skeleton created by zj 
* on 2020/7/7 3:06 PM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Global.dart';
import 'package:pk_skeleton/pk_skeleton.dart';

class CustomSkeleton {

  static bool get isDark => Global.profile.isGrayFilter;

  /*单个骨架屏*/
  static Widget signalCardSkeleton(){
    return isDark ? PKDarkCardSkeleton(
      isBottomLinesActive: true,
      isCircularImage: true,
    ) : PKCardSkeleton(
      isCircularImage: true,
      isBottomLinesActive: true,
    );
  }

  /*多个list骨架屏*/
  static Widget multiCardListSkeleton(){
    return isDark ? PKDarkCardListSkeleton(
      isCircularImage: true,
      isBottomLinesActive: true,
      length: 5,
    ):PKCardListSkeleton(
      isBottomLinesActive: true,
      isCircularImage: true,
      length: 5,
    );
  }

}