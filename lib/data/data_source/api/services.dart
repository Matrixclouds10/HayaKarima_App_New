// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hayaah_karimuh/data/model/model_benefites_type.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_http_logger/pretty_http_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/strings.dart';
import '../../model/Model_About.dart';
import '../../model/model_about_home.dart';
import '../../model/model_beneficiaries.dart';
import '../../model/model_cities.dart';
import '../../model/model_complain.dart';
import '../../model/model_counters.dart';
import '../../model/model_donations.dart';
import '../../model/model_governments.dart';
import '../../model/model_idea_area.dart';
import '../../model/model_login.dart';
import '../../model/model_nationalities.dart';
import '../../model/model_news.dart';
import '../../model/model_partners.dart';
import '../../model/model_project.dart';

class Services {
  Future<Model_News> get_news(int page, var title, var date) async {
    String url_news = URL + "news?limit=20&page=$page$title$date";

    var url = Uri.parse(url_news);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    print("----->get_news");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_news : ${response.body.toString()}");

      if (statusCode == 200) {
        return Model_News.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_News.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Donations> get_donations(int page, String goverId, String cityId) async {
    String url_news = URL + "donations?&page=$page&government=$goverId&city=$cityId";

    var url = Uri.parse(url_news);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    print("----->get_donations");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_donations : ${response.body.toString()}");

      if (statusCode == 200) {
        return Model_Donations.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Donations.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Beneficiaries> get_beneficiaries(int page, String searchKey, dynamic beneficiary_type_id) async {
    String url_news = URL + "beneficiaries?search=$searchKey&page=$page&beneficiary_type_id=$beneficiary_type_id";

    var url = Uri.parse(url_news);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMDZmNjRhMjlmNmQxZDFkYTNhYTA4ZDNhZDViNzA5OGVjMDBjMzY4MTlkNTU0ZjQ0ZjdjZDUxN2ZhOWRlMWZlYjliZWY3NjIzNjUwNTI3YTgiLCJpYXQiOjE2NTA5NzY2NTQuOTAwNjY3OTA1ODA3NDk1MTE3MTg3NSwibmJmIjoxNjUwOTc2NjU0LjkwMDY3MjkxMjU5NzY1NjI1LCJleHAiOjE2ODI1MTI2NTQuODk1MTU3MDk4NzcwMTQxNjAxNTYyNSwic3ViIjoiMjI5Iiwic2NvcGVzIjpbXX0.nkuT2BhasHKdmfxNdgOTFKwP7nJDyXevJdWHqvcu8ZEuiXJSgYFHPAd7Aq9o-Whyg7U-K1LtEO3w6C5aERDuHWqEV8v8BVGVowYHOlH2WhDfyizfi-_lD2W8pol2PROKz2SnjApoQy6EF8UrP4vodlDhBVpMAPxv0M7ViJo72fz6EodsjRmA7eGjiNo4DXEocxMuLwovUITJ8qCFLum8yvxQOlzPILQQ1Gv1sBFF5Bk1K-8zSHXy98PlcukxkOaDDduKBiuU0vMeKZaTH3_PvXFkzzGWBmyKnXCOklD6lN5ZqJw5qcrCIHSUCrr41gBBvYply7yr5piPB9eGek6Q3Db6iaF-zhKVdASiVs2Pok9_Uil0b4XMeqd2CFRApVLyAD90G73uPppMuaF9kgSnh5XiFFC9hzaq9fLqqLV3kD1K9puapkfzVr6nGqIeVN9vKZSwnvpANn6fLOfGvTf4-XM8F22lStyTiEbXSrmFGuHujEwndoNFE0cjxNiZy3RtShV3ptQxR4ysD-SX-9JUHG2yJ3K-8ZS_0kk9V_Nz6lgIzqAxnPsW0IKZfcgtTDdrKIiv52Mrw2ZhEyH4KOiDLIws0PwVx9H3i8IAdDUz5zbVQTg_fFHnFYnoEc6EY7cwQWNCltBEx_TV0mD5EQrDGub3SxWYNNVeQYh0jTir1PM'
    };
    print("----->get_donations");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_donations : ${response.body.toString()}");

      if (statusCode == 200) {
        return Model_Beneficiaries.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Beneficiaries.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Project> get_project(int page, String SearchKey, dynamic goverId, dynamic cityId) async {
    // /projects?country=1&govern_id=&city=&limit=6
    String url_news = URL + "projects?search=$SearchKey&page=$page&govern_id=$goverId&city=$cityId";
    print("----->>>>>>>" + url_news);
    var url = Uri.parse(url_news);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMDZmNjRhMjlmNmQxZDFkYTNhYTA4ZDNhZDViNzA5OGVjMDBjMzY4MTlkNTU0ZjQ0ZjdjZDUxN2ZhOWRlMWZlYjliZWY3NjIzNjUwNTI3YTgiLCJpYXQiOjE2NTA5NzY2NTQuOTAwNjY3OTA1ODA3NDk1MTE3MTg3NSwibmJmIjoxNjUwOTc2NjU0LjkwMDY3MjkxMjU5NzY1NjI1LCJleHAiOjE2ODI1MTI2NTQuODk1MTU3MDk4NzcwMTQxNjAxNTYyNSwic3ViIjoiMjI5Iiwic2NvcGVzIjpbXX0.nkuT2BhasHKdmfxNdgOTFKwP7nJDyXevJdWHqvcu8ZEuiXJSgYFHPAd7Aq9o-Whyg7U-K1LtEO3w6C5aERDuHWqEV8v8BVGVowYHOlH2WhDfyizfi-_lD2W8pol2PROKz2SnjApoQy6EF8UrP4vodlDhBVpMAPxv0M7ViJo72fz6EodsjRmA7eGjiNo4DXEocxMuLwovUITJ8qCFLum8yvxQOlzPILQQ1Gv1sBFF5Bk1K-8zSHXy98PlcukxkOaDDduKBiuU0vMeKZaTH3_PvXFkzzGWBmyKnXCOklD6lN5ZqJw5qcrCIHSUCrr41gBBvYply7yr5piPB9eGek6Q3Db6iaF-zhKVdASiVs2Pok9_Uil0b4XMeqd2CFRApVLyAD90G73uPppMuaF9kgSnh5XiFFC9hzaq9fLqqLV3kD1K9puapkfzVr6nGqIeVN9vKZSwnvpANn6fLOfGvTf4-XM8F22lStyTiEbXSrmFGuHujEwndoNFE0cjxNiZy3RtShV3ptQxR4ysD-SX-9JUHG2yJ3K-8ZS_0kk9V_Nz6lgIzqAxnPsW0IKZfcgtTDdrKIiv52Mrw2ZhEyH4KOiDLIws0PwVx9H3i8IAdDUz5zbVQTg_fFHnFYnoEc6EY7cwQWNCltBEx_TV0mD5EQrDGub3SxWYNNVeQYh0jTir1PM'
    };

    print("----->get_project");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_project : ${response.body.toString()}");

      if (statusCode == 200) {
        return Model_Project.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Project.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<BeneficiaryTypeModel> get_BenfietsType() async {
    log('benffffits>>');
    print('----->benffffits>>');
    String url_news = URL + "beneficiary-types-list?limit=20";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMGRkNGQ1NzlmMTE5YzU3ODViZjUzZjYxZjUyOWMyNzhiOGMwNTA3OTAzNmM2YTM4ZWJiMWNmZWY1Yjk2OGZjNjJjMzRmZWNlYjJkMWJhYjgiLCJpYXQiOjE2NTA1MzMwMjYuMjcxMzU0OTEzNzExNTQ3ODUxNTYyNSwibmJmIjoxNjUwNTMzMDI2LjI3MTM2MTExMjU5NDYwNDQ5MjE4NzUsImV4cCI6MTY4MjA2OTAyNi4yNjY3ODk5MTMxNzc0OTAyMzQzNzUsInN1YiI6IjIyOSIsInNjb3BlcyI6W119.IAJ-4Lv42pa2KBIeXnEO1uXz0xJAQKRnT_IRQ1yO_6UtkbtPU4fh4nVSSzJ6FEJK-j-Nai286gHmqPDDSRsHkAVzEi2y9ffgMmvWEvSotT3yv58ALg0umATVdfL10iCS-gMplhvtQzwhzEhMk_Kfmx8w5NQhnMZsj8gHEcUVW8JpLxXcuHH01T0vbf_A5mmr63DTpC1HshmfjHRg5aoRdSO8dgBzn7aur-OatcojcraNB8w8jV4R3vujtzqCf4D0dzZU-aaVUgz_dA4h3y03d9MoLQjizrhAZAsKzWgLi6vm-e0AUOqCnGFnEUs_O1y1AxRWpNczDZCZLPhP5Pa7tYadTQY_nbXnNS9rzUqpeWcVGXcf54qOhMRSlIsaAJjxle3KmKxw4YzePPr-BzGNSjXI9TAOqIGR-6geNmbYoqmfViVsoxUaoToSO6rwXHZO3DwOSu1o6x-04LS8MlvPb30d6oQkarMgSjwSQU3GOkKzz9xmIykxudcC9CkwqAg6dk0CONBN3-jXJugoHumlOQL7o28uMrtn75DB_-WaMTuzVuZqwJGy73jStEXd-oxMtDzgglzE_Y4bL4cVx-XfKU6u-XxQlm5OW6rdk-TFZWe4eqCfpZg-N5zH9mNh-BJIr1Rp8LgvB0dhLfA0KJDypyYXFU0FuQHG09sTDJhHUxc"
    };
    print("----->get_BenifetsTypes");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_BenifetsTypes : ${response.body.toString()}");
      print("----->get_BenifetsTypes : ${response.request!.headers}");

      if (statusCode == 200) {
        return BeneficiaryTypeModel.fromJson(json.decode(response.body.toString()));
      } else {
        return BeneficiaryTypeModel.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Nationalities> get_nationalities() async {
    String url_news = URL + "nationalities-list?limit=247";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMGRkNGQ1NzlmMTE5YzU3ODViZjUzZjYxZjUyOWMyNzhiOGMwNTA3OTAzNmM2YTM4ZWJiMWNmZWY1Yjk2OGZjNjJjMzRmZWNlYjJkMWJhYjgiLCJpYXQiOjE2NTA1MzMwMjYuMjcxMzU0OTEzNzExNTQ3ODUxNTYyNSwibmJmIjoxNjUwNTMzMDI2LjI3MTM2MTExMjU5NDYwNDQ5MjE4NzUsImV4cCI6MTY4MjA2OTAyNi4yNjY3ODk5MTMxNzc0OTAyMzQzNzUsInN1YiI6IjIyOSIsInNjb3BlcyI6W119.IAJ-4Lv42pa2KBIeXnEO1uXz0xJAQKRnT_IRQ1yO_6UtkbtPU4fh4nVSSzJ6FEJK-j-Nai286gHmqPDDSRsHkAVzEi2y9ffgMmvWEvSotT3yv58ALg0umATVdfL10iCS-gMplhvtQzwhzEhMk_Kfmx8w5NQhnMZsj8gHEcUVW8JpLxXcuHH01T0vbf_A5mmr63DTpC1HshmfjHRg5aoRdSO8dgBzn7aur-OatcojcraNB8w8jV4R3vujtzqCf4D0dzZU-aaVUgz_dA4h3y03d9MoLQjizrhAZAsKzWgLi6vm-e0AUOqCnGFnEUs_O1y1AxRWpNczDZCZLPhP5Pa7tYadTQY_nbXnNS9rzUqpeWcVGXcf54qOhMRSlIsaAJjxle3KmKxw4YzePPr-BzGNSjXI9TAOqIGR-6geNmbYoqmfViVsoxUaoToSO6rwXHZO3DwOSu1o6x-04LS8MlvPb30d6oQkarMgSjwSQU3GOkKzz9xmIykxudcC9CkwqAg6dk0CONBN3-jXJugoHumlOQL7o28uMrtn75DB_-WaMTuzVuZqwJGy73jStEXd-oxMtDzgglzE_Y4bL4cVx-XfKU6u-XxQlm5OW6rdk-TFZWe4eqCfpZg-N5zH9mNh-BJIr1Rp8LgvB0dhLfA0KJDypyYXFU0FuQHG09sTDJhHUxc"
    };
    print("----->get_nationalities");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_nationalities : ${response.body.toString()}");
      print("----->get_nationalities : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_Nationalities.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Nationalities.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Idea_Area> get_idea_area() async {
    String url_news = URL + "idea-area-list?limit=50";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMGRkNGQ1NzlmMTE5YzU3ODViZjUzZjYxZjUyOWMyNzhiOGMwNTA3OTAzNmM2YTM4ZWJiMWNmZWY1Yjk2OGZjNjJjMzRmZWNlYjJkMWJhYjgiLCJpYXQiOjE2NTA1MzMwMjYuMjcxMzU0OTEzNzExNTQ3ODUxNTYyNSwibmJmIjoxNjUwNTMzMDI2LjI3MTM2MTExMjU5NDYwNDQ5MjE4NzUsImV4cCI6MTY4MjA2OTAyNi4yNjY3ODk5MTMxNzc0OTAyMzQzNzUsInN1YiI6IjIyOSIsInNjb3BlcyI6W119.IAJ-4Lv42pa2KBIeXnEO1uXz0xJAQKRnT_IRQ1yO_6UtkbtPU4fh4nVSSzJ6FEJK-j-Nai286gHmqPDDSRsHkAVzEi2y9ffgMmvWEvSotT3yv58ALg0umATVdfL10iCS-gMplhvtQzwhzEhMk_Kfmx8w5NQhnMZsj8gHEcUVW8JpLxXcuHH01T0vbf_A5mmr63DTpC1HshmfjHRg5aoRdSO8dgBzn7aur-OatcojcraNB8w8jV4R3vujtzqCf4D0dzZU-aaVUgz_dA4h3y03d9MoLQjizrhAZAsKzWgLi6vm-e0AUOqCnGFnEUs_O1y1AxRWpNczDZCZLPhP5Pa7tYadTQY_nbXnNS9rzUqpeWcVGXcf54qOhMRSlIsaAJjxle3KmKxw4YzePPr-BzGNSjXI9TAOqIGR-6geNmbYoqmfViVsoxUaoToSO6rwXHZO3DwOSu1o6x-04LS8MlvPb30d6oQkarMgSjwSQU3GOkKzz9xmIykxudcC9CkwqAg6dk0CONBN3-jXJugoHumlOQL7o28uMrtn75DB_-WaMTuzVuZqwJGy73jStEXd-oxMtDzgglzE_Y4bL4cVx-XfKU6u-XxQlm5OW6rdk-TFZWe4eqCfpZg-N5zH9mNh-BJIr1Rp8LgvB0dhLfA0KJDypyYXFU0FuQHG09sTDJhHUxc"
    };
    print("----->get_idea_area");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_idea_area : ${response.body.toString()}");
      print("----->get_idea_area : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_Idea_Area.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Idea_Area.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Counters> get_counters() async {
    String url_news = URL + "counters";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMGRkNGQ1NzlmMTE5YzU3ODViZjUzZjYxZjUyOWMyNzhiOGMwNTA3OTAzNmM2YTM4ZWJiMWNmZWY1Yjk2OGZjNjJjMzRmZWNlYjJkMWJhYjgiLCJpYXQiOjE2NTA1MzMwMjYuMjcxMzU0OTEzNzExNTQ3ODUxNTYyNSwibmJmIjoxNjUwNTMzMDI2LjI3MTM2MTExMjU5NDYwNDQ5MjE4NzUsImV4cCI6MTY4MjA2OTAyNi4yNjY3ODk5MTMxNzc0OTAyMzQzNzUsInN1YiI6IjIyOSIsInNjb3BlcyI6W119.IAJ-4Lv42pa2KBIeXnEO1uXz0xJAQKRnT_IRQ1yO_6UtkbtPU4fh4nVSSzJ6FEJK-j-Nai286gHmqPDDSRsHkAVzEi2y9ffgMmvWEvSotT3yv58ALg0umATVdfL10iCS-gMplhvtQzwhzEhMk_Kfmx8w5NQhnMZsj8gHEcUVW8JpLxXcuHH01T0vbf_A5mmr63DTpC1HshmfjHRg5aoRdSO8dgBzn7aur-OatcojcraNB8w8jV4R3vujtzqCf4D0dzZU-aaVUgz_dA4h3y03d9MoLQjizrhAZAsKzWgLi6vm-e0AUOqCnGFnEUs_O1y1AxRWpNczDZCZLPhP5Pa7tYadTQY_nbXnNS9rzUqpeWcVGXcf54qOhMRSlIsaAJjxle3KmKxw4YzePPr-BzGNSjXI9TAOqIGR-6geNmbYoqmfViVsoxUaoToSO6rwXHZO3DwOSu1o6x-04LS8MlvPb30d6oQkarMgSjwSQU3GOkKzz9xmIykxudcC9CkwqAg6dk0CONBN3-jXJugoHumlOQL7o28uMrtn75DB_-WaMTuzVuZqwJGy73jStEXd-oxMtDzgglzE_Y4bL4cVx-XfKU6u-XxQlm5OW6rdk-TFZWe4eqCfpZg-N5zH9mNh-BJIr1Rp8LgvB0dhLfA0KJDypyYXFU0FuQHG09sTDJhHUxc"
    };
    print("----->get_counters");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_counters : ${response.body.toString()}");
      print("----->get_counters : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_Counters.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Counters.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Complain> complain(Complain_Post complain_post) async {
    String url_order = URL + "complain/store";
    var url = Uri.parse(url_order);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiOWY4MjA3ZDc5OTIxMTc0N2Y0NDM5MmM4MjQwZWQwYTgzNDU1MDZlMDQ4NWY4ZjRkZWRhMzY1Mjg0ZGI2ZGY5MDFkNDk4MzFjMjRjMDBkOTgiLCJpYXQiOjE2NTA5MzM5MTMuNTQzOTcwMTA4MDMyMjI2NTYyNSwibmJmIjoxNjUwOTMzOTEzLjU0Mzk3NTExNDgyMjM4NzY5NTMxMjUsImV4cCI6MTY4MjQ2OTkxMy41Mzg5NzgwOTk4MjI5OTgwNDY4NzUsInN1YiI6IjIyOSIsInNjb3BlcyI6W119.smhE2noyl5wk9_wusJDS4VhRpGJCjKTteEssRVfIsxo7H66_8D8_pGiR9wRLeE5xDZAhUcWbRudw_LCM4-CNxfMM73xqtIUzp-lItK3m8kjJubF5lyjTYveG71NHybfYWEfFD-1HmH5zjYvXlWJzdbyEzt30zB6zZfm9uVvtUSNfKAucu_2R4mwS7OKOuQpqIm17EAW5lahukHZe46S49D6NUMzJgb6xIKlqJMj9oNjx4PrNxKGp4WW9zkswlJ_yCKSduj1u0CzgG2D7oPiLFJHuMfnyjFdaijfLLZ5dHRTS9EmawqwfxkF2C_B-2AG2ihAYK3bpoM08N1F11Bu4cxNb9ZsHlc3_iKRVqnEI421Ud_OtFVUQJiIfYq8sKTPtVQK_AKJhCiCNhQ_OPHZwHeniJNHLzu1iu1BRH7wvGnU8qVugb_uV_UQYWvuIeFXteyg3OL-wgUfScwBYHoaFqTpnRGl2W5836SLC3jbK6u9y1deMBytJas3VI2I2bWsU50DjfuZ7-eCmOdoDEEBCJ1ZDh4KNHnNpX-P8jCnsMwc5QQtaQPbLG5xeJ6an8Mk9sEAJyQoZrKhCwubOImACV5OHYAhMvDC3rZVqkl3CWcF8217xyrrzsHl38prZzTofmGxbSotawkVwWJ90DPe0NnA6EWd6dR0GNVdtOmctB2c"
    };
    var request = http.MultipartRequest("POST", url);
    print("----->complain : ${request.url}");
    print("----->complain : ${complain_post.nationality_id}");
    print("----->complain : ${request.files}");

    if (complain_post.national_id_photo.isNotEmpty && complain_post.national_id_photo.length > 3) {
      request.files.add(await http.MultipartFile.fromPath('national_id_photo[]', complain_post.national_id_photo));
    }
    request.files.add(http.MultipartFile.fromString('name', complain_post.name));
    request.files.add(http.MultipartFile.fromString('nationality_id', complain_post.country));
    request.files.add(http.MultipartFile.fromString('national_id', complain_post.nationality_id));
    request.files.add(http.MultipartFile.fromString('phone', complain_post.phone));
    request.files.add(http.MultipartFile.fromString('email', complain_post.email));
    request.files.add(http.MultipartFile.fromString('type', complain_post.type));
    request.files.add(http.MultipartFile.fromString('description', complain_post.description));
    request.files.add(http.MultipartFile.fromString('idea_area_id', complain_post.idea_area_id));

    request.headers.addAll(headers);

    http.Response response = await http.Response.fromStream(await request.send());
    print("----->complain : ${response.body.toString()}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      String re = response.body;
      // print('----->result update :  $re');
      return Model_Complain.fromJson(json.decode(response.body));
    } else {
      // print('----->result error:');
      throw Exception('faild to load');
    }
  }

  Future<Model_Partners> get_partners() async {
    String url_news = URL + "partners";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiMGRkNGQ1NzlmMTE5YzU3ODViZjUzZjYxZjUyOWMyNzhiOGMwNTA3OTAzNmM2YTM4ZWJiMWNmZWY1Yjk2OGZjNjJjMzRmZWNlYjJkMWJhYjgiLCJpYXQiOjE2NTA1MzMwMjYuMjcxMzU0OTEzNzExNTQ3ODUxNTYyNSwibmJmIjoxNjUwNTMzMDI2LjI3MTM2MTExMjU5NDYwNDQ5MjE4NzUsImV4cCI6MTY4MjA2OTAyNi4yNjY3ODk5MTMxNzc0OTAyMzQzNzUsInN1YiI6IjIyOSIsInNjb3BlcyI6W119.IAJ-4Lv42pa2KBIeXnEO1uXz0xJAQKRnT_IRQ1yO_6UtkbtPU4fh4nVSSzJ6FEJK-j-Nai286gHmqPDDSRsHkAVzEi2y9ffgMmvWEvSotT3yv58ALg0umATVdfL10iCS-gMplhvtQzwhzEhMk_Kfmx8w5NQhnMZsj8gHEcUVW8JpLxXcuHH01T0vbf_A5mmr63DTpC1HshmfjHRg5aoRdSO8dgBzn7aur-OatcojcraNB8w8jV4R3vujtzqCf4D0dzZU-aaVUgz_dA4h3y03d9MoLQjizrhAZAsKzWgLi6vm-e0AUOqCnGFnEUs_O1y1AxRWpNczDZCZLPhP5Pa7tYadTQY_nbXnNS9rzUqpeWcVGXcf54qOhMRSlIsaAJjxle3KmKxw4YzePPr-BzGNSjXI9TAOqIGR-6geNmbYoqmfViVsoxUaoToSO6rwXHZO3DwOSu1o6x-04LS8MlvPb30d6oQkarMgSjwSQU3GOkKzz9xmIykxudcC9CkwqAg6dk0CONBN3-jXJugoHumlOQL7o28uMrtn75DB_-WaMTuzVuZqwJGy73jStEXd-oxMtDzgglzE_Y4bL4cVx-XfKU6u-XxQlm5OW6rdk-TFZWe4eqCfpZg-N5zH9mNh-BJIr1Rp8LgvB0dhLfA0KJDypyYXFU0FuQHG09sTDJhHUxc"
    };
    print("----->get_partners");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_partners : ${response.body.toString()}");
      print("----->get_partners : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_Partners.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Partners.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Partners> get_sliders() async {
    String url_news = URL + "sliders";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjg4OTQ0ZTY5YTQ5YWY0Y2E2YzU2MzM2MWUyZGM4MTdlMzlkOWNlZmE4YjMzY2E1Mjc0ZTRkNTYwMTNhZjYxNTJhOTI5NDdlMDQ0NmI4NDkiLCJpYXQiOjE2NTAyMDAyMTYuMzAwNzgxOTY1MjU1NzM3MzA0Njg3NSwibmJmIjoxNjUwMjAwMjE2LjMwMDc4NjAxODM3MTU4MjAzMTI1LCJleHAiOjE2ODE3MzYyMTYuMjk2NjcyMTA1Nzg5MTg0NTcwMzEyNSwic3ViIjoiMjI5Iiwic2NvcGVzIjpbXX0.JS5yDzyLuDc0Tis6Ajcg4iOWcmsW1H2qX_wWuezoRPS4EMoCHHj57UKe4t4djFbCZkL9CRy-LVRIwEzPm9hwG_j1unwE0ZHsEFvWkvWUkzlqx4dK9P7tMHT1ZRQWjDL7FJ5-8-5vqpJpuBpDCKMcFW1vlLw5X03kAYRH8ka_0bgK0s7uV4UgkyR2y3ordz6sIJAQD9AEC9B1bnMk8ahGI1wKVGXykAKgM6D97dDodEbH9AH0lKCjX9GA4zAR6dRJVHQTsZIggzc1yYhpQaO_kFIe5P5xdx21YQ0veshnaEewbrs9kVF2aj7uaopWBPKvX-ARiKdU2Tcc2GcLaQawfqMwGxwhAdX0XPdiFB-6B7Pn2SGh5Dyy3z_8AY74nRL-ah-ettAWbj-M01lkzP7FGd91EV_jDMxazZ4lXqCXMwdozzy_MiTKo7xl1vUAemcP3lLg2_IKQeBeg2Xae65h4jQC0FZDzw5LZfo1d102RY7le4yCtHAU_dVpxop1ujAsF-Cvh84Q6hWbT2Vt6OOym6W4PcDhXECbp6Wk4KPymz7XT1l_sSLpItJB3OClLZkycnEw00mBzYKOtpp4re2u4yYBQRyHktd11e5TA8TIX5y7tOLh7FFuyqfh41h9Qxmrv50gSbxNQRccRX3pWkpZe8FeFVCCULVl8zR0hzwccl0"
    };
    print("----->get_partners");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_partners : ${response.body.toString()}");
      print("----->get_partners : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_Partners.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Partners.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Governments> get_governments() async {
    String url_news = URL + "governments-list?county_id=1&limit=27";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    print("----->get_governments");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_governments : ${response.body.toString()}");
      print("----->get_governments : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_Governments.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Governments.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_Cities> get_cities(var govern_id) async {
    String url_news = URL + "cities-list?govern_id=$govern_id&limit=10";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    print("----->get_cities");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_cities : ${response.body.toString()}");
      print("----->get_cities : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_Cities.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_Cities.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_About_Home> get_about_home() async {
    String url_news = URL + "about-home";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization':
          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNjg4OTQ0ZTY5YTQ5YWY0Y2E2YzU2MzM2MWUyZGM4MTdlMzlkOWNlZmE4YjMzY2E1Mjc0ZTRkNTYwMTNhZjYxNTJhOTI5NDdlMDQ0NmI4NDkiLCJpYXQiOjE2NTAyMDAyMTYuMzAwNzgxOTY1MjU1NzM3MzA0Njg3NSwibmJmIjoxNjUwMjAwMjE2LjMwMDc4NjAxODM3MTU4MjAzMTI1LCJleHAiOjE2ODE3MzYyMTYuMjk2NjcyMTA1Nzg5MTg0NTcwMzEyNSwic3ViIjoiMjI5Iiwic2NvcGVzIjpbXX0.JS5yDzyLuDc0Tis6Ajcg4iOWcmsW1H2qX_wWuezoRPS4EMoCHHj57UKe4t4djFbCZkL9CRy-LVRIwEzPm9hwG_j1unwE0ZHsEFvWkvWUkzlqx4dK9P7tMHT1ZRQWjDL7FJ5-8-5vqpJpuBpDCKMcFW1vlLw5X03kAYRH8ka_0bgK0s7uV4UgkyR2y3ordz6sIJAQD9AEC9B1bnMk8ahGI1wKVGXykAKgM6D97dDodEbH9AH0lKCjX9GA4zAR6dRJVHQTsZIggzc1yYhpQaO_kFIe5P5xdx21YQ0veshnaEewbrs9kVF2aj7uaopWBPKvX-ARiKdU2Tcc2GcLaQawfqMwGxwhAdX0XPdiFB-6B7Pn2SGh5Dyy3z_8AY74nRL-ah-ettAWbj-M01lkzP7FGd91EV_jDMxazZ4lXqCXMwdozzy_MiTKo7xl1vUAemcP3lLg2_IKQeBeg2Xae65h4jQC0FZDzw5LZfo1d102RY7le4yCtHAU_dVpxop1ujAsF-Cvh84Q6hWbT2Vt6OOym6W4PcDhXECbp6Wk4KPymz7XT1l_sSLpItJB3OClLZkycnEw00mBzYKOtpp4re2u4yYBQRyHktd11e5TA8TIX5y7tOLh7FFuyqfh41h9Qxmrv50gSbxNQRccRX3pWkpZe8FeFVCCULVl8zR0hzwccl0"
    };
    print("----->get_about_home");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_about_home : ${response.body.toString()}");
      print("----->get_about_home : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_About_Home.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_About_Home.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<Model_About> get_about() async {
    String url_news = URL + "about";
    var url = Uri.parse(url_news);
    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    print("----->get_about");
    HttpWithMiddleware httpz = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);
    return httpz.get(url, headers: headers).then((http.Response response) {
      final int statusCode = response.statusCode;
      print("----->get_about : ${response.body.toString()}");
      print("----->get_about : ${response.request!.headers}");

      if (statusCode == 200) {
        return Model_About.fromJson(json.decode(response.body.toString()));
      } else {
        return Model_About.fromJson(json.decode("${response.body.toString()} "));
      }
    });
  }

  Future<String?> getAuth() async {
    // print("----->call getAuth_Status ");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final is_auth = prefs.getString(STATUS);

    // print("----->getAuth_Status :  $is_auth");
    return is_auth ?? "is_notaction";
  }

  Future<String?> chang_auth(var change_auth) async {
    // print("----->call getAuth_Status ");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final is_auth = prefs.setString(STATUS, "$change_auth");

    // print("----->getAuth_Status :  $is_auth");
    return "is_Guest";
  }

  Future<bool> logout() async {
    print("----->call get_token ");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(ACCESS_TOKEN);
    prefs.remove(STATUS);
    return true;
  }

  // Future<String?> get_language() async {
  //   print("----->call get_language ");
  //   final SharedPreferences prefs =await SharedPreferences.getInstance() ;
  //   final  languagecode = prefs.getString(language_code);
  //   return languagecode;
  // }

  setToken(String? access_token, var status) {
    // print("----->call setToken $access_token");
    SharedPreferences.getInstance().then((pref) {
      pref.setString(ACCESS_TOKEN, "$access_token");
      pref.setString(STATUS, status);
      print("----->done save token");
    });
  }

  saveData({
    String? access_token,
    var status,
    required String name,
    required String phone,
    required String city,
    required String government,
    required String email,
    required String image,
  }) {
    // print("----->call setToken $access_token");
    SharedPreferences.getInstance().then((pref) {
      pref.setString(ACCESS_TOKEN, "$access_token");
      pref.setString(UserName, name);
      pref.setString(UserPhone, phone);
      pref.setString(UserEmail, email);
      pref.setString(UserCity, city);
      pref.setString(UserGovernment, government);
      pref.setString(UserImage, image);
      print("----->  done save user Data" + name);
    });
  }

  Future<String?> get_token() async {
    // print("----->call get_token ");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(ACCESS_TOKEN);
    // print("----->call get_token $token ");

    return token;
  }

  Future<Model_Login> UpdateImage(var image) async {
    String url_order = URL + "citizens/users/edit-image";
    var url = Uri.parse(url_order);
    var request = http.MultipartRequest("POST", url);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString(ACCESS_TOKEN);
    print("----->tokeeeen >>>" + token.toString());
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': "Bearer " + token!,
    };
    request.files.add(http.MultipartFile('image', File(image).readAsBytes().asStream(), File(image).lengthSync(), filename: image.split("/").last));
    request.headers.addAll(headers);

    http.Response response = await http.Response.fromStream(await request.send());

    print("----->change image ::: ${request.url.toString()}");
    print("----->change image body ::: ${response.body.toString()}");

    if (response.statusCode == 200) {
      print("----->user image data >>");

      Model_Login m = Model_Login.fromJson(json.decode(response.body));
      print("----->user image data doneee >>" + m.toString());

      pref.setString(UserImage, m.items!.image);
      return Model_Login.fromJson(json.decode(response.body.toString()));
    } else {
      print('----->no data');
      return Model_Login.fromJson(json.decode("${response.body.toString()} "));
    }
  }

  Future<Model_Login> login(var phone, var password) async {
    String url_order = URL + "citizens/login";
    var url = Uri.parse(url_order);
    // print("----->url login  ${url}");

    var request = http.MultipartRequest("POST", url);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    request.files.add(http.MultipartFile.fromString('phone', phone));
    request.files.add(http.MultipartFile.fromString('password', password));

    request.headers.addAll(headers);

    http.Response response = await http.Response.fromStream(await request.send());

    print("----->login ::: ${request.url.toString()}");
    print("----->login body ::: ${response.body.toString()}");
    print("----->login body ::: ${response.statusCode.toString()}");

    if (response.statusCode == 200) {
      Model_Login m = Model_Login.fromJson(json.decode(response.body));
      print("----->user data" + m.toString());
      // setToken(m.items!.token, "is_auth");
      saveData(
        name: m.items!.name,
        phone: m.items!.phone,
        city: m.items!.city,
        government: m.items!.govern,
        email: m.items!.email,
        image: m.items!.image,
        access_token: m.items!.token,
      );
      return Model_Login.fromJson(json.decode(response.body.toString()));
    } else {
      print('----->no data');
      return Future.error(Model_Login.fromJson(json.decode(response.body.toString())).message);
    }
  }

  Future<Model_Login> reg(var name, var email, var city_id, var phone, var password, var governmentId) async {
    String url_order = URL + "citizens/register";
    var url = Uri.parse(url_order);
    var request = http.MultipartRequest("POST", url);

    Map<String, String> headers = {
      'Accept': 'application/json',
    };
    print("----->jjjjjjjjj>>>>");
    //  var requestBody = {
    //     'name':name,
    //     'email':email,
    //     'city_id':city_id,
    //     'govern_id':governmentId,
    //     'phone':phone,
    //     'password': password,
    //     'confirm_password': password,
    //   };

    request.files.add(http.MultipartFile.fromString('name', name));
    request.files.add(http.MultipartFile.fromString('email', email));
    request.files.add(http.MultipartFile.fromString('city_id', city_id));
    request.files.add(http.MultipartFile.fromString('govern_id', governmentId));
    request.files.add(http.MultipartFile.fromString('phone', phone));
    request.files.add(http.MultipartFile.fromString('password', password));
    request.files.add(http.MultipartFile.fromString('confirm_password', password));

    request.headers.addAll(headers);
    print("----->aaaaaa>>>>");

    print(request.files);
    http.Response response = await http.Response.fromStream(await request.send());

    print("----->login ::: ${request.url.toString()}");
    print("----->login ::: ${response.body.toString()}");

    if (response.statusCode == 200) {
      Model_Login m = Model_Login.fromJson(json.decode(response.body));

      return Model_Login.fromJson(json.decode(response.body.toString()));
    } else {
      return Model_Login.fromJson(json.decode("${response.body.toString()} "));
    }
  }

  Future<Model_Login> editProfile(
    var name,
    var email,
    var city_id,
    var phone,
    var password,
    var governmentId,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(ACCESS_TOKEN);
    print("----->tokeen>>>" + token.toString());
    String url_order = URL + "citizens/users/edit";
    var url = Uri.parse(url_order);

    var request = http.MultipartRequest("POST", url);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': "Bearer " + token!,
    };
    request.files.add(http.MultipartFile.fromString('name', name));
    request.files.add(http.MultipartFile.fromString('email', email));
    request.files.add(http.MultipartFile.fromString('city_id', city_id));
    request.files.add(http.MultipartFile.fromString('govern_id', governmentId));
    request.files.add(http.MultipartFile.fromString('phone', phone));
    request.files.add(http.MultipartFile.fromString('password', password));

    request.headers.addAll(headers);

    http.Response response = await http.Response.fromStream(await request.send());

    print("----->edit Profile ::: ${request.url.toString()}");
    print("----->edit Profile ::: ${response.body.toString()}");
    print("----->edit Profile ::: ${response.statusCode.toString()}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.body.toString().contains('You Are Not Authenticated')) {
        // Navigator.pushNamed(context, Login);
        return Future.error('You Are Not Authenticated');
      }
      Model_Login m = Model_Login.fromJson(json.decode(response.body));
      saveData(name: m.items!.name, phone: m.items!.phone, city: m.items!.city, government: m.items!.govern, email: m.items!.email, image: m.items!.image);
      return Model_Login.fromJson(json.decode(response.body.toString()));
    } else {
      return Model_Login.fromJson(json.decode("${response.body.toString()} "));
    }
  }

  Future<bool> deleteProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(ACCESS_TOKEN);
    String url_order = URL + "citizens/users/delete";
    var url = Uri.parse(url_order);

    var request = http.MultipartRequest("POST", url);

    Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': "Bearer " + token!,
    };
    request.headers.addAll(headers);

    http.Response response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      return true;
    } else {
      return false;
    }
  }
}
