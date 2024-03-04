import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class App_Bar_Auth extends StatelessWidget {
  const App_Bar_Auth();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: HexColor(MyColors.white),
      width: double.infinity,
      alignment: Alignment.center,
      height: 140.h,
      child: Image.asset('assets/logo.png'),
    );
  }
}
