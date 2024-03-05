import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/error_response.dart';

import '../helpers/preferences_manager.dart';
import '../models/user.dart';

class EditProfileProvider extends ChangeNotifier {
  Future editProfile(Map<String, dynamic> requestData, Function callback) async {
    EasyLoading.show();
    notifyListeners();
    ApiResponse apiResponse = await NetworkRepo().updateProfile(requestData);
    EasyLoading.dismiss();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      User user = User.fromJson(apiResponse.response!.data['items']);
      print('mobarkkkkk' + user.toString());

      if (user.isAccepted!) {
        print('mobarkkkkk' + user.toString());
        PreferencesManager.save(user);
      }
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
}
