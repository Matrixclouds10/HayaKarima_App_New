import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/models/file_id.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/error_response.dart';

import '../helpers/preferences_manager.dart';
import '../myDio.dart';

class ProfileProvider extends ChangeNotifier {
  Future uploadDocuments(Map<String, dynamic> requestData, Function callback) async {
    EasyLoading.show();
    notifyListeners();
    log("requestData >>>>" + requestData.toString());
    ApiResponse apiResponse = await NetworkRepo().updateProfile(requestData);
    EasyLoading.dismiss();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      callback(true, '');
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        log(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        log(errorResponse.errors![0].message!);
        errorMessage = errorResponse.errors![0].message!;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  Future deleteImage(FileId fileId, Function callback) async {
    EasyLoading.show();
    notifyListeners();
    ApiResponse apiResponse = await NetworkRepo().deleteImage(fileId);
    EasyLoading.dismiss();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      callback(true, '');
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        log(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        log(errorResponse.errors![0].message!);
        errorMessage = errorResponse.errors![0].message!;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  Future deleteDocument(FileId fileId, Function callback) async {
    EasyLoading.show();
    notifyListeners();
    ApiResponse apiResponse = await NetworkRepo().deleteDocument(fileId);
    EasyLoading.dismiss();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      callback(true, '');
      notifyListeners();
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        log(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        log(errorResponse.errors![0].message!);
        errorMessage = errorResponse.errors![0].message!;
      }
      callback(false, errorMessage);
      notifyListeners();
    }
  }

  dynamic changeImage({required String image}) async {
    notifyListeners();
    EasyLoading.show();
    // FormData body = FormData.fromMap({
    //   "image": await MultipartFile.fromFile(image),
    // });
    print(">>>>>>>>>>>>>>>>>>" + image);
    print('start Send Image ');
    dynamic updateImage = await myDio(
        url: "http://hayakarima.orbscope.net/api/users/edit-image",
        methodType: 'post',
        appLanguage: 'ar',
        dioHeaders: {
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${PreferencesManager.getString(PreferencesManager.token)}',
          'lang': 'ar'
        },
        dioBody: FormData.fromMap({
          "image": await MultipartFile.fromFile(image),
        }));
    print('updateImage =====> ' + updateImage.toString());

    if (updateImage['status'] == 'success') {
      EasyLoading.dismiss();

      print('ahm' + updateImage['message'].toString());
      print('ahm>>' + updateImage['items']['image'].toString());
      PreferencesManager.saveString('image', updateImage['items']['image']);

      // CollectionReference users =
      //     FirebaseFirestore.instance.collection('users');

      // PreferencesManager.saveString('image', updateImage['items']['image']);

      // await users
      //     .where("email", isEqualTo: LocalStorage.getString('email'))
      //     .get()
      //     .then((value) {
      //   value.docs.forEach((element) {
      //     element.reference
      //         .update({'photoUrl': LocalStorage.getString('image')});
      //   });
      // });

      notifyListeners();
      return updateImage;
    } else {
      EasyLoading.dismiss();
      notifyListeners();
      return updateImage;
    }
  }
}
