import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';

class Project_Stats extends StatelessWidget {
  final icon;
  final tittle;
  final count;

  Project_Stats(
      {required this.icon, required this.tittle, required this.count});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Container(
      height: 80.h,
      width: MediaQuery.of(context).size.width * .40,
      margin: EdgeInsets.only(left: 5.w, right: 5.w),
      child: Stack(
        children: <Widget>[
          Container(
              height: 50.h,
              margin: EdgeInsets.only(top: 15.h),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * .50,
              decoration: new BoxDecoration(
                  color: HexColor(MyColors.green),
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(70.0.w),
                    topRight: Radius.circular(70.0.w),
                    bottomRight: Radius.circular(70.0.w),
                    bottomLeft: Radius.circular(70.0.w),
                  )),
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: Text(
                        "$tittle",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: HexColor(MyColors.white)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: icon,
                    ),
                  ],
                ),
              )),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 0.w, right: 0.w),
            width: 60.w,
            height: 90.h,
            decoration: BoxDecoration(
                color: HexColor(MyColors.Orange_primary),
                shape: BoxShape.circle),
            child: Text(
              "$count",
              style:
                  TextStyle(fontSize: 16.sp, color: HexColor(MyColors.white)),
            ),
          ),
          // Container(
          //
          //   alignment: Alignment.centerRight,
          //
          //   decoration: BoxDecoration(
          //       color:HexColor(MyColors.Orange_primary),
          //       shape: BoxShape.circle
          //   ),
          // ),
        ],
      ),
    );
  }
}
