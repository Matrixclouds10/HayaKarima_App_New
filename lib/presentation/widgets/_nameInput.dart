import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';

class NameInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final onSaved;
  final onChanged;
  final validation_Message;
  final maxLines;
  final icon;
  final hintText;
  final onTap;

  const NameInput({Key? key, required this.textEditingController, required this.onSaved, required this.onChanged, required this.validation_Message, required this.maxLines, required this.icon, required this.hintText, this.onTap}) : super(key: key);
  static final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]{2,20}$', unicode: false);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Transform.scale(
      scaleY: 0.9,
      child: TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.name,
        maxLines: maxLines,
        onTap: onTap,

        style: TextStyle(
          fontSize: 18.0.sp,
          color: HexColor(MyColors.black),
        ),
        onSaved: onSaved,
        onChanged: onChanged,
        validator: (value) => value!.isEmpty ? '$validation_Message' : null,

        decoration: InputDecoration(
          filled: true,
          // prefixIcon: widget.icon,
          fillColor: HexColor(MyColors.white),
          hintStyle: TextStyle(color: HexColor(MyColors.gray)),

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
