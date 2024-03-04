import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/country_list/flight_country_list_bloc.dart';
import '../../bloc/idea_area/idea_area_bloc.dart';
import '../../data/model/model_idea_area.dart';
import '../../data/model/model_nationalities.dart';
import '../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';

class Widget_DropdownMenu_Idea extends StatelessWidget {
  final onSaved;
  final onChanged;

  Widget_DropdownMenu_Idea({
    required this.onSaved,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<IdeaAreaBloc, IdeaAreaState>(builder: (context, state) {
      // return widget here based on BlocA's state
      if (state is IdeaList_Loaded_State) {
        Model_Idea_Area model_country_list = (state).model;
        return Container(
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
                          return "${LocaleKeys.fiels_valid.tr()}";
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
                        "  ${LocaleKeys.Choose_field.tr()} ",
                        style: TextStyle(
                          color: HexColor(MyColors.gray),
                          fontSize: 16.sp,
                        ),
                      ),
                      isExpanded: false,
                      // value: travellers.type,
                      items: model_country_list.items.data.map((list) {
                        return DropdownMenuItem(
                          child: Text(
                              '${Intl.defaultLocale!.contains('en') ? list.nameEn : list.nameAr} ',
                        style: TextStyle(
                          fontSize: 15.sp,
                        )),
                          value: list,
                        );
                      }).toList(),
                      onChanged: onChanged,
                    ),
                  ))
                ]));
      } else {
        return Container();
      }
    });
  }
}
