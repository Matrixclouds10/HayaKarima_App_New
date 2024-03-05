import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/error_response.dart';
import 'package:hayaah_karimuh/empolyer/utils/echo.dart';

Future<bool> networkAddInspection(Map<String, dynamic> requestData) async {
  try {
    ApiResponse apiResponse = await NetworkRepo().addInspection(requestData);
    if (apiResponse.response != null && (apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201)) {
      return true;
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message!;
      }
      return Future.error(errorMessage);
    }
  } catch (e) {
    kEchoError('addInspection error $e');
    return Future.error('Something went wrong ... please try again later');
  }
}
