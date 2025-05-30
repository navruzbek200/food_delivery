import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../common/constants/api_url.dart';

class DioClient {
  late final Dio _dio;
  var logger = Logger();

  DioClient() {
    _dio = Dio()
      ..options.baseUrl = ApiUrls.baseUrl
      // ..options.contentType = "application/json"
      ..options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..options.responseType = ResponseType.json;


    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    if (!kReleaseMode) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final HttpClient client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }


  Future<Response<dynamic>> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      logger.i("GET Request to $url");
      logger.i("Query Parameters: $queryParameters");

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      logger.i("Response from $url: ${response.data}");
      return response;
    } on DioException catch (e) {
      logger.e("‼️ GET Error to $url", error: e, stackTrace: e.stackTrace);
      logger.e("Error Details:", error: {
        'url': e.requestOptions.uri.toString(),
        'method': e.requestOptions.method,
        'headers': e.requestOptions.headers,
        'data': e.requestOptions.data,
        'response': e.response?.data,
        'statusCode': e.response?.statusCode,
      });
      rethrow;
    }
  }



  Future<Response<dynamic>> post(
      String url, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      logger.i("POST Request to $url");
      logger.i("Request Data: $data");

      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      logger.i("Response from $url: ${response.data}");
      return response;
    } on DioException catch (e) {
      logger.e("‼️ POST Error to $url", error: e, stackTrace: e.stackTrace);
      logger.e("Error Details:", error: {
        'url': e.requestOptions.uri.toString(),
        'method': e.requestOptions.method,
        'headers': e.requestOptions.headers,
        'data': e.requestOptions.data,
        'response': e.response?.data,
        'statusCode': e.response?.statusCode,
      });
      rethrow;
    }
  }

  Future<Response<dynamic>> put(
      String url,
      {
        Object? data,
        Map<String,dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async{
    try{
      final response = await _dio.put(
        url,
        queryParameters: queryParameters,
        options: options,
        data: data,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        onSendProgress: onSendProgress,
      );
      return response;
    } on DioException{
      rethrow;
    }
  }

  Future<Response<dynamic>> delete(
      String url,
      {
        Object? data,
        Map<String,dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
      }) async{
    try{
      final response = await _dio.delete(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException{
      rethrow;
    }
  }
}