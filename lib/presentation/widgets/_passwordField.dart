import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordField extends StatelessWidget {
  final hidePassword;

  final TextEditingController textEditingController;
  final onSaved;
  final onPressed;
  final label;

  PasswordField(
      {required this.hidePassword,
      required this.textEditingController,
      required this.onSaved,
      required this.onPressed,
      required this.label});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: TextFormField(
      keyboardType: TextInputType.text,
      controller: textEditingController,
      onSaved: onSaved,
      style: TextStyle(
        fontSize: 18.0.sp,
        color: HexColor(MyColors.black),
      ),
      validator: (input) =>
          input!.length < 3 ? "${LocaleKeys.password.tr()}" : null,
      obscureText: hidePassword,
      decoration: InputDecoration(
        filled: true,
        // prefixIcon: widget.icon,
        fillColor: HexColor(MyColors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.w),
          borderSide: BorderSide(
            color: HexColor(MyColors.white),
          ),
        ),

        hintText: "$label",
        prefixIcon: Icon(
          Icons.lock,
          color: HexColor(MyColors.green),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.w),
          borderSide: BorderSide(
            color: HexColor(MyColors.white),
          ),
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          color: HexColor(MyColors.green),
          icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    ));
  }
}
