import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'strings.dart';

//languages code
const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  print("----->setLocale : $languageCode");
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(language_code, languageCode);
  return Locale(languageCode);
}

Future<Locale> getLocale() async {
  print("----->call get_language ");
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final languagecode = prefs.getString(language_code) ?? "ar";
  print("----->getLocale : $languagecode");
  return Locale(languagecode);
}
