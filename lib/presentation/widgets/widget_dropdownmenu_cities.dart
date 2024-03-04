import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/cities/cities_bloc.dart';
import '../../constants/my_colors.dart';
import '../../data/model/model_cities.dart';
import '../../generated/locale_keys.g.dart';

class Widget_DropdownMenu_Cities extends StatelessWidget {
  final onSaved;
  final onChanged;
  final icon;
  final String currentValue;

  const Widget_DropdownMenu_Cities({required this.onSaved, this.currentValue = '', required this.onChanged, required this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CitiesBloc, CitiesState>(builder: (context, state) {
      // return widget here based on BlocA's state

      if (state is Cities_Loaded_State) {
        Model_Cities modelCountryList = (state).model;

        Data_Items_Model_Cities? selectedValue;
        if (currentValue.isNotEmpty) {
          List<Data_Items_Model_Cities> selectedValueList = modelCountryList.items.data.where((element) => element.name == currentValue).toList();
          if (selectedValueList.isNotEmpty) {
            selectedValue = selectedValueList.first;
          }
        }
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SafeArea(
                child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: DropdownButtonFormField(
                // menuMaxHeight: 50.w,
                onSaved: onSaved,
                validator: (var val) {
                  if (val == null) {
                    return LocaleKeys.City.tr();
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
                  // prefixIcon: Icon(
                  //   Icons.place_outlined,
                  //   color: HexColor(MyColors.green),
                  // ),
                ),
                value: selectedValue,
                // underline: SizedBox.shrink(),
                hint: Text(
                  "  ${LocaleKeys.City.tr()} ",
                  style: TextStyle(
                    color: HexColor(MyColors.gray),
                    fontSize: 14.sp,
                  ),
                ),
                isExpanded: false,
                // value: travellers.type,
                items: modelCountryList.items.data.map((list) {
                  return DropdownMenuItem(
                    child: Text(
                      '${list.name} ',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                    ),
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
