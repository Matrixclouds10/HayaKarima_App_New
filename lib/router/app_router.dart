import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../data/echo.dart';
import '../data/model/model_beneficiaries.dart';
import '../data/model/model_news.dart';
import '../data/model/model_project.dart';
import '../presentation/auth/login/login_screen.dart';
import '../presentation/auth/registration/registration_screen.dart';
import '../presentation/bottom_bar/Bottom_Bar_Screen.dart';
import '../presentation/bottom_bar/about/About.dart';
import '../presentation/bottom_bar/donations/about_donations_beneficiaries.dart';
import '../presentation/bottom_bar/donations/about_donations_project.dart';
import '../presentation/bottom_bar/donations/send_donations.dart';
import '../presentation/bottom_bar/new_details/new_details.dart';
import '../presentation/splashScreen.dart';
import 'router_path.dart';

class AppRouter {
  AppRouter();

  Route? generateRoute(RouteSettings settings) {
    kEcho(" AppRouter generateRoute ${settings.name}");
    switch (settings.name) {
      case all_routs:
        // return PageTransition(child: SplashScreen(), type: PageTransitionType.scale);
        return _generateMaterialRoute(SplashScreen());

      case Registration:
        // return PageTransition(child: SplashScreen(), type: PageTransitionType.scale);
        return _generateMaterialRoute(Registration_Screen());

      case home_screen:
        return _generateMaterialRoute(Bottom_Bar_Screen());

      case About_Page:
        return _generateMaterialRoute(AboutPage());

      case Login:
        return _generateMaterialRoute(Login_Screen());

      case NewsDetails:
        final model = settings.arguments as Data_News;
        return _generateMaterialRoute(New_details(model));

      case DonationsAbout:
        final model = settings.arguments as Data_Project;

        return _generateMaterialRoute(Donations_AboutProject(model));

      case Donations_Send_:
        return _generateMaterialRoute(Donations_Send());

      case DonationsAboutBeneficiaries:
        final model = settings.arguments as Data_Beneficiaries;

        return _generateMaterialRoute(Donations_AboutBeneficiaries(model));
    }
    return null;
  }
}

PageTransition _generateMaterialRoute(Widget screen) {
  return PageTransition(child: screen, type: PageTransitionType.rightToLeft);
}
