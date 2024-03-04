import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../constants/my_colors.dart';
import '../router/router_path.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("----->langouagesplas :${Intl.defaultLocale}");

    Timer(const Duration(seconds: 3), () {
      // Navigator.pushNamed(context, Login);
      Navigator.pushNamed(context, home_screen);
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
      body: Stack(children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            color: HexColor(MyColors.white),
            width: width / 1.5,
            height: height / 1.5,
            alignment: Alignment.center,
            child: Image.asset('assets/logo.png'),
          ),
        ),
      ]),
    );
  }
}
