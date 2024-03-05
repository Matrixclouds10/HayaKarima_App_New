import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';

class AppText extends StatelessWidget {
  final String message;
  final double size;
  final TextAlign align;
  final double paddingV;
  final double paddingH;
  final bool bold;
  final int? maxLines;
  final bool white;
  final Color color;
  const AppText(
    this.message, {
    Key? key,
    this.size = 16,
    this.align = TextAlign.center,
    this.paddingV = 4,
    this.paddingH = 4,
    this.bold = false,
    this.maxLines,
    this.white = false,
    this.color = const Color(0xff4d4d4d),
  }) : super(key: key);

  header({bool bold = true}) {
    return body(fontSize: size + (2), bold: bold);
  }

  body({required double fontSize, bool bold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
      child: Text(
        message,
        style: GoogleFonts.cairo(
          color: white ? Colors.white : color,
          fontSize: fontSize,
          fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
        ),
        textAlign: align,
        maxLines: maxLines,
        overflow: maxLines == null ? null : TextOverflow.ellipsis,
      ),
    );
  }

  footer() {
    return body(fontSize: size - (2));
  }

  extraFooter() {
    return body(fontSize: size - (4));
  }

  @override
  Widget build(BuildContext context) {
    return body(fontSize: size);
  }
}

extension TextCustom on TextStyle {
  TextStyle normalColor() => (this).copyWith(color: AppColors.primaryColor);
  TextStyle activeColor() => (this).copyWith(color: AppColors.primaryColor);
  TextStyle customColor(Color color) => (this).copyWith(color: color);
  TextStyle colorWhite() => (this).copyWith(color: Colors.white);
  TextStyle textFamily({String? fontFamily}) => (this).copyWith(fontFamily: fontFamily);
  TextStyle boldActiveStyle() => (this).copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor);
  TextStyle underLineStyle() => (this).copyWith(decoration: TextDecoration.underline);
  TextStyle blackStyle() => (this).copyWith(fontWeight: FontWeight.w900, color: Colors.black);
  TextStyle ellipsisStyle() => (this).copyWith(
        overflow: TextOverflow.ellipsis,
      );
}
