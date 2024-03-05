import 'package:flutter/material.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/text.dart';

Widget kButton(
  String message, {
  Color? color,
  Color? textColor,
  double paddingV = 6,
  double paddingH = 6,
  double marginV = 6,
  double marginH = 6,
  double radius = 250,
  bool bold = true,
  bool loading = false,
  var func,
  String fontType = '',
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: marginH, vertical: marginV),
    child: InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: func,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: loading
            ? Center(
                child: Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.all(4),
                  child: CircularProgressIndicator(
                    color: textColor ?? Colors.white,
                    strokeWidth: 1.2,
                  ),
                ),
              )
            : Center(child: AppText(message, color: textColor ?? Colors.white, bold: bold)),
      ),
    ),
  );
}
