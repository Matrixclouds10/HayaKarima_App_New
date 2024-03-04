import 'dart:core';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';

class Widget_About_List extends StatelessWidget {
  late var title, body;

  Widget_About_List(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h, bottom: 5.h),
        decoration: BoxDecoration(
            color: HexColor(MyColors.white),
            //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: new BorderRadius.only(
              topLeft: Radius.circular(10.0.r),
              topRight: Radius.circular(10.0.r),
              bottomRight: Radius.circular(10.0.r),
              bottomLeft: Radius.circular(10.0.r),
            )),
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 5.w, right: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w),
                child: ExpandablePanel(
                  header: Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,
                        color: HexColor(MyColors.black)),
                  ),
                  collapsed: Container(),
                  // collapsed: Text(body, softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17.sp,color: HexColor(MyColors.black).withOpacity(.8))),
                  expanded: Text(body,
                      softWrap: true,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.sp,
                          color: HexColor(MyColors.black).withOpacity(.8))),
                ))
          ],
        ));
  }
}
