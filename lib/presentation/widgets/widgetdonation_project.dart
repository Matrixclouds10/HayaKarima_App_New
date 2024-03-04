import 'package:bubble_slider/bubble_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/step_pageview/pageview_bloc.dart';
import '../../constants/my_colors.dart';
import '../../data/model/model_beneficiaries.dart';
import '../../data/model/model_project.dart';
import '../../generated/locale_keys.g.dart';
import '../../router/router_path.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';

class WidgetDonation_Project extends StatelessWidget {
  var tittle = "أطفال قرى الصعيد";
  var body = "كفالة يتيم";
  late Data_Project data_project;

  WidgetDonation_Project(this.data_project);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return ListTile(
        onTap: () {
          Navigator.pushNamed(context, DonationsAbout, arguments: data_project);
        },
        title: Container(
          width: width,
          margin: EdgeInsets.only(bottom: .5.h, left: 7.w, right: 7.w, top: .5.h),
          child: Container(
            margin: EdgeInsets.only(bottom: 1.h, left: 5.w, right: 0),
            decoration: BoxDecoration(
                color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.w),
                  topRight: Radius.circular(10.w),
                  bottomLeft: Radius.circular(10.w),
                  bottomRight: Radius.circular(10.w),
                )),
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 10.h, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image(
                              height: height * .20,
                              width: width / 3.7,
                              alignment: Alignment.center,
                              image: AssetImage('assets/imglist.png'),
                              fit: BoxFit.fill,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 20.h),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: width * .50,
                                    margin: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                                    child: Text(
                                      "${data_project.name}",
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        color: HexColor(MyColors.black),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * .50,
                                    margin: EdgeInsets.only(
                                      left: 5.w,
                                      right: 5.w,
                                      top: 5.h,
                                    ),
                                    child: Text(
                                      "${data_project.govern}",
                                      style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.black), fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    width: width * .50,
                                    margin: EdgeInsets.only(left: 3.w, right: 3.w, bottom: 5.h),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(left: 3.w, right: 3.w, top: 10.h, bottom: 10.h),
                                          child: Text(
                                            "L.E ${data_project.budget}",
                                            style: TextStyle(color: HexColor(MyColors.green), fontSize: 20.sp, overflow: TextOverflow.ellipsis, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 10.h, bottom: 10.h),
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h, bottom: 5.h),
                                            decoration: BoxDecoration(
                                                color: HexColor(MyColors.Orange_Project), //new Color.fromRGBO(255, 0, 0, 0.0),
                                                borderRadius: BorderRadius.circular(10.w)),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${data_project.donationStatus}',
                                                style: TextStyle(color: HexColor(MyColors.black)),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
