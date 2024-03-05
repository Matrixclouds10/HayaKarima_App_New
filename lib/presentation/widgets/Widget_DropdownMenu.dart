import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/country_list/flight_country_list_bloc.dart';
import '../../constants/my_colors.dart';
import '../../data/model/model_nationalities.dart';
import '../../generated/locale_keys.g.dart';

class Widget_DropdownMenu extends StatelessWidget {
  final onSaved;
  final onChanged;

  const Widget_DropdownMenu({
    required this.onSaved,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<CountryListBloc, CountryListState>(builder: (context, state) {
      // return widget here based on BlocA's state
      if (state is CountryList_Loaded_State) {
        Model_Nationalities modelCountryList = (state).model;
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
                            return LocaleKeys.nationality_valid.tr();
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          filled: true,
                          // prefixIcon: widget.icon,
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
                          "  ${LocaleKeys.Nationality.tr()} ",
                          style: TextStyle(
                            color: HexColor(MyColors.gray),
                            fontSize: 16.sp,
                          ),
                        ),
                        isExpanded: false,
                        // value: travellers.type,
                        items: modelCountryList.items.data.map((list) {
                          return DropdownMenuItem(
                            child: Text('${Intl.defaultLocale!.contains('en') ? list.nameEn : list.nameAr} ',
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
