// ignore_for_file: unnecessary_string_interpolations

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';

class DescriptionTextWidget_Home extends StatefulWidget {
  final String text;
  late final flag;

  DescriptionTextWidget_Home({required this.text, required this.flag});

  @override
  _DescriptionTextWidgetState createState() =>
      new _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget_Home> {
  late String firstHalf;
  late String secondHalf;
  bool flag = false;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 80) {
      firstHalf = widget.text.substring(0, 80);
      secondHalf = widget.text.substring(80, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(
                  widget.flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: TextStyle(fontSize: 18.sp),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.flag ? "" : "${LocaleKeys.show_less.tr()}",
                        style: TextStyle(
                            color: HexColor(MyColors.green),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      widget.flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
