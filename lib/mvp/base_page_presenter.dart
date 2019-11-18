import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lib_mvp/mvp/contract.dart';
import 'package:lib_mvp/network/dio_utils.dart';
import 'package:lib_mvp/network/error_handler.dart';

class BasePagePresenter<V extends IMvpView> extends IPresenter {
  V view;
  CancelToken _cancelToken;

  BasePagePresenter() {
    _cancelToken = CancelToken();
  }

  @override
  void deactivate() {}

  @override
  void didChangeDependencies() {}

  @override
  void didUpdateWidgets<W>(W oldWidget) {}

  @override
  void dispose() {
    /// 销毁时，将请求取消
    if (!_cancelToken.isCancelled) {
      _cancelToken.cancel();
    }
  }

  @override
  void initState() {}

  Future multipartFile(Method method,
      {@required String url,
        bool isShow: true,
        bool isClose: true,
        Function(Response reponse) onSuccess,
        Function(int code, String mag) onError,
        dynamic params,
        Map<String, dynamic> queryParameters,
        ProgressCallback onSendProgress,
        ProgressCallback onReceiveProgress,
        CancelToken cancelToken,
        Options options}) async {
    await DioUtils.instance.request(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken ?? _cancelToken,
        onSuccess: (data) {
          if (isClose) view.closeProgress();
          if (onSuccess != null) {
            onSuccess(data);
          }
        },
        onError: (code, msg) {
          _onError(code, msg, onError);
        });
  }

  /// 返回Future 适用于刷新，加载更多
  Future request(Method method,
      {@required String url,
      bool isShow: true,
      bool isClose: true,
      Function(Response reponse) onSuccess,
      Function(int code, String mag) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      CancelToken cancelToken,
      Options options}) async {
    if (isShow) view.showProgress();
    await DioUtils.instance.request(method, url,
        params: params,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  /// 返回Future 适用于刷新，加载更多
  Future requestList(Method method,
      {@required String url,
      String baseUrl,
      bool isShow: true,
      bool isClose: true,
      Function(Response response) onSuccess,
      Function(int code, String mag) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      Options options}) async {
    if (isShow) view.showProgress();
    await DioUtils.instance.requestList(method, url,
        params: params,
        baseUrl: baseUrl,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken ?? _cancelToken, onSuccess: (data) {
      if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  void requestNetwork(Method method,
      {@required String url,
      String baseUrl,
      bool isShow: true,
      bool isClose: true,
      Function(Response response) onSuccess,
      Function(Response list) onSuccessList,
      Function(int code, String mag) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      ProgressCallback onSendProgress,
      ProgressCallback onReceiveProgress,
      Options options,
      bool isList: false}) {
    if (isShow) view.showProgress();
    DioUtils.instance.requestNetwork(method, url,
        params: params,
        baseUrl: baseUrl,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken ?? _cancelToken,
        isList: isList, onSuccess: (data) {
      if (isClose) view.closeProgress();
      if (onSuccess != null) {
        onSuccess(data);
      }
    }, onSuccessList: (data) {
      if (isClose) view.closeProgress();
      if (onSuccessList != null) {
        onSuccessList(data);
      }
    }, onError: (code, msg) {
      _onError(code, msg, onError);
    });
  }

  _onError(int code, String msg, Function(int code, String mag) onError) {
    /// 异常时直接关闭加载圈，不受isClose影响
    view.closeProgress();
    if (code != ExceptionHandle.cancel_error) {
      view.showToast(msg);
    }
    if (onError != null) {
      onError(code, msg);
    }
  }
}
