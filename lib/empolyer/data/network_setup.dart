// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:hayaah_karimuh/empolyer/utils/echo.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Future<Dio> networkHeaderSetup(bool requireAuth) async {
//   YemenyPrefs prefs = YemenyPrefs();
//   String? token = prefs.getBearerToken();
//   kEcho('networkHeaderSetup $token');

//   Dio dio = new Dio();
//   dio.interceptors.add(PrettyDioLogger());
//   // dio.interceptors.add(LogInterceptor(responseBody: true));
//   if (!kIsWeb) dio.options.headers['content-Type'] = 'application/json';
//   if (!kIsWeb) dio.options.headers['Accept'] = 'application/json';
//   if (token != null) dio.options.headers["authorization"] = "Bearer $token";
//   if (!kIsWeb && Platform.isAndroid) dio.options.headers["type"] = 'android';
//   if (!kIsWeb && Platform.isIOS) dio.options.headers["type"] = 'ios';
//   if (kIsWeb) dio.options.headers["type"] = 'web';
//   if (kIsWeb) {
//     // dio.options.headers["Access-Control-Allow-Origin"] = "*";
//     // // dio.options.headers["Access-Control-Allow-Credentials"] = true;
//     // // dio.options.headers["Access-Control-Allow-Headers"] = "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale";
//     // dio.options.headers["Access-Control-Allow-Methods"] = "POST, OPTIONS";

//     dio.options.headers['Access-Control-Allow-Origin'] = "*";
//     dio.options.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Cookie, X-CSRF-TOKEN, Accept, Authorization, X-XSRF-TOKEN, Access-Control-Allow-Origin';
//     dio.options.headers['Access-Control-Expose-Headers'] = 'Authorization, authenticated';
//     dio.options.headers['Access-Control-Allow-Methods'] = 'GET, POST, PATCH, PUT, OPTIONS';
//     dio.options.headers['Access-Control-Allow-Credentials'] = 'true';
//   }

//   dio.options.sendTimeout = 30000;
//   dio.options.receiveTimeout = 30000;
//   dio.options.connectTimeout = 30000;

//   if (requireAuth) {
//     kEchoError('requireAuth true');
//     if (token == null || token.isEmpty) {
//       return Future.error('auth');
//     }
//   }

//   return dio;
// }

// String networkHandleError(DioError error, {bool canNavigate = true}) {
//   switch (error.type) {
//     case DioErrorType.connectTimeout:
//       kEchoError('e1 DioErrorType.connectTimeout');
//       break;
//     case DioErrorType.receiveTimeout:
//       kEchoError('e1 DioErrorType.receiveTimeout');
//       break;
//     case DioErrorType.sendTimeout:
//       kEchoError('e1 DioErrorType.sendTimeout');
//       break;
//     case DioErrorType.connectTimeout:
//       kEchoError('e1 DioErrorType.connectTimeout');
//       break;
//     case DioErrorType.response:
//       kEchoError('e1 DioErrorType.response');
//       break;
//     case DioErrorType.cancel:
//       kEchoError('e1 DioErrorType.cancel');
//       break;
//     default:
//       kEchoError('e1 DioErrorType.default');
//       break;
//   }

//   if (error.response != null && error.response!.statusCode! == 400) {
//     return 'server';
//   } else if (error.response != null && error.response!.statusCode! == 401) {
//     return "auth";
//   } else if (error.response != null && error.response!.statusCode! == 500)
//     return 'server';
//   else
//     return 'network';
// }
