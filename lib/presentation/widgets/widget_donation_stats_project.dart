import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';
import '../../data/model/model_project.dart';
import '../../generated/locale_keys.g.dart';

class Widget_Donation_Stats_Project extends StatelessWidget {
  late Data_Project data_project;

  Widget_Donation_Stats_Project(this.data_project);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Container(
      child: Container(
        decoration: BoxDecoration(
            color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0.w),
              bottomRight: Radius.circular(20.0.w),
            )),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.Donation_stats.tr(),
                    style: TextStyle(fontSize: 20.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 1.w, right: 1.w, top: 4.h),
                  width: 40.w,
                  height: 40.h,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: HexColor(MyColors.green)),
                  child: FittedBox(
                    child: Text(
                      data_project.donationPercentage,
                      style: TextStyle(color: HexColor(MyColors.white)),
                    ),
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 22.w, right: 22.w, top: 5.h),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  Expanded(
                    child: SizedBox(
                        child: LinearProgressIndicator(
                      backgroundColor: HexColor(MyColors.gray).withOpacity(0.5),
                      color: HexColor(MyColors.green),
                      value: double.parse(data_project.donationNeeded.replaceAll(',', '')) /
                          double.parse(
                            "${data_project.budget}",
                          ),
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5.w,
                      right: 5..w,
                    ),
                    child: Text(
                      " L.E ${data_project.donationBudget}",
                      style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w600),
                    ),
                  ),
                ])),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 5.h, bottom: 20.h),
              child: Text(
                "${data_project.donationNeeded} L.E متبقي",
                style: TextStyle(fontSize: 16.sp, color: HexColor(MyColors.green), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
