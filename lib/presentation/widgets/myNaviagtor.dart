import 'package:flutter/cupertino.dart';

Future? myNavigate(
    {@required Widget? screen,
    bool withBackButton = true,
    @required BuildContext? context}) {
  if (withBackButton == true) {
    Navigator.push(
        context!,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => screen!,
          transitionsBuilder: (c, anim, a2, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: Duration(milliseconds: 300),
        ));
  } else {
    Navigator.pushReplacement(
      context!,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => screen!,
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
  return null;
}
