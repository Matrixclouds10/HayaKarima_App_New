import 'package:bloc/bloc.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../constants/language_constants.dart';

part 'langouage_state.dart';

class LangouageCubit extends Cubit<Locale> {
  LangouageCubit() : super(const Locale('ar'));

  get_language(BuildContext context) async {
    print("----->LangouageCubit ");

    getLocale().then((value) {
      emit(value);
      // Intl.defaultLocale="$value";
      print("----->LangouageCubit ${value.languageCode}");
    });
  }

  set_language(String languageCode, BuildContext context) async {
    setLocale(languageCode).then((value) {
      emit(value);
      Intl.defaultLocale = "$value";
      context.setLocale(Locale(Intl.defaultLocale.toString()));
    });
  }
}
