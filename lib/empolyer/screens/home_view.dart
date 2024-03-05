import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/screens/beneficiaries_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/inspections_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/map_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/one_to_one_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/projects_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import 'messages_view.dart';
import 'notifications_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MainProvider _mainProvider;

  @override
  void didChangeDependencies() {
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          primary: true,
          scrollDirection: Axis.vertical,
          child: SizedBox(
            // height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  height: 255,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120),
                      bottomRight: Radius.circular(120),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Color(0x29000000), offset: Offset(0, 2), blurRadius: 6, spreadRadius: 0),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(top: 42, start: 5, end: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PopupMenuButton<int>(
                          onSelected: (index) async {
                            if (index == 0) {
                              log('Profile');
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                            } else {
                              log('Logout');
                              await _mainProvider.logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => SplashScreen(),
                                  ),
                                  (route) => false);
                            }
                          },
                          shape: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffc1c1c1),
                              width: 1,
                            ),
                          ),
                          color: Colors.white,
                          icon: SvgPicture.asset(SvgImages.optionsMenu),
                          itemBuilder: (ctx) => [
                            PopupMenuItem(
                              value: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    SvgImages.dummyUser,
                                    width: 14,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "البروفايل",
                                    style: GoogleFonts.cairo(
                                      color: const Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                                textDirection: TextDirection.rtl,
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    SvgImages.logout,
                                    width: 14,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "خروج",
                                    style: GoogleFonts.cairo(
                                      color: const Color(0xff4d4d4d),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                                textDirection: TextDirection.rtl,
                                // mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        SizedBox(
                          width: 162,
                          height: 188,
                          child: Image.asset(
                            PngImages.logo,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const NotificationsScreen(),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Stack(
                              children: [
                                const PositionedDirectional(
                                  bottom: 0,
                                  end: 0,
                                  child: Icon(
                                    Icons.notifications,
                                    color: AppColors.primaryColor,
                                    size: 32,
                                  ),
                                ),
                                PositionedDirectional(
                                  top: 0,
                                  start: 0,
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.appOrange,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _mainProvider.notificationCount.toString(),
                                        style: GoogleFonts.cairo(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 22,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ProjectsScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: (width - 60) / 2,
                        height: ((width - 60) / 2) * 1.2,
                        child: Stack(
                          children: [
                            PositionedDirectional(
                              bottom: 4,
                              start: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemCorner,
                                // width: double.infinity,
                                // height: 39,
                                // fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              start: 11,
                              end: 6,
                              bottom: 16,
                              child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  // margin: const EdgeInsets.only(top: 32),
                                  child: SvgPicture.asset(
                                    SvgImages.projects,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 4,
                              start: 11,
                              end: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemDecorationBottom,
                                width: double.infinity,
                                height: 39,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 10,
                              end: 0,
                              start: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "المشاريع",
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const InspectionsScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: (width - 60) / 2,
                        height: ((width - 60) / 2) * 1.2,
                        child: Stack(
                          children: [
                            PositionedDirectional(
                              bottom: 4,
                              start: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemCorner,
                                // width: double.infinity,
                                // height: 39,
                                // fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              start: 11,
                              end: 6,
                              bottom: 16,
                              child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  // margin: const EdgeInsets.only(top: 32),
                                  child: SvgPicture.asset(
                                    SvgImages.activities,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 4,
                              start: 11,
                              end: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemDecorationBottom,
                                width: double.infinity,
                                height: 39,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 10,
                              end: 0,
                              start: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "المعاينات",
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 37,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 22,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OneToOneScreen(),
                            settings: const RouteSettings(name: OneToOneScreen.routeName),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: (width - 60) / 2,
                        height: ((width - 60) / 2) * 1.2,
                        child: Stack(
                          children: [
                            PositionedDirectional(
                              bottom: 4,
                              start: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemCorner,
                                // width: double.infinity,
                                // height: 39,
                                // fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              start: 11,
                              end: 6,
                              bottom: 16,
                              child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  // margin: const EdgeInsets.only(top: 32),
                                  child: SvgPicture.asset(
                                    SvgImages.chatBox,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 4,
                              start: 11,
                              end: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemDecorationBottom,
                                width: double.infinity,
                                height: 39,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 10,
                              end: 0,
                              start: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "المحادثات",
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const BeneficiariesScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: (width - 60) / 2,
                        height: ((width - 60) / 2) * 1.2,
                        child: Stack(
                          children: [
                            PositionedDirectional(
                              bottom: 4,
                              start: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemCorner,
                                // width: double.infinity,
                                // height: 39,
                                // fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              start: 11,
                              end: 6,
                              bottom: 16,
                              child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  // margin: const EdgeInsets.only(top: 32),
                                  child: SvgPicture.asset(
                                    SvgImages.beneficiaries,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 4,
                              start: 11,
                              end: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemDecorationBottom,
                                width: double.infinity,
                                height: 39,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 10,
                              end: 0,
                              start: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "المستفيدين",
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 37,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      width: 22,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MessagesScreen(),
                            settings: const RouteSettings(name: MessagesScreen.routeName),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: (width - 60) / 2,
                        height: ((width - 60) / 2) * 1.2,
                        child: Stack(
                          children: [
                            PositionedDirectional(
                              bottom: 4,
                              start: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemCorner,
                                // width: double.infinity,
                                // height: 39,
                                // fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              start: 11,
                              end: 6,
                              bottom: 16,
                              child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  // margin: const EdgeInsets.only(top: 32),
                                  child: SvgPicture.asset(
                                    SvgImages.chatBox,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 4,
                              start: 11,
                              end: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemDecorationBottom,
                                width: double.infinity,
                                height: 39,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 10,
                              end: 0,
                              start: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "المجموعات",
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const MapScreen(),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: (width - 60) / 2,
                        height: ((width - 60) / 2) * 1.2,
                        child: Stack(
                          children: [
                            PositionedDirectional(
                              bottom: 4,
                              start: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemCorner,
                                // width: double.infinity,
                                // height: 39,
                                // fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              top: 0,
                              start: 11,
                              end: 6,
                              bottom: 16,
                              child: Container(
                                width: 135,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 3),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  // margin: const EdgeInsets.only(top: 32),
                                  child: Image.asset(
                                    PngImages.map,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 4,
                              start: 11,
                              end: 0,
                              child: SvgPicture.asset(
                                SvgImages.homeItemDecorationBottom,
                                width: double.infinity,
                                height: 39,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            PositionedDirectional(
                              bottom: 10,
                              end: 0,
                              start: 0,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "الخريطة التفاعلية",
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 37,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
