import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hayaah_karimuh/constants/strings.dart';
import 'package:hayaah_karimuh/data/echo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Dio> networkHeaderSetup(bool requireAuth) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(ACCESS_TOKEN);
    
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger());
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';

  dio.options.sendTimeout = Duration(milliseconds: 30000);
  dio.options.receiveTimeout =  Duration(milliseconds: 30000);
  dio.options.connectTimeout = Duration(milliseconds: 30000);
  if (token != null) dio.options.headers["authorization"] = "Bearer $token";
  if (Platform.isAndroid) dio.options.headers["type"] = 'android';
  if (Platform.isIOS) dio.options.headers["type"] = 'ios';

  if (requireAuth) if (token == null || token.isEmpty) return Future.error('auth');

  return dio;
}

String networkHandleError(DioError error, {bool canNavigate = true}) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      break;
    case DioErrorType.receiveTimeout:
      return 'network';
    case DioErrorType.sendTimeout:
      return 'network';
    case DioErrorType.badResponse:
      break;
    case DioErrorType.cancel:
      break;
    default:
      break;
  }

  if (error.response != null && error.response!.data != null) {
    String handledError = handleResponseError(error.response!);
    if (handledError == 'auth') {
    return "auth";
    }
    if (handledError.isNotEmpty) return handledError;
  } else if (error.response != null && error.response!.statusCode! == 400) {
    return 'server';
  } else if (error.response != null && error.response!.statusCode! == 401) {
    return "auth";
  }

  return 'server';
}

String handleResponseError(Response response) {
  //!check for Email error
  if (response.data['data'] != null && response.data['data']['errors'] != null && response.data['data']['errors']['email'] != null) {
    return '${response.data['data']['errors']['email']}';
  }

  //!check for Phone error
  if (response.data['data'] != null && response.data['data']['errors'] != null && response.data['data']['errors']['phone'] != null) {
    return '${response.data['data']['errors']['phone']}';
  }

  //!check for message_string error
  if (response.data['message_string'] != null) {
    if ('${response.data['message_string']}' == "invalid_token" || '${response.data['message_string']}' == "Unauthenticated" || '${response.data['message_string']}' == "Unauthenticated.") {
      return 'auth';
    }

    if ('${response.data['message_string']}' == "auth.invalid_token") return "auth";
    return '${response.data['message_string']}';
  }
  //!check for message error
  if (response.data['message'] != null) {
    if ('${response.data['message']}' == "invalid_token" || '${response.data['message']}' == "Unauthenticated" || '${response.data['message']}' == "Unauthenticated.") {
      return 'auth';
    }
  }
  kEchoError('handleResponseError ${response.data}');
  return '';
}
