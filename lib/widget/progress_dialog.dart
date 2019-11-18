import 'package:flutter/material.dart';
import 'package:lib_mvp/res/resources.dart';

class ProgressDialog extends StatefulWidget {
  final double width;
  final double height;
  final Widget view;

  ProgressDialog({Key key, this.width: 100, this.height: 50,this.view:Gaps.empty}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProgressDialogState(this.width, this.height);
  }
}

class ProgressDialogState extends State<ProgressDialog> {
  final double width;
  final double height;

  ProgressDialogState(this.width, this.height);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Material(
      type: MaterialType.transparency, //透明材质
      child: Container(
        child: Center(
          child: SizedBox(
            width: width,
            height: height,
            child: widget.view,
          ),
        ),
      ),
    );
  }
}
