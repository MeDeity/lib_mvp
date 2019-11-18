import 'package:flutter/material.dart';
import 'package:lib_mvp/mvp/contract.dart';
import 'package:lib_mvp/res/resources.dart';
import 'package:lib_mvp/router/app_navigator.dart';
import 'package:lib_mvp/utils/toast_utils.dart';
import 'package:lib_mvp/utils/utils.dart';
import 'package:lib_mvp/widget/base_dialog.dart';
import 'package:lib_mvp/widget/loading_dialog.dart';
import 'package:lib_mvp/widget/progress_dialog.dart';
import 'base_page_presenter.dart';

///回调函数定义
typedef ParamCallback = void Function(String data);

abstract class BasePageState<T extends StatefulWidget, V extends BasePagePresenter> extends State<T> implements IMvpView {

  V presenter;

  BasePageState() {
    presenter = createPresenter();
    presenter.view = this;
  }

  V createPresenter();

  @override
  void closeProgress() {
    if (mounted && _isShowDialog){
      _isShowDialog = false;
      AppNavigator.pop(context);
    }
  }

  bool _isShowDialog = false;

  void showDialogBox(String message,{VoidCallback cancelCallback,ParamCallback callback,String data,String title}){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BaseDialog(
            title: title??"",
            hiddenTitle: (null==title||title.isEmpty),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(message, style: TextStyles.textDark16),
            ),
            onCancel: (){
              if(null!=cancelCallback){
                cancelCallback();
              }
            },
            onPressed: (){
              AppNavigator.pop(context);
              if(null!=callback) {
                callback(data);
              }
            },
          );
        });
  }

  void showSendProgress({double count:0,double total:1}){
    /// 避免重复弹出
    if (mounted && !_isShowDialog){
      _isShowDialog = true;
      try{
        showTransparentDialog(
            context: context,
            barrierDismissible: false,
            builder:(_) {
              return WillPopScope(
                onWillPop: () async {
                  // 拦截到返回键，证明dialog被手动关闭
                  _isShowDialog = false;
                  return Future.value(true);
                },
//                child: ProgressDialog(content: "正在加载..."),
              child: ProgressDialog(view: Column(
                children: <Widget>[
                  LinearProgressIndicator(
                    value: count/total,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("$count/$total"),
                      Text("${count/total*100}%"),
                    ],
                  ),
                ],
              )),
              );
            }
        );
      }catch(e){
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void showProgress() {
    /// 避免重复弹出
    if (mounted && !_isShowDialog){
      _isShowDialog = true;
      try{
        showTransparentDialog(
            context: context,
            barrierDismissible: false,
            builder:(_) {
              return WillPopScope(
                onWillPop: () async {
                  // 拦截到返回键，证明dialog被手动关闭
                  _isShowDialog = false;
                  return Future.value(true);
                },
                child: LoadingDialog(content: "正在加载..."),
              );
            }
        );
      }catch(e){
        /// 异常原因主要是页面没有build完成就调用Progress。
        print(e);
      }
    }
  }

  @override
  void showToast(String string) {
    ToastUtils.show(string);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    presenter?.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    presenter?.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    presenter?.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    didUpdateWidgets<T>(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    presenter?.initState();
  }

  void didUpdateWidgets<W>(W oldWidget) {
    presenter?.didUpdateWidgets<W>(oldWidget);
  }
}