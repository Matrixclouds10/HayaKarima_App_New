//custom_alert_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../constants/my_colors.dart';
import 'button.dart';

class CustomAlertDialog extends StatefulWidget {
  CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.btnTitle,
      required this.image,
      required this.onBtnTap,
      required this.fromLogin})
      : super(key: key);

  final String title;
  final String image;
  final String btnTitle;
  bool fromLogin;
  dynamic onBtnTap;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 15,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.title,
                style: TextStyle(
                  color: HexColor(MyColors.green),
                  fontSize: 18.sp,
                )),
            SizedBox(height: 15),
            Image.asset(
              widget.image,
              // color: Colors.white,
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.width * .5,
            ),
            widget.fromLogin
                ? SizedBox()
                : Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 30.h),
                    height: 50.h,
                    child: Button_Widget(
                      fontSize: 18.sp,
                      color_text: HexColor(MyColors.white),
                      color: HexColor(MyColors.green),
                      onTap: widget.onBtnTap,
                      tittle: widget.btnTitle,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
