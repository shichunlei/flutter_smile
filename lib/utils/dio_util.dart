import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smile/models/base_result.dart';

class DioUtil {
  static Dio _dio;

  static String BASE_URL = "http://www.yoksoft.com/webapi/smile/SmileApi.ashx";
  static const int CONNECT_TIMEOUT = 10000;
  static const int RECEIVE_TIMEOUT = 3000;

  static const String GET = 'get';
  static const String POST = 'post';

  static final DioUtil _shared = DioUtil._internal();

  factory DioUtil() => _shared;

  DioUtil._internal() {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: BASE_URL,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        receiveDataWhenStatusError: false,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      _dio = Dio(options);

      _dio.interceptors
        ..add(InterceptorsWrapper(
          /// 请求时的处理
          onRequest: (RequestOptions options) {
            debugPrint("\n================== 请求数据 ==========================");
            debugPrint("method = ${options.method}");
            debugPrint("url = ${options.uri.toString()}");
            debugPrint("headers = ${options.headers}");
            debugPrint("queryParameters = ${options.queryParameters}");
            debugPrint("data = ${options.data}");
          },

          /// 响应时的处理
          onResponse: (Response response) {
            debugPrint("\n================== 响应数据 ==========================");
            debugPrint("statusCode = ${response.statusCode}");
            debugPrint("data = ${response.data}");
            debugPrint("\n");
          },
          onError: (DioError e) {
            debugPrint("\n================== 错误响应数据 ======================");
            debugPrint("type = ${e.type}");
            debugPrint("error = ${e.error}");
            debugPrint("message = ${e.message}");
            debugPrint("request = ${e.request.queryParameters}");
            debugPrint("response = ${e.response.statusCode}");
            debugPrint("\n");
          },
        ))

        /// 添加 LogInterceptor 拦截器来自动打印请求、响应日志
        ..add(LogInterceptor(
          request: false,
          responseBody: true,
          responseHeader: false,
          requestHeader: false,
        ));
    }
  }

  requestHttp<T>(String path, Function(T t) successCallBack,
      {@required String method,
      Map<String, dynamic> params,
      Function(BaseResult error) errorCallBack,
      CancelToken cancelToken,
      Options options}) async {
    Response response;
    try {
      if (method == GET) {
        if (null != params && params.isNotEmpty) {
          response = await _dio.get(
            path,
            queryParameters: params,
            options: _checkOptions(method, options),
            cancelToken: cancelToken,
          );
        } else {
          response = await _dio.get(
            path,
            options: _checkOptions(method, options),
            cancelToken: cancelToken,
          );
        }
      } else if (method == POST) {
        response = await _dio.post(
          path,
          data: params != null ? FormData.fromMap(params) : null,
          queryParameters: params,
          options: _checkOptions(method, options),
          onSendProgress: (int count, int total) {
            debugPrint(
                'onSendProgress: ${(count / total * 100).toStringAsFixed(0)} %');
          },
          cancelToken: cancelToken,
        );
      }
    } on DioError catch (error) {
      formatError(error);
      _error(
          errorCallBack,
          BaseResult(
              message: error.message.toString(),
              code: error.response.statusCode.toString()));
    }
    if (response != null &&
        response.statusCode >= 200 &&
        response.statusCode < 300) {
      BaseResult result = BaseResult.fromMap(json.decode(response.data));
      if (result == null || result.code != '0') {
        _error(errorCallBack, result);
      } else if (successCallBack != null) {
        successCallBack(result.data);
      }
    } else {
      _error(
          errorCallBack,
          BaseResult(
              message: response.data.toString(),
              code: response.statusCode.toString()));
    }
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );
    }
    options.method = method;
    return options;
  }

  /// error统一处理
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      debugPrint("连接超时 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      debugPrint("请求超时 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      debugPrint("响应超时 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      debugPrint("出现异常 Ծ‸ Ծ");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      debugPrint("请求取消 Ծ‸ Ծ");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      debugPrint("未知错误 Ծ‸ Ծ");
    }
  }

  _error(Function(BaseResult error) errorCallBack, BaseResult error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}
