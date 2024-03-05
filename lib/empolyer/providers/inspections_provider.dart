import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/models/inspection.dart';

import '../data/network_repo.dart';
import '../models/city.dart';
import '../models/responses/api_response.dart';
import '../models/responses/data_response.dart';

class InspectionsProvider extends ChangeNotifier {
  List<Inspection> inspections = [];
  int? totalPages;
  City? projectsList;
  bool showProjects = false;
  String? query;

  void selectProject(City independent) {
    // ignore: unnecessary_this
    this.projectsList = independent;
    notifyListeners();
  }

  Future<void> getInspections(int page) async {
    log('Selected Page -> $page');
    if (totalPages == null || page == 1 || (totalPages != null && page <= totalPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getInspections(page: page);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<Inspection> inspectionsResponse = DataResponse<Inspection>.fromJson(apiResponse.response!.data, (json) => Inspection.fromJson(json as Map<String, dynamic>));
        inspections.addAll(inspectionsResponse.items!.data!);
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
