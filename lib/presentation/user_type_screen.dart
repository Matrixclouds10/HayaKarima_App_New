import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/screens/intro_screen.dart';
import 'package:hayaah_karimuh/empolyer/screens/main_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/my_colors.dart';
import 'package:hayaah_karimuh/router/router_path.dart';
import 'package:hexcolor/hexcolor.dart';

class UserTypeScreen extends StatelessWidget {
  const UserTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * .42,
              width: width,
              child: Image.asset(
                'assets/hands_image.png',
                fit: BoxFit.fill,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                child: Text(
                  "حياة كريمة",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: HexColor(MyColors.Orange_primary)),
                )),
            Container(
                margin: const EdgeInsets.only(top: 0),
                alignment: Alignment.center,
                child: Text(
                  " لكل مصري .. لكل مصرية",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: HexColor(MyColors.black)),
                )),
            const Spacer(),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  PreferencesManager.saveBool(PreferencesManager.userType, true);
                  Navigator.pushNamedAndRemoveUntil(context, home_screen, (route) => false);
                },
                child: const Text('مواطن'),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ElevatedButton(
                onPressed: () {
                  PreferencesManager.saveBool(PreferencesManager.userType, false);
                  final hasToken = PreferencesManager.hasKey(PreferencesManager.token);
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => PreferencesManager.hasKey(PreferencesManager.token) ? const MainScreen() : const Intro_Screen()), (route) => false);
                },
                child: const Text('مستخدم'),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
