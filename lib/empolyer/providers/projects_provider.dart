import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/models/filter_governorate.dart';
import 'package:hayaah_karimuh/empolyer/models/filter_independent.dart';
import 'package:hayaah_karimuh/empolyer/models/filter_village.dart';
import 'package:hayaah_karimuh/empolyer/models/project.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/api_response.dart';
import 'package:hayaah_karimuh/empolyer/models/responses/data_response.dart';

import '../models/city.dart';
import '../models/filter_city.dart';

class ProjectsProvider extends ChangeNotifier {
  List<Project> projects = [];
  int? totalProjectsPages;

  FilterGovernorate? governorate;
  FilterCity? city;
  FilterVillage? village;
  FilterIndependent? independent;
  String? query;
  bool showFilter = false;
  bool showGovs = false;
  bool showCities = false;
  bool showVillages = false;
  bool showIndependents = false;
  City? benifitesTypes;

  void setSelectedGov(FilterGovernorate gov) {
    governorate = gov;
    setShowCities(true);
    city = null;
    setShowVillages(false);
    village = null;
    setShowIndependents(false);
    independent = null;
    notifyListeners();
  }

  void setSelectedCity(FilterCity city) {
    this.city = city;
    setShowVillages(true);
    village = null;
    setShowIndependents(true);
    independent = null;
    notifyListeners();
  }

  void setSelectedVillage(FilterVillage village) {
    this.village = village;
    setShowIndependents(false);
    independent = null;
    notifyListeners();
  }

  void setSelectedIndependent(FilterIndependent independent) {
    this.independent = independent;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    this.query = query;
    notifyListeners();
  }

  void setShowFilter(bool show) {
    showFilter = show;
    showGovs = show;
    if (!show) {
      showCities = show;
      showVillages = show;
      showIndependents = show;
      governorate = null;
      city = null;
      village = null;
      independent = null;
    }
    notifyListeners();
  }

  void setShowCities(bool show) {
    showCities = show;
    notifyListeners();
  }

  void setShowVillages(bool show) {
    showVillages = show;
    notifyListeners();
  }

  void setShowIndependents(bool show) {
    showIndependents = show;
    notifyListeners();
  }

  Future<void> getProjects({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalProjectsPages == null || page == 1 || (totalProjectsPages != null && page <= totalProjectsPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getProjects(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<Project> projectsResponse = DataResponse<Project>.fromJson(apiResponse.response!.data, (json) => Project.fromJson(json as Map<String, dynamic>));
        projects.addAll(projectsResponse.items!.data!);
        totalProjectsPages = projectsResponse.items!.pagination!.totalPages!;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> searchProjects({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalProjectsPages == null || page == 1 || (totalProjectsPages != null && page <= totalProjectsPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getProjects(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<Project> projectsResponse = DataResponse<Project>.fromJson(apiResponse.response!.data, (json) => Project.fromJson(json as Map<String, dynamic>));
        projects.clear();
        projects.addAll(projectsResponse.items!.data!);
        totalProjectsPages = projectsResponse.items!.pagination!.totalPages!;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
