

import 'package:flutter/cupertino.dart';

import 'package:hexcolor/hexcolor.dart';

import '../utils/images.dart';
import '../utils/my_colors.dart';

class App_Bar_Auth extends StatelessWidget{

const  App_Bar_Auth();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      color: HexColor(MyColors.white),
      width: double.infinity,
      alignment: Alignment.center,
      height: 140,
      child: Image.asset(PngImages.logo),
    ) ;
  }

}