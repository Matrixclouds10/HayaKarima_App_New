// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/bloc/benifetsType/benifets_bloc.dart';
import '../../bloc/cities/cities_bloc.dart';
import '../../bloc/counters/counters_bloc.dart';
import '../../bloc/country_list/flight_country_list_bloc.dart';
import '../../bloc/governments/governments_bloc.dart';
import '../../data/model/model_benefites_type.dart';
import '../../data/model/model_governments.dart';
import '../../data/model/model_nationalities.dart';
import '../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';

class Widget_DropdownMenu_BenifetsType extends StatelessWidget {
  final onSaved;
  final onChanged;
  final icon;

  Widget_DropdownMenu_BenifetsType(
      {required this.onSaved, required this.onChanged, required this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<BenfetsBloc, BenfietsState>(builder: (context, state) {
      if (state is Benfiets_Loaded_State) {
        BeneficiaryTypeModel model_Benifites_list = (state).model;
        return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: SafeArea(
                child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: DropdownButtonFormField(
                // menuMaxHeight: 50.w,
                onSaved: onSaved,
                validator: (var val) {
                  if (val == null) {
                    return "${LocaleKeys.City.tr()}";
                  }
                  return null;
                },

                decoration: InputDecoration(
                  filled: true,
                  prefixIcon: icon,
                  fillColor: HexColor(MyColors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.w),
                    borderSide: BorderSide(
                      color: HexColor(MyColors.white),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.w),
                    borderSide: BorderSide(
                      color: HexColor(MyColors.white),
                    ),
                  ),
                ),
                hint: Text(
                  "نوع الافاده",
                  style: TextStyle(
                    color: HexColor(MyColors.gray),
                    fontSize: 14.sp,
                  ),
                ),
                isExpanded: false,
                items: model_Benifites_list.data!.map((list) {
                  return DropdownMenuItem(
                    child: Text('${list.name} ',
                        style: TextStyle(
                          fontSize: 15.sp,
                        )),
                    value: list,
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            )));
      } else {
        return Container();
      }
    });
  }
}
