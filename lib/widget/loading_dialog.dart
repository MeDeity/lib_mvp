import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lib_mvp/res/resources.dart';

class ProgressDialog extends StatefulWidget {
  final String content;
  final bool isOutSideTapDismiss;
  final Function dismiss;

  ProgressDialog({this.content, this.isOutSideTapDismiss: false, this.dismiss});

  @override
  State<StatefulWidget> createState() {
    return _LoadingState(content: content);
  }
}

class _LoadingState extends State<ProgressDialog> {
  String content;

  _LoadingState({this.content});

  @override
  void initState() {
    super.initState();
    if (null != widget.dismiss) {
      //注入关闭Dialog的方法
      widget.dismiss(() {
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency, //透明材质
        child: Center(
          child: SizedBox(
            width: 120.0,
            height: 120,
            child: Container(
              decoration: ShapeDecoration(
                color: Color(0xFF3A3A3A),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                )),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
//                  CircularProgressIndicator(),
                  CupertinoActivityIndicator(radius: 14.0),
                  Gaps.vGap8,
                  Text(content,
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis)
                ],
              ),
            ),
          ),
        ),
      );
  }
}
