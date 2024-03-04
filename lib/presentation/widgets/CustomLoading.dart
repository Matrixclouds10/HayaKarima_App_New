import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: SpinKitSpinningLines(
          color: HexColor(MyColors.green),
          size: 40.0,
        ),
      ),
    );
  }
}
