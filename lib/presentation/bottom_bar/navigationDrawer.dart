import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hayaah_karimuh/data/echo.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/AuthHandel/auth_handel_bloc.dart';
import '../../bloc/step_pageview/pageview_bloc.dart';
import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';
import '../../router/router_path.dart';

class NavigationDrawer extends StatelessWidget {
  final Function onTap;
  const NavigationDrawer({Key? key, required this.onTap}) : super(key: key);
  Widget list_drawer(BuildContext context, var stateAuth) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        createDrawerHeader(),
        createDrawerBodyItem(
            path: 'assets/about.svg',
            text: LocaleKeys.About.tr(),
            onTap: () async {
              onTap();
              await Future.delayed(const Duration(milliseconds: 100));
              // Navigator.pushNamed(context, About_Page);
              kEcho("About");
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(1, 1));
              Navigator.of(context).pop();
            },
            color: MyColors.black),
        createDrawerBodyItem(
            path: 'assets/icon_two.svg',
            text: LocaleKeys.Donation_stats.tr(),
            onTap: () async {
              onTap();
              await Future.delayed(const Duration(milliseconds: 100));
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(2, 2));
              Navigator.of(context).pop();
            },
            color: MyColors.black),

        createDrawerBodyItem(
            path: 'assets/icon_map.svg',
            text: LocaleKeys.interactive_map.tr(),
            onTap: () async {
              onTap();
              await Future.delayed(const Duration(milliseconds: 100));
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(5, 2));
              Navigator.of(context).pop();
            },
            color: MyColors.black),

        createDrawerBodyItem(
            path: 'assets/news.svg',
            text: LocaleKeys.news.tr(),
            onTap: () async {
              onTap();
              await Future.delayed(const Duration(milliseconds: 100));
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(3, 1));
              Navigator.of(context).pop();
            },
            color: MyColors.black),
        if (DateTime.now().isAfter(DateTime(2023, 04, 01)))
          createDrawerBodyItem(
              path: 'assets/donations.svg',
              text: LocaleKeys.Donations.tr(),
              onTap: () async {
                onTap();
                await Future.delayed(const Duration(milliseconds: 100));
                context.read<PageviewBloc>().add(Start_Eventstep());
                context.read<PageviewBloc>().add(NextStep_one(6, 1));
                Navigator.of(context).pop();
              },
              color: MyColors.black),
        createDrawerBodyItem(
            path: 'assets/suggestions.svg',
            text: LocaleKeys.Complaints_and_suggestions.tr(),
            onTap: () async {
              onTap();
              await Future.delayed(const Duration(milliseconds: 100));
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(7, 1));
              Navigator.of(context).pop();
            },
            color: MyColors.black),

        // createDrawerBodyItem(
        //     path: 'assets/logout.svg',text: '${LocaleKeys.language.tr()}', onTap: () async { onTap(); await  Future.delayed(const Duration(milliseconds: 100));
        //
        //   context.read<PageviewBloc>().add(Start_Eventstep());
        //   context.read<PageviewBloc>().add(NextStep_one(4,1));
        //   Navigator.of(context).pop();
        //
        //
        // }),
        stateAuth != "is_auth"
            ? createDrawerBodyItem(
                path: 'assets/logout.svg',
                text: LocaleKeys.login.tr(),
                onTap: () async {
                  onTap();
                  await Future.delayed(const Duration(milliseconds: 100));
                  Navigator.pushNamed(context, Login);

                  // Navigator.of(context).pop();
                },
                color: MyColors.green)
            : Container(),
        stateAuth == "is_auth"
            ? createDrawerBodyItem(
                path: 'assets/logout.svg',
                text: LocaleKeys.Log_out.tr(),
                onTap: () async {
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.clear();
                  context.read<AuthHandelBloc>().add(ChangeAuthHandel_Event("is_Guest"));
                  // Navigator.of(context).pop();
                  Navigator.pushNamedAndRemoveUntil(context, all_routs, (route) => false);
                },
                color: MyColors.green)
            : Container(),
      ],
    );
  }

  Widget AuthHandel(BuildContext context) {
    return BlocBuilder<AuthHandelBloc, AuthHandelState>(
      builder: (context, state) {
        if (state is AuthHande_IsToken) {
          var token = (state).token;
          print("----->bloc_token : my tripe $token");
          var isAuth = "is_auth";

          print("----->AuthHande_IsToken");
          return list_drawer(context, isAuth);
        } else if (state is AuthHande_Is_Guest) {
          var isAuth = "is_Guest";
          print("----->AuthHande_Is_Guest");
          return list_drawer(context, isAuth);
        } else if (state is AuthHande_Is_notaction) {
          var isAuth = "is_notaction";
          print("----->AuthHande_Is_notaction");
          return list_drawer(context, isAuth);
        } else {
          print("----->AuthHande_Is_notaction else ");

          var isAuth = "is_Guest";
          return list_drawer(context, isAuth);
        }
      },
    );
  }

  Widget createDrawerHeader() {
    return SafeArea(
        child: Container(
      height: 200.h,
      margin: EdgeInsets.only(bottom: 30.h),
      color: HexColor(MyColors.white),
      child: DrawerHeader(margin: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 15), padding: EdgeInsets.zero, decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/logo.png'))), child: Stack(children: const <Widget>[])),
    ));
  }

  Widget createDrawerBodyItem({required String path, required String text, required GestureTapCallback onTap, required String color}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          SizedBox(
              width: 25.w,
              height: 25.h,
              child: SvgPicture.asset(
                path,
              )),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Text(
              text,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: HexColor(color)),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(width: width * .9, child: Drawer(backgroundColor: HexColor(MyColors.white), child: AuthHandel(context)));
  }
}
