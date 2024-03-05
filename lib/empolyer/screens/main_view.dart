import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayaah_karimuh/empolyer/providers/main_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/home_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/projects_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String route = '/';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainProvider _mainProvider;

  final _screen = [
    const HomeScreen(),
    const ProjectsScreen(),
    const ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  void didChangeDependencies() {
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('------> app build');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: Platform.isAndroid ? 60 : 95,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(17),
              topLeft: Radius.circular(17),
            ),
            boxShadow: [
              BoxShadow(color: Color(0x3b000000), offset: Offset(0, -2), blurRadius: 6, spreadRadius: 0),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(17),
              topLeft: Radius.circular(17),
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              iconSize: 30,
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              // backgroundColor: Colors.transparent,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  icon: SvgPicture.asset(
                    SvgImages.navHome,
                    height: 25,
                    width: 25,
                    fit: BoxFit.scaleDown,
                  ),
                  activeIcon: SvgPicture.asset(
                    SvgImages.navHomeSelected,
                    height: 25,
                    width: 25,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Projects',
                  icon: SvgPicture.asset(
                    SvgImages.navProjects,
                    height: 25,
                    width: 25,
                    fit: BoxFit.scaleDown,
                  ),
                  activeIcon: SvgPicture.asset(
                    SvgImages.navProjectsSelected,
                    height: 25,
                    width: 25,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const BottomNavigationBarItem(
                  label: 'Profile',
                  icon: Icon(
                    Icons.person,
                    color: Color(0xff9a9a9a),
                  ),
                  // SvgPicture.asset(
                  //   SvgImages.navProfile,
                  //   height: 25,
                  //   width: 25,
                  //   fit: BoxFit.scaleDown,
                  // ),
                  activeIcon: Icon(
                    Icons.person,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _screen[currentIndex],
      ),
    );
  }
}
