import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String? text;

  const DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() =>
      _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text != null && widget.text!.length > 80) {
      firstHalf = widget.text!.substring(0, 80);
      secondHalf = widget.text!.substring(80, widget.text!.length);
    } else {
      firstHalf = '${widget.text}';
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(
                  flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                  style: TextStyle(fontSize: 18.sp),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        flag
                            ? LocaleKeys.More.tr()
                            : LocaleKeys.show_less.tr(),
                        style: TextStyle(
                            color: HexColor(MyColors.green),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                ),
              ],
            ),
    );
  }
}
