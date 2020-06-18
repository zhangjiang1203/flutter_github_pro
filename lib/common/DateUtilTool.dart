/*
* DateUtilTool created by zj 
* on 2020/6/18 11:06 AM
* copyright on zhangjiang
*/

import 'package:flutter/material.dart';
import 'package:fluttergithubpro/common/Translations.dart';
import 'package:fluttergithubpro/models/index.dart';

//时间处理工具
class DateUtilTool {

  static final ONE_MINUTE = 60000;
  static final ONE_HOUR = 3600000;
  static final ONE_DAY = 86400000;
  static final ONE_WEEK = 604800000;

  static final ONE_SECOND_AGO = " 秒前";
  static final ONE_MINUTE_AGO = " 分钟前";
  static final ONE_HOUR_AGO = " 小时前";
  static final ONE_DAY_AGO = " 天前";
  static final ONE_MONTH_AGO = " 月前";
  static final ONE_YEAR_AGO = " 年前";

  //比较时间设置
//  DateTime.parse(timestr)  直接转化为时间戳

  static String formatTime(DateTime date,BuildContext context){
    num time = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if(time < ONE_MINUTE){
      num seconds = _toSeconds(time);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + Translations.of(context).text('ONE_SECOND_AGO');
    }
    if(time < 45 * ONE_MINUTE) {
      num minutes = _toMinutes(time);
      return (minutes <= 0 ? 1 :minutes).toInt().toString() + Translations.of(context).text('ONE_MINUTE_AGO');
    }

    if(time < 24 * ONE_HOUR){
      num hours = _toHours(time);
      return (hours <= 0 ? 1 : hours).toInt().toString() + Translations.of(context).text('ONE_HOUR_AGO');
    }

    if(time < 48 * ONE_HOUR){
      return Translations.of(context).text('ONE_YESTODAY_AGO');
    }

    if(time < 30 * ONE_DAY){
      num days = _toDays(time);
      return (days <= 0 ? 1 : days).toInt().toString() + Translations.of(context).text('ONE_DAY_AGO');
    }

    if(time < 12 * 4 * ONE_DAY){
      num month = _toMonths(time);
      return (month <= 0 ? 1 : month).toInt().toString() + Translations.of(context).text('ONE_MONTH_AGO');
    }else{
      num years = _toYears(time);
      return (years <= 0 ? 1 : years).toInt().toString() + Translations.of(context).text('ONE_YEAR_AGO');
    }

  }

  static num _toSeconds(num date) {
    return date / 1000;
  }

  static num _toMinutes(num date) {
    return _toSeconds(date) / 60;
  }

  static num _toHours(num date) {
    return _toMinutes(date) / 60;
  }

  static num _toDays(num date) {
    return _toHours(date) / 24;
  }

  static num _toMonths(num date) {
    return _toDays(date) / 30;
  }

  static num _toYears(num date) {
    return _toMonths(date) / 365;
  }

}


class EventUtils {
  ///事件描述与动作
  static getActionAndDes(Pubevents event) {
    String actionStr;
    String des;
    switch (event.type) {
      case "CommitCommentEvent":
        actionStr = "Commit comment at " + event.repo.name;
        break;
      case "CreateEvent":
        if (event.payload.ref_type == "repository") {
          actionStr = "Created repository " + event.repo.name;
        } else {
          actionStr = "Created " +
              event.payload.ref_type +
              " " +
              event.payload.ref +
              " at " +
              event.repo.name;
        }
        break;
      case "DeleteEvent":
        actionStr = "Delete " +
            event.payload.ref_type +
            " " +
            event.payload.ref +
            " at " +
            event.repo.name;
        break;
      case "ForkEvent":
        String oriRepo = event.repo.name;
        String newRepo = event.actor.login + "/" + event.repo.name;
        actionStr = "Forked " + oriRepo + " to " + newRepo;
        break;
      case "GollumEvent":
        actionStr = event.actor.login + " a wiki page ";
        break;

      case "InstallationEvent":
        actionStr = event.payload.action + " an GitHub App ";
        break;
      case "InstallationRepositoriesEvent":
        actionStr = event.payload.action + " repository from an installation ";
        break;
      case "IssueCommentEvent":
        actionStr = event.payload.action +
            " comment on issue " +
            //  event.payload.issue.number.toString() +
            " in " +
            event.repo.name;
        // des = event.payload.comment.body;
        break;
      case "IssuesEvent":
        actionStr = event.payload.action +
            " issue " +
            //    event.payload.issue.number.toString() +
            " in " +
            event.repo.name;
        //   des = event.payload.issue.title;
        break;

      case "MarketplacePurchaseEvent":
        actionStr = event.payload.action + " marketplace plan ";
        break;
      case "MemberEvent":
        actionStr = event.payload.action + " member to " + event.repo.name;
        break;
      case "OrgBlockEvent":
        actionStr = event.payload.action + " a user ";
        break;
      case "ProjectCardEvent":
        actionStr = event.payload.action + " a project ";
        break;
      case "ProjectColumnEvent":
        actionStr = event.payload.action + " a project ";
        break;

      case "ProjectEvent":
        actionStr = event.payload.action + " a project ";
        break;
      case "PublicEvent":
        actionStr = "Made " + event.repo.name + " public";
        break;
      case "PullRequestEvent":
        actionStr = event.payload.action + " pull request " + event.repo.name;
        break;
      case "PullRequestReviewEvent":
        actionStr =
            event.payload.action + " pull request review at" + event.repo.name;
        break;
      case "PullRequestReviewCommentEvent":
        actionStr = event.payload.action +
            " pull request review comment at" +
            event.repo.name;
        break;

      case "PushEvent":
        String ref = event.payload.ref;
        ref = ref.substring(11);
        actionStr = "Push to " + ref + " at " + event.repo.name;

        des = '';
        String descSpan = '';

        int count = event.payload.commits.length;
        int maxLines = 4;
        int max = count > maxLines ? maxLines - 1 : count;

        for (int i = 0; i < max; i++) {
          Eventcommits commit = event.payload.commits[i];
          if (i != 0) {
            descSpan += ("\n");
          }
          String sha = commit.sha.substring(0, 7);
          descSpan += sha;
          descSpan += " ";
          descSpan += commit.message;
        }
        if (count > maxLines) {
          descSpan = descSpan + "\n" + "...";
        }
        break;
      case "ReleaseEvent":
        actionStr = event.payload.action +
            " release " +
            //  event.payload.release.tagName +
            " at " +
            event.repo.name;
        break;
      case "WatchEvent":
        actionStr = event.payload.action + " " + event.repo.name;
        break;
    }

    return {"actionStr": actionStr, "des": des != null ? des : ""};
  }
}