import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
///原始路由
///create by fengwenhua at 2019-6-26 13:33:17
///
class AppNavigator {
  ///打开一个新的页面
  static push(BuildContext context, Widget widget) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  ///上个页面将执行disposed方法
  static pushReplacement(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }

  ///加入新的页面,其他页面将会被pop
  static pushAndRemoveUntil(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget),
        (route) => route == null);
  }

  ///携带返回结果
  static pushResult(BuildContext context, Widget widget,Function function){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (BuildContext context) => widget),)
        .then((result){
          if(null!=result){
            function(result);
          }
        }).catchError((error){
          print("$error");
        });
  }

  //返回上一页面
  static back(BuildContext context){
    Navigator.maybePop(context);
  }

  ///返回上一页并附带参数
  static backResult(BuildContext context, result){
    Navigator.pop(context,result);
  }

  ///返回上一页
  static pop(BuildContext context){
    Navigator.pop(context);
  }
}
