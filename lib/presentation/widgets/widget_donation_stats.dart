import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../constants/my_colors.dart';
import '../../data/model/model_donations.dart';

class Widget_Donation_Stats extends StatelessWidget {
  late Data_Donations data_donations;

  Widget_Donation_Stats(this.data_donations);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double val = (data_donations.geb == 0 ? -1 : data_donations.geb / data_donations.amount);
    var percent = data_donations.budget / 100;
    percent = percent;
    print("----->val $val");

    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(bottom: 10.h, left: 30.w, right: 30.w, top: 4.h),
      decoration: BoxDecoration(
          color: HexColor(MyColors.green), //new Color.fromRGBO(255, 0, 0, 0.0),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          )),
      child: Container(
        height: MediaQuery.of(context).size.height * .19,
        margin: EdgeInsets.only(bottom: 3.h, left: 0.w, right: 5.w),
        decoration: BoxDecoration(
            color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
            )),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h),
                  alignment: Alignment.center,
                  child: Text(
                    data_donations.beneficiaryType,
                    style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 1.w, right: 1.w, top: 5.h),
                  width: 40.w,
                  height: 40.h,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: HexColor(MyColors.green)),
                  child: FittedBox(
                    child: Text(
                      "${percent.toStringAsFixed(2)}%",
                      style: TextStyle(color: HexColor(MyColors.white)),
                    ),
                  ),
                )
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 22.w, right: 22.w, top: 5.h),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  if (val <= 1)
                    SizedBox(
                        width: width / 2,
                        child: LinearProgressIndicator(
                          backgroundColor: HexColor(MyColors.gray).withOpacity(.5),
                          color: HexColor(MyColors.green),
                          value: val,
                        )),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5.w,
                      right: 5..w,
                    ),
                    child: Text(
                      "${data_donations.amount} L.E",
                      style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w600),
                    ),
                  ),
                ])),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 5.h, bottom: 20.h),
              child: Text(
                "L.E ${data_donations.geb}  متبقي",
                style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.green), fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
