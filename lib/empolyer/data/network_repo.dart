import 'package:dio/dio.dart';
import 'package:hayaah_karimuh/empolyer/helpers/app_constants.dart';
import 'package:hayaah_karimuh/empolyer/models/file_id.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/firebase_notification_request.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/login_request.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/save_notification_request.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';
import 'package:hayaah_karimuh/empolyer/remote/dio/api_client.dart';
import 'package:hayaah_karimuh/empolyer/remote/exception/api_error_handler.dart';

class NetworkRepo {
  Future<ApiResponse> login(LoginRequest request) async {
    try {
      Response response = await ApiClient().post(
        AppConstants.loginPath,
        data: request.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> logout() async {
    try {
      Response response = await ApiClient().post(
        AppConstants.logoutPath,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> readNotification({required int notificationId}) async {
    try {
      Response response = await ApiClient().post(
        AppConstants.readNotificationPath,
        data: {'notification_id': notificationId},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> saveNotification(SaveNotificationRequest request) async {
    try {
      Response response = await ApiClient().post(
        AppConstants.saveNotificationPath,
        data: request.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> notifyGroupMembers(FirebaseNotificationRequest request) async {
    try {
      Response response = await ApiClient().sendFcmNotification(request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteImage(FileId fileId) async {
    try {
      Response response = await ApiClient().post(
        AppConstants.deleteImagePath,
        data: fileId.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> deleteDocument(FileId fileId) async {
    try {
      Response response = await ApiClient().post(
        AppConstants.deleteDocumentPath,
        data: fileId.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getGoverns() async {
    try {
      Response response = await ApiClient().get(
        AppConstants.governsPath,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserNotifications() async {
    try {
      Response response = await ApiClient().get(AppConstants.notificationsPath, queryParameters: {'status': 0});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getNotificationsCount() async {
    try {
      Response response = await ApiClient().get(
        AppConstants.notificationCountPath,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> register(Map<String, dynamic> registerData) async {
    try {
      Response response = await ApiClient().postFormData(
        AppConstants.registerPath,
        data: registerData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateProfile(Map<String, dynamic> profileData) async {
    try {
      Response response = await ApiClient().postFormData(
        AppConstants.updateProfilePath,
        data: profileData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> addInspection(Map<String, dynamic> profileData) async {
    try {
      Response response = await ApiClient().postFormData(
        AppConstants.addInspectionsPath,
        data: profileData,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUsers() async {
    try {
      Response response = await ApiClient().get(
        AppConstants.userPath,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProjects({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.projectsPath, page, queryParameters: queries);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCountries({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.countriesPath, page, queryParameters: queries);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getGovernorates({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.governoratesPath, page, queryParameters: queries);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getCities({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.citiesPath, page, queryParameters: queries);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBenifetsType({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.benefetsPath, page, queryParameters: queries);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getVillages({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.villagesPath, page, queryParameters: queries);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getIndependents({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.independentsPath, page, queryParameters: queries);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getBeneficiaries({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(
        AppConstants.beneficiariesPath,
        page,
        queryParameters: queries,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getProjectsList({required int page, Map<String, dynamic>? queries}) async {
    try {
      Response response = await ApiClient().getPagedData(
        AppConstants.projectsListPath,
        page,
        queryParameters: queries,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getInspections({required int page}) async {
    try {
      Response response = await ApiClient().getPagedData(AppConstants.inspectionsPath, page);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
