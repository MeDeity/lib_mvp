import 'package:flutter/material.dart';


class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  ///计算缓存值的大小并格式化数据
  static String getFormatSize(double size) {
    double kiloByte = size / 1024;
    if (kiloByte < 1) {
      return "0KB";
    }
    double megaByte = kiloByte / 1024;
    if (megaByte < 1) {
      return megaByte.toStringAsFixed(2) + "KB";
    }
    double gigaByte = megaByte / 1024;
    if (gigaByte < 1) {
      return gigaByte.toStringAsFixed(2) + "KB";
    }
    double teraBytes = gigaByte / 1024;
    if (teraBytes < 1) {
      return teraBytes.toStringAsFixed(2) + "GB";
    }
    return teraBytes.toStringAsFixed(2) + "TB";
  }
}

/// 默认dialog背景色为半透明黑色，这里修改源码改为透明
Future<T> showTransparentDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}) {
  final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final Widget pageChild = Builder(builder: builder);
      return SafeArea(
        child: Builder(builder: (BuildContext context) {
          return theme != null
              ? Theme(data: theme, child: pageChild)
              : pageChild;
        }),
      );
    },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Color(0x00FFFFFF),
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
