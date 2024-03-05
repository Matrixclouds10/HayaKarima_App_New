import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/models/beneficiary.dart';
import 'package:hayaah_karimuh/empolyer/models/city.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';

import '../models/responses/data_response.dart';

class BeneficiariesProvider extends ChangeNotifier {
  List<Beneficiary> beneficiaries = [];
  int? totalPages;
  String? query;
  bool showFilter = false;
  City? benifitesTypes;
  bool showCities = false;
  bool showIndependents = false;

  Future<void> getBeneficiaries(int page) async {
    log('Selected Page -> $page');
    if (totalPages == null || page == 1 || (totalPages != null && page <= totalPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getBeneficiaries(page: page);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<Beneficiary> beneficiariesResponse = DataResponse<Beneficiary>.fromJson(apiResponse.response!.data, (json) => Beneficiary.fromJson(json as Map<String, dynamic>));
        beneficiaries.addAll(beneficiariesResponse.items!.data!);
        totalPages = beneficiariesResponse.items!.pagination!.totalPages!;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  void selectBenifetsTyp(City independent) {
    // ignore: unnecessary_this
    this.benifitesTypes = independent;
    notifyListeners();
  }

  void setShowFilter(bool show) {
    showFilter = show;
    if (!show) {
      showCities = show;
      benifitesTypes = null;
    }
    notifyListeners();
  }

  void setSearchQuery(String query) {
    this.query = query;
    notifyListeners();
  }

  Future<void> searchBenefets({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalPages == null || page == 1 || (totalPages != null && page <= totalPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getBeneficiaries(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<Beneficiary> BeneficiarysResponse = DataResponse<Beneficiary>.fromJson(apiResponse.response!.data, (json) => Beneficiary.fromJson(json as Map<String, dynamic>));
        beneficiaries.clear();
        beneficiaries.addAll(BeneficiarysResponse.items!.data!);
        totalPages = BeneficiarysResponse.items!.pagination!.totalPages!;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
