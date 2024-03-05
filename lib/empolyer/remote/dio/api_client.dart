import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hayaah_karimuh/empolyer/helpers/app_constants.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/remote/dio/logging_interceptor.dart';
import 'package:hayaah_karimuh/empolyer/utils/echo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  final Dio _dio = Dio();

  ApiClient() {
    kEcho('token : ${PreferencesManager.getString(PreferencesManager.token).toString()}');
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = kDebugMode ? Duration(milliseconds: 60000) :Duration(milliseconds: 50000)
      ..options.receiveTimeout = kDebugMode ? Duration(milliseconds: 60000) :Duration(milliseconds: 50000)
      ..options.sendTimeout = kDebugMode ? Duration(milliseconds: 60000) :Duration(milliseconds: 50000)
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer ${PreferencesManager.getString(PreferencesManager.token)}', 'lang': 'ar'};
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger());
    }
  }

  Future<Response> sendFcmNotification(Map<String, dynamic> data) async {
    final Dio _dio = Dio();
    _dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = Duration(milliseconds: 50000)
      ..options.receiveTimeout = Duration(milliseconds: 50000)
      ..options.sendTimeout = Duration(milliseconds: 50000)
      ..httpClientAdapter
      ..options.headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=${AppConstants.firebaseServerKey}',
      };
    _dio.interceptors.add(LoggingInterceptor());
    try {
      var response = await _dio.post(
        AppConstants.firebaseLegacyApi,
        data: data,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await _dio.get(
        '${AppConstants.baseUrl}$path',
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getPagedData(
    String path,
    int page, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    log('Queries -> $queryParameters');
    try {
      var response = await _dio.get(
        '${AppConstants.baseUrl}$path?page=$page',
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    kEcho('link : ${AppConstants.baseUrl}$path');
    try {
      var response = await _dio.post(
        '${AppConstants.baseUrl}$path',
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await _dio.delete(
        '${AppConstants.baseUrl}$path',
        data: data,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postFormData(
    String path, {
    data,
    MultipartFile? file,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    // log('FormDataRequest: ${jsonEncode(data)}');
    var formData = FormData.fromMap(data);
    try {
      var response = await _dio.post(
        '${AppConstants.baseUrl}$path',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      rethrow;
    }
  }
}
