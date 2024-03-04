import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/langouage/langouage_cubit.dart';
import '../../../bloc/step_pageview/pageview_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';

class Langouage_Screen extends StatelessWidget {
  var langouage = '${Intl.defaultLocale}';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: WillPopScope(
            onWillPop: () async {
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(0, 0));

              return false;
            },
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(10.w, 15.h, 2.w, 10.w),

                    // alignment: Alignment.center,
                    child: Text(
                      " ${LocaleKeys.Do_you_want_to_change_the_language.tr()} ",
                      style: TextStyle(
                        fontSize: 17.0.sp,
                        color: HexColor(MyColors.black),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text("عربي"),
                    onTap: () {
                      langouage == "ar";
                      context
                          .read<LangouageCubit>()
                          .set_language('ar', context);
                      context.read<PageviewBloc>().add(Start_Eventstep());
                      context.read<PageviewBloc>().add(NextStep_one(0, 0));
                    },
                    leading: Radio<String>(
                      value: 'ar',
                      groupValue: langouage,
                      onChanged: (String? value) {
                        langouage == value;
                        context
                            .read<LangouageCubit>()
                            .set_language('ar', context);
                        context.read<PageviewBloc>().add(Start_Eventstep());
                        context.read<PageviewBloc>().add(NextStep_one(0, 0));
                      },
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      langouage == "en";
                      context
                          .read<LangouageCubit>()
                          .set_language('en', context);
                      context.read<PageviewBloc>().add(Start_Eventstep());
                      context.read<PageviewBloc>().add(NextStep_one(0, 0));
                    },
                    title: Text("English"),
                    leading: Radio<String>(
                      value: 'en',
                      groupValue: langouage,
                      onChanged: (String? value) {
                        langouage == value;
                        context
                            .read<LangouageCubit>()
                            .set_language('en', context);
                        context.read<PageviewBloc>().add(Start_Eventstep());
                        context.read<PageviewBloc>().add(NextStep_one(0, 0));
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
