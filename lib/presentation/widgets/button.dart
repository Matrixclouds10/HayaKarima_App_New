import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';

class Button_Widget extends StatelessWidget {
  final onTap;
  final tittle;
  final color;
  final color_text;
  final fontSize;

  Button_Widget(
      {Key? key,
      required this.onTap,
      required this.tittle,
      required this.color,
      required this.color_text,
      required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          color: color, //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: new BorderRadius.only(
            bottomLeft: Radius.circular(5.r),
            bottomRight: Radius.circular(5.r),
            topRight: Radius.circular(5.r),
            topLeft: Radius.circular(5.r),
          ),
        ),
        child: Text(
          "$tittle",
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: color_text),
        ),
      ),
    );
  }
}
