import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/governorate.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/login_request.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/error_response.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';

class AuthProvider extends ChangeNotifier {
  final List<Governorate> _governorates = [];
  bool _govsLoaded = false;

  Future login(LoginRequest request, Function callback) async {
    EasyLoading.show();
    notifyListeners();
    try {
      ApiResponse apiResponse = await NetworkRepo().login(request);

      EasyLoading.dismiss();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        User user = User.fromJson(apiResponse.response!.data['items']);
        if (user.isAccepted!) {
          PreferencesManager.save(user);
          PreferencesManager.saveString(PreferencesManager.token, user.token!);
          PreferencesManager.saveString('image', user.image!);
          log("image" + PreferencesManager.getString('image')!);
          await FirebaseHelper().updateFcmToken();
          callback(true, '');
        } else {
          callback(false, 'حسابك قيد المراجعة');
        }
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
    } catch (e) {
      EasyLoading.dismiss();
      callback(false, "Something went wrong ... please try again later");
    }
  }

  Future register(Map<String, dynamic> registerData, Function callback) async {
    EasyLoading.show();
    notifyListeners();
    ApiResponse apiResponse = await NetworkRepo().register(registerData);
    EasyLoading.dismiss();
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      User user = User.fromJson(apiResponse.response!.data['items']);
      if (user.isAccepted!) {
        PreferencesManager.save(user);
        PreferencesManager.saveString(PreferencesManager.token, user.token!);
        await FirebaseHelper().updateFcmToken();
        callback(true, '');
      } else {
        callback(false, 'حسابك قيد المراجعة');
      }
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

  Future<List<Governorate>> getGovernorates() async {
    if (!_govsLoaded) {
      EasyLoading.show();
      // notifyListeners();
      ApiResponse apiResponse = await NetworkRepo().getGoverns();
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        apiResponse.response!.data.forEach((data) => _governorates.add(Governorate.fromJson(data)));
      }
      log('Gov Count: ${_governorates.length}');
      for (var element in _governorates) {
        log('Gov Name: ${element.name}');
      }
      _govsLoaded = true;
      EasyLoading.dismiss();
    }
    // notifyListeners();
    return _governorates;
  }
}
