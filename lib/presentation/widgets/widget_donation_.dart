import 'package:bubble_slider/bubble_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/step_pageview/pageview_bloc.dart';
import '../../constants/my_colors.dart';
import '../../generated/locale_keys.g.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';

class Widget_Donation extends StatelessWidget {
  double _value = 100.0;
  var tittle;

  Widget_Donation(this.tittle);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
        onTap: () {
          context.read<PageviewBloc>().add(Start_Eventstep());
          context.read<PageviewBloc>().add(NextStep_one(1, 1));
        },
        title: Container(
          margin: EdgeInsets.only(bottom: 10.h, left: 5.w, right: 5.w, top: 4.h),
          decoration: new BoxDecoration(
              color: HexColor(MyColors.green), //new Color.fromRGBO(255, 0, 0, 0.0),
              borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              )),
          child: Container(
            margin: EdgeInsets.only(bottom: 3.h, left: 5.w, right: 0),
            decoration: new BoxDecoration(
                color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: new BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 10.h, bottom: 10.h),
                              alignment: Alignment.center,
                              child: Text(
                                "$tittle",
                                style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 3.w, right: 3.w, top: 10.h, bottom: 10.h),
                              child: Text(
                                "1500 L.E",
                                style: TextStyle(color: HexColor(MyColors.green), fontSize: 16.sp),
                              ),
                            )
                          ],
                        ),
                        if (DateTime.now().isAfter(DateTime(2023, 04, 01)))
                          Container(
                            margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 10.h, bottom: 10.h),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.w),
                            color: HexColor(MyColors.green).withOpacity(.2),
                            child: Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${LocaleKeys.donate_now.tr()}',
                                    style: TextStyle(color: HexColor(MyColors.black)),
                                  ),
                                ),
                                Container(
                                  height: 16.0.w,
                                  width: 16.0.w,
                                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20.0.sp,
                                    color: HexColor(MyColors.gray),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
