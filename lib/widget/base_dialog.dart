import 'package:flutter/material.dart';
import 'package:lib_mvp/res/resources.dart';
import 'package:lib_mvp/router/app_navigator.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Function onCancel;
  final Widget child;
  final bool hiddenTitle;

  BaseDialog(
      {Key key,
      this.title,
      this.onPressed,
      this.onCancel,
      this.child,
      this.hiddenTitle: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, //如果底部有内容,会自动上移动
      backgroundColor: Colors.transparent, //创建透明图层
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).viewInsets.bottom,
        curve: Curves.easeInCubic,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.only(top: 24.0),
          width: 270.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Offstage(
                //显示标题
                offstage: hiddenTitle,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    hiddenTitle ? "" : title,
                    style: TextStyles.textBoldDark18,
                  ),
                ),
              ),
              Flexible(
                child: child,
              ),
              Gaps.vGap8,
              Gaps.line,
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        height: 48.0,
                        child: FlatButton(
                          onPressed: () {
                            AppNavigator.pop(context);
                            if (null != onCancel) {
                              onCancel();
                            }
                          },
                          child: Text(
                            "取消",
                            style: TextStyle(fontSize: Dimens.font_sp18),
                          ),
                          textColor: Colours.text_gray,
                        )),
                  ),
                  Container(
                    width: 0.6,
                    height: 48.0,
                    child: Gaps.line,
                  ),
                  Expanded(
                    child: Container(
                      height: 48.0,
                      child: FlatButton(
                        child: const Text(
                          "确定",
                          style: TextStyle(fontSize: Dimens.font_sp18),
                        ),
                        textColor: Colours.app_main,
                        onPressed: () {
                          onPressed();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
