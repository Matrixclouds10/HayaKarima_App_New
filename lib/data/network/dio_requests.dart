import 'package:dio/dio.dart';
import 'package:hayaah_karimuh/data/echo.dart';

import 'network_setup.dart';

Future<Response> networkPost({
  required String url,
  Map<String, dynamic>? params,
  Map<String, dynamic>? data,
  FormData? formData,
  bool requiredAuth = false,
}) async {
  String bodyData = '';
  if (params != null) {
    params.forEach((key, value) {
      bodyData = bodyData + '$key:$value, ';
      kEcho('$key: $value');
    });
  }
  if (data != null) {
    data.forEach((key, value) {
      bodyData = bodyData + '$key:$value, ';
      kEcho('$key: $value');
    });
  }
  if (formData != null)
    for (var element in formData.fields) {
      bodyData = bodyData + '$element, ';
      kEcho('formData $element:');
    }
  // if (!kDebugMode) await Sentry.captureMessage('url:$url', params: [bodyData]);
  Dio dio = await networkHeaderSetup(requiredAuth);

  try {
    Response response = await dio.post(url, queryParameters: params, data: data ?? formData ?? params);
    // if (!kDebugMode) Sentry.captureMessage('response:$url', params: ['${response.data}'], template: 'template');
    return response;
  } on DioError catch (error) {
    // if (!kDebugMode) Sentry.captureException('network $url $error');
    return Future.error(networkHandleError(error));
  }
}
