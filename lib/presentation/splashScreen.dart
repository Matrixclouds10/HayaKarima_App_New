import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:hayaah_karimuh/constants/strings.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/screens/intro_screen.dart';
import 'package:hayaah_karimuh/empolyer/screens/main_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/echo.dart';
import 'package:hayaah_karimuh/presentation/user_type_screen.dart';
import 'package:hexcolor/hexcolor.dart';

import '../constants/my_colors.dart';
import '../router/router_path.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late GifController _controller;

  @override
  void initState() {
    _controller = GifController(vsync: this);
    super.initState();

    kEcho("SplashScreen");
    Timer(const Duration(seconds: 3), () {
      final bool? isUserType = PreferencesManager.getBool(PreferencesManager.userType);
      final hasToken = PreferencesManager.hasKey(PreferencesManager.token);
      String token2 = PreferencesManager.getString(ACCESS_TOKEN) ?? "";

      if ((!hasToken && token2.isEmpty) || isUserType == null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const UserTypeScreen()));
      } else {
        if (isUserType) {
          Navigator.pushNamed(context, home_screen);
        } else {
          if (token2.isNotEmpty) {
            Navigator.pushNamedAndRemoveUntil(context, home_screen, (route) => false);
          }
          if (hasToken) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PreferencesManager.hasKey(PreferencesManager.token) ? const MainScreen() : const Intro_Screen()), (route) => false);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      backgroundColor: HexColor(MyColors.white),
      body: 
       Center(
         child: Gif(
            image: AssetImage("assets/logo.gif"),
            controller: _controller, // if duration and fps is null, original gif fps will be used.
            //fps: 30,
            duration: const Duration(seconds: 5),
            autostart: Autostart.once,
            placeholder: (context) {
              return Container(
                color: HexColor(MyColors.white),
                width: width / 1.5,
                height: height / 1.5,
                alignment: Alignment.center,
                child: Image.asset('assets/logo.png'),
              );
            },
            onFetchCompleted: () {
              _controller.reset();
              _controller.forward();
            },
          ),
       ),
      
      // Stack(children: <Widget>[
       
        // AnimatedOpacity(
        //   opacity: controller!.value,
        //   duration: const Duration(milliseconds: 2500),
        //   child: Align(
        //     alignment: Alignment.center,
        //     child: Container(
        //       color: HexColor(MyColors.white),
        //       width: width / 1.5,
        //       height: height / 1.5,
        //       alignment: Alignment.center,
        //       child: Image.asset('assets/logo.png'),
        //     ),
        //   ),
        // ),
      // ]),
    );
  }
}
