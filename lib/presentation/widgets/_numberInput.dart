import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class NumberInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final onSaved;
  final onChanged;
  final maxLines;
  final icon;
  final hintText;
  final validator;

  NumberInput(
      {Key? key,
      required this.textEditingController,
      required this.onSaved,
      required this.onChanged,
      required this.maxLines,
      required this.icon,
      required this.hintText,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        maxLines: maxLines,

        style: TextStyle(
          fontSize: 18.0.sp,
          color: HexColor(MyColors.black),
        ),
        onSaved: onSaved,

        onChanged: onChanged,
        validator: validator,

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
          prefixIcon: icon,
          hintText: "$hintText",
          // labelText: '$labelText',
        ),
        // ),
      ),
    );
  }
}
