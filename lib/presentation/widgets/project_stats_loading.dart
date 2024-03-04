import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';

class Project_Stats_Loading extends StatelessWidget {
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
              width: MediaQuery.of(context).size.width * .35,
              decoration: new BoxDecoration(
                  color: HexColor(MyColors.gray).withOpacity(.4),
                  borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(70.0.w),
                    topRight: Radius.circular(70.0.w),
                    bottomRight: Radius.circular(70.0.w),
                    bottomLeft: Radius.circular(70.0.w),
                  )),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 2.w, right: 2.w),
                      child: Text(
                        "",
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: HexColor(MyColors.white)),
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            alignment: Alignment.center,
            width: 50.w,
            height: 80.h,
            decoration: BoxDecoration(
                color: HexColor(MyColors.white).withOpacity(.2),
                shape: BoxShape.circle),
            child: Text(
              "",
              style:
                  TextStyle(fontSize: 18.sp, color: HexColor(MyColors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
