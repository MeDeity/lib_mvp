import 'package:oktoast/oktoast.dart';

class ToastUtils {
  static show(String msg, {duration = 2000}) {
    showToast((null!=msg&&msg.isNotEmpty)?msg:"未知错误", duration: Duration(milliseconds: duration));
  }

  static cancelToast() {
    dismissAllToast();
  }
}
