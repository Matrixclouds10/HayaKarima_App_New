import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';

class ImgInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final onSaved;
  final onChanged;
  final String validation_Message;
  final maxLines;
  final icon;
  final hintText;
  final onTap;
  final prefixIcon;

  const ImgInput(
      {Key? key,
      required this.textEditingController,
      required this.onSaved,
      required this.onChanged,
      required this.validation_Message,
      required this.maxLines,
      required this.icon,
      required this.hintText,
      this.onTap,
      required this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.scale(
      scaleY: 0.9,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        maxLines: maxLines,
        onTap: onTap,

        style: TextStyle(
          fontSize: 18.0.sp,
          color: HexColor(MyColors.black),
        ),
        onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) => value!.isEmpty && validation_Message.isNotEmpty ? validation_Message : null,

        decoration: InputDecoration(
          filled: true,
          hintStyle: TextStyle(color: HexColor(MyColors.gray)),

          // prefixIcon: widget.icon,
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
          suffixIcon: icon,
          // labelText: '$labelText',
        ),
        // ),
      ),
    );
  }
}
