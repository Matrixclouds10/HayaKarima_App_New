import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';

class EmailInput extends StatelessWidget {
  final textEditingController;
  final onSaved;
  final onChanged;
  final hintText;
  final prefixIcon;

  const EmailInput(
      {Key? key,
      required this.textEditingController,
      required this.onSaved,
      required this.onChanged,
      required this.hintText,
      required this.prefixIcon})
      : super(key: key);

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.emailAddress,

        style: TextStyle(
          fontSize: 18.0.sp,
          color: HexColor(MyColors.black),
        ),

        onSaved: onSaved,
        onChanged: onChanged,

        validator: (input) =>
            !isEmail(input!) ? "${LocaleKeys.Email_valid.tr()}" : null,
        decoration: InputDecoration(
          filled: true,
          // prefixIcon: widget.icon,
          hintStyle: TextStyle(color: HexColor(MyColors.gray)),
          fillColor: HexColor(MyColors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.w),
            borderSide: BorderSide(
              color: HexColor(MyColors.white),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.w),
            borderSide: BorderSide(
              color: HexColor(MyColors.white),
            ),
          ),
          prefixIcon: prefixIcon,
          hintText: "$hintText",
        ),

        // ),
      ),
    );
  }
}
