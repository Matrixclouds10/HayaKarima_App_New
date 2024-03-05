import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/models/city.dart';

import '../data/network_repo.dart';
import '../models/filter_city.dart';
import '../models/filter_governorate.dart';
import '../models/filter_independent.dart';
import '../models/filter_village.dart';
import '../models/responses/api_response.dart';
import '../models/responses/data_response.dart';

class FilterProvider extends ChangeNotifier {
  List<FilterGovernorate> governorates = [];
  List<FilterCity> cities = [];
  List<City> benifetsList = [];
  List<City> projectsList = [];
  List<FilterVillage> villages = [];
  List<FilterIndependent> independents = [];
  int? totalGovernoratesPages;
  int? totalCitiesPages;
  int? totalBenifetsPages;
  int? totalProjectsPages;
  int? totalVillagesPages;
  int? totalIndependentsPages;

  Future<void> getGovernorates({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalGovernoratesPages == null || page == 1 || (totalGovernoratesPages != null && page <= totalGovernoratesPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getGovernorates(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<FilterGovernorate> governoratesResponse =
            DataResponse<FilterGovernorate>.fromJson(apiResponse.response!.data, (json) => FilterGovernorate.fromJson(json as Map<String, dynamic>));
        governorates.addAll(governoratesResponse.items!.data!);
        totalGovernoratesPages = governoratesResponse.items!.pagination!.totalPages!;
        log('Total Gov Pages -> $totalGovernoratesPages');
        log('Govs Count -> ${governorates.length}');
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> getCities({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalCitiesPages == null || page == 1 || (totalCitiesPages != null && page <= totalCitiesPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getCities(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<FilterCity> citiesResponse = DataResponse<FilterCity>.fromJson(apiResponse.response!.data, (json) => FilterCity.fromJson(json as Map<String, dynamic>));
        cities.addAll(citiesResponse.items!.data!);
        totalCitiesPages = citiesResponse.items!.pagination!.totalPages!;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> getBenifetsTypes({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalBenifetsPages == null || page == 1 || (totalBenifetsPages != null && page <= totalBenifetsPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getBenifetsType(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<City> benifetsResponse = DataResponse<City>.fromJson(apiResponse.response!.data, (json) => City.fromJson(json as Map<String, dynamic>));
        log("benefits Type >>" + apiResponse.response!.data['data'].toString());
        benifetsList.addAll((apiResponse.response!.data['data'] as List).map((e) => City.fromJson(e)).toList());
        totalBenifetsPages = apiResponse.response!.data['pagination']['totalPages'];
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> getProjectsList({required int page}) async {
    log('Selected Page -> $page');
    if (totalProjectsPages == null || page == 1 || (totalProjectsPages != null && page <= totalProjectsPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getProjectsList(
        page: page,
      );
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<City> projectsListResponse = DataResponse<City>.fromJson(apiResponse.response!.data, (json) => City.fromJson(json as Map<String, dynamic>));
        log("projects Type >>" + projectsListResponse.items!.data.toString());
        projectsList.addAll(projectsListResponse.items!.data!);
        totalProjectsPages = projectsListResponse.items!.pagination!.totalPages;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> getVillages({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalVillagesPages == null || page == 1 || (totalVillagesPages != null && page <= totalVillagesPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getVillages(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<FilterVillage> villagesResponse = DataResponse<FilterVillage>.fromJson(apiResponse.response!.data, (json) => FilterVillage.fromJson(json as Map<String, dynamic>));
        villages.addAll(villagesResponse.items!.data!);
        totalVillagesPages = villagesResponse.items!.pagination!.totalPages!;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  Future<void> getIndependents({required int page, Map<String, dynamic>? queries}) async {
    log('Selected Page -> $page');
    if (totalIndependentsPages == null || page == 1 || (totalIndependentsPages != null && page <= totalIndependentsPages!)) {
      EasyLoading.show();
      ApiResponse apiResponse = await NetworkRepo().getIndependents(page: page, queries: queries);
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
        final DataResponse<FilterIndependent> independentsResponse =
            DataResponse<FilterIndependent>.fromJson(apiResponse.response!.data, (json) => FilterIndependent.fromJson(json as Map<String, dynamic>));
        independents.addAll(independentsResponse.items!.data!);
        totalIndependentsPages = independentsResponse.items!.pagination!.totalPages!;
      }
      EasyLoading.dismiss();
      notifyListeners();
    }
  }
}
