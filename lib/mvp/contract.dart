

import 'package:lib_mvp/mvp/ilife_cycle.dart';

abstract class IMvpView {
  /// 显示Progress
  void showProgress({String content});

  void showSendProgress({double count,double total});

  /// 关闭Progress
  void closeProgress();

  /// 展示Toast
  void showToast(String string);
}

abstract class IPresenter extends ILifeCycle {}
