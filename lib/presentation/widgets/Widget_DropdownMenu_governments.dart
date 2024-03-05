import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/bloc/cities/cities_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/governments/governments_bloc.dart';
import '../../constants/my_colors.dart';
import '../../data/model/model_governments.dart';
import '../../generated/locale_keys.g.dart';

class Widget_governments extends StatelessWidget {
  final onSaved;
  final String currentValue;
  final onChanged;
  final icon;

  const Widget_governments({required this.onSaved, this.currentValue = '', required this.onChanged, required this.icon});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<GovernmentsBloc, GovernmentsState>(builder: (context, state) {
      // return widget here based on BlocA's state
      if (state is Governments_Loaded_State) {
        Model_Governments modelCountryList = (state).model;

        Data_Items_Governments? selectedValue;
        if (currentValue.isNotEmpty) {
          List<Data_Items_Governments> selectedValueList = modelCountryList.items.data.where((element) => element.name == currentValue).toList();
          if (selectedValueList.isNotEmpty) {
            selectedValue = selectedValueList.first;
            context.read<CitiesBloc>().add(Start_CitiesEvent());
            context.read<CitiesBloc>().add(Submission_CitiesEvent(selectedValueList.first.id));
          }
        }
        return Transform.scale(
      scaleY: 0.9,
          child: SizedBox(
              width: double.infinity,
              child: Column(
                  // mainAxisAlignment:
                  // MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SafeArea(
                        child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: DropdownButtonFormField(
                        // menuMaxHeight: 50.w,
                        onSaved: onSaved,
                        validator: (var val) {
                          if (val == null) {
                            return LocaleKeys.Governorate.tr();
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
                        // underline: SizedBox.shrink(),
                        hint: Text(
                          "  ${LocaleKeys.Governorate.tr()} ",
                          style: TextStyle(color: HexColor(MyColors.gray), fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                        isExpanded: false,
                        value: selectedValue,
                        // value: travellers.type,
                        items: modelCountryList.items.data.map((list) {
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
                    ))
                  ])),
        );
      } else {
        return Container();
      }
    });
  }
}
