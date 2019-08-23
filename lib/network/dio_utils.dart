import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:lib_mvp/network/base_entity.dart';
import 'package:lib_mvp/network/error_handler.dart';
import 'package:lib_mvp/network/intercept.dart';
import 'package:rxdart/rxdart.dart';

class DioUtils {
  static const String API_REQUEST_FAIL = "FAILED";
  static const String API_REQUEST_SUCCESS = "SUCCESS";
  static const int API_REQUEST_ERROR = -1;
  static Dio _dio;

  Dio getDio() {
    return _dio;
  }

  static final DioUtils _singleton = DioUtils._internal();

  static DioUtils get instance => DioUtils();

  factory DioUtils() {
    return _singleton;
  }

  DioUtils._internal() {
    var options = BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        responseType: ResponseType.plain,
        validateStatus: (status) {
          // 不使用http状态码判断状态，使用AdapterInterceptor来处理（适用于标准REST风格）
          return true;
        });
    _dio = Dio(options);
//    /// 统一添加身份验证请求头
//    _dio.interceptors.add(AuthInterceptor());
//    /// 刷新Token
//    _dio.interceptors.add(TokenInterceptor());
//    /// 打印Log
    _dio.interceptors.add(LoggingInterceptor());
//    /// 适配数据
    _dio.interceptors.add(AdapterInterceptor());
  }

  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  Future<Response> _request(String method, String url,
      {@required String baseUrl,
      dynamic data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    _dio.options.baseUrl = baseUrl; //修改请求根地址
    Response response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options));
    print("response:${json.decode(response?.data?.toString() ?? "")}");
    return response;
  }

  Future<Response> _requestList<T>(String method, String url,
      {@required String baseUrl,
      dynamic data,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    _dio.options.baseUrl = baseUrl;
    Response response = await _dio.request(url,
        data: data,
        queryParameters: queryParameters,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    print("response:${json.decode(response?.data?.toString() ?? "")}");
    return response;
  }

  Future request(Method method, String url,
      {String baseUrl,
      Function(Response response) onSuccess,
      Function(int code, String mag) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    String m = _getRequestMethod(method);
    return await _request(m, url,
            baseUrl: baseUrl,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((Response result) {
      onSuccess(result);
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      Error error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  Future requestList(Method method, String url,
      {String baseUrl,
      Function(Response response) onSuccess,
      Function(int code, String mag) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options}) async {
    String m = _getRequestMethod(method);
    return await _requestList(m, url,
            baseUrl: baseUrl,
            data: params,
            queryParameters: queryParameters,
            options: options,
            cancelToken: cancelToken)
        .then((Response result) {
      onSuccess(result);
    }, onError: (e, _) {
      _cancelLogPrint(e, url);
      Error error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  /// 统一处理(onSuccess返回T对象，onSuccessList返回List<T>)
  requestNetwork(Method method, String url,
      {String baseUrl,
      Function(Response response) onSuccess,
      Function(Response response) onSuccessList,
      Function(int code, String mag) onError,
      dynamic params,
      Map<String, dynamic> queryParameters,
      CancelToken cancelToken,
      Options options,
      bool isList: false}) {
    String m = _getRequestMethod(method);
    Observable.fromFuture(isList
            ? _requestList(m, url,
                baseUrl: baseUrl,
                data: params,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken)
            : _request(m, url,
                baseUrl: baseUrl,
                data: params,
                queryParameters: queryParameters,
                options: options,
                cancelToken: cancelToken))
        .asBroadcastStream()
        .listen((result) {
      if (isList) {
        if (onSuccessList != null) {
          onSuccessList(result.data);
        }
      } else {
        if (onSuccess != null) {
          onSuccess(result.data);
        }
      }
    }, onError: (e) {
      _cancelLogPrint(e, url);
      Error error = ExceptionHandle.handleException(e);
      _onError(error.code, error.msg, onError);
    });
  }

  _cancelLogPrint(dynamic e, String url) {
    if (e is DioError && CancelToken.isCancel(e)) {
      print("取消请求接口： $url");
    }
  }

  _onError(int code, String msg, Function(int code, String mag) onError) {
    print("接口请求异常： code: $code, mag: $msg");
    if (onError != null) {
      onError(code, msg);
    }
  }

  String _getRequestMethod(Method method) {
    String methodType;
    switch (method) {
      case Method.get:
        methodType = "GET";
        break;
      case Method.post:
        methodType = "POST";
        break;
      case Method.put:
        methodType = "PUT";
        break;
      case Method.delete:
        methodType = "DELETE";
        break;
    }
    return methodType;
  }
}

enum Method {
  get,
  post,
  put,
  delete,
}
