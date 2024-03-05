import 'dart:convert';

import 'package:hayaah_karimuh/constants/strings.dart';
import 'package:hayaah_karimuh/data/model/model_benefites_type.dart';
import 'package:hayaah_karimuh/presentation/bottom_bar/profile/profile_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data_source/api/services.dart';
import '../data_source/local/local.dart';
import '../model/Model_About.dart';
import '../model/model_about_home.dart';
import '../model/model_beneficiaries.dart';
import '../model/model_cache/model_cache.dart';
import '../model/model_cities.dart';
import '../model/model_complain.dart';
import '../model/model_counters.dart';
import '../model/model_donations.dart';
import '../model/model_governments.dart';
import '../model/model_idea_area.dart';
import '../model/model_login.dart';
import '../model/model_nationalities.dart';
import '../model/model_news.dart';
import '../model/model_partners.dart';
import '../model/model_project.dart';

class Repository {
  late Services services;
  late Data_Local data_local;

  Repository(this.services, this.data_local);

  Future<Model_News> get_news(int page, var title, var date) async {
    final model = await services.get_news(
      page,
      title,
      date,
    );
    return model;
  }

  Future<bool> deleteProfile() async {
    final model = await services.deleteProfile();
    return model;
  }

  Future<Model_Nationalities> get_nationalities() async {
    final model = await services.get_nationalities();
    return model;
  }

  Future<Model_Idea_Area> get_idea_area() async {
    final model = await services.get_idea_area();
    return model;
  }

  Future<Model_Complain> complain(Complain_Post complainPost) async {
    final model = await services.complain(complainPost);
    return model;
  }

  Future<Model_Counters> get_counters() async {
    final model = await services.get_counters();
    return model;
  }

  Future<BeneficiaryTypeModel> get_BenfietsType() async {
    final model = await services.get_BenfietsType();
    return model;
  }

  Future<Model_Partners> get_partners() async {
    final model = await services.get_partners();
    return model;
  }

  Future<Model_Partners> get_sliders() async {
    final model = await services.get_sliders();
    return model;
  }

  Future<Model_About_Home> get_about_home() async {
    final model = await services.get_about_home();
    return model;
  }

  Future<Model_About> get_about() async {
    final model = await services.get_about();
    return model;
  }

  Future<List<Model_Cache_Setting>> getall_setting_local() async {
    final list = await data_local.getall_setting_local();
    return list;
  }

  Future<void> add_setting_local(Model_Cache_Setting modelCacheSetting) async {
    await data_local.add_setting_local(modelCacheSetting);
  }

  Future<void> delete_all_setting_local(var tittle) async {
    await data_local.delete_all_setting_local(tittle);
  }

  Future<Model_Donations> get_donations(int page, String goverId, String cityId) async {
    final model = await services.get_donations(page, goverId, cityId);
    return model;
  }

  Future<Model_Beneficiaries> get_beneficiaries(int page, String searchKey, dynamic beneficiaryTypeId) async {
    final model = await services.get_beneficiaries(page, searchKey, beneficiaryTypeId);
    return model;
  }

  Future<Model_Project> get_project(int page, String SearchKey, dynamic goverId, dynamic cityId) async {
    final model = await services.get_project(page, SearchKey, goverId, cityId);
    return model;
  }

  Future<Model_Login> login(var phone, var password) async {
    final model = await services.login(phone, password);
    return model;
  }

  Future<Model_Login> changeImage(var image) async {
    final model = await services.UpdateImage(image);
    return model;
  }

  Future<String?> Auth0UI() async {
    final auth = await services.getAuth();
    // print("Repository_Auth :  $auth");

    return auth;
  }

  Future<String?> get_token() async {
    final token = await services.get_token();
    // print("get_token :  $token");
    return token;
  }

  Future<String?> chang_auth(var changeAuth) async {
    final changAuth = await services.chang_auth(changeAuth);
    return changAuth;
  }

  Future<Model_Governments> get_governments() async {
    final model = await services.get_governments();
    return model;
  }

  Future<Model_Cities> get_cities(var governId) async {
    final model = await services.get_cities(governId);
    return model;
  }

  Future<Model_Login> reg({var name, var email, var city_id, var phone, var password, var governmentId}) async {
    final model = await services.reg(name, email, city_id, phone, password, governmentId);
    return model;
  }

  Future<Model_Login> editProfile(var name, var email, var cityId, var phone, var password, var governmentId) async {
    final model = await services.editProfile(name, email, cityId, phone, password, governmentId);
    return model;
  }

  Future<ProfileResponse> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(ACCESS_TOKEN);
    var url = Uri.parse(URL + "profile");

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': "Bearer " + token!,
    };
    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.toString().contains('You Are Not Authenticated')) {
        // Navigator.pushNamed(context, Login);
        return Future.error('You Are Not Authenticated');
      }
      ProfileResponse m = ProfileResponse.fromJson(json.decode(response.body));
      return m;
    } else {
      return Future.error('Oops! Something went wrong.');
    }
  }
}
