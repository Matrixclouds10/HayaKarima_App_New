import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../constants/my_colors.dart';
import '../../../data/model/model_project.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../router/router_path.dart';
import '../../widgets/DescriptionTextWidget.dart';
import '../../widgets/button.dart';
import '../../widgets/widget_donation_stats_project.dart';

class Donations_AboutProject extends StatelessWidget {
  late Data_Project data_project;

  Donations_AboutProject(this.data_project); // late var email, password;
  // TextEditingController textEditingController_email=new TextEditingController();
  // TextEditingController textEditingController_password=new TextEditingController();
  //

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: HexColor(MyColors.gray_silver),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                SizedBox(
                  width: width,
                  height: height * .35,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Image.asset('assets/about_do.png'),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/about_do.png',
                      fit: BoxFit.fill,
                    ),
                    imageUrl: '',
                  ),
                ),
                Positioned(
                  child: getAppBarUI(context),
                ),
              ],
            ),
            Container(margin: EdgeInsets.only(bottom: 10.h, left: 10.w, right: 10.w, top: 0.h), child: Widget_Donation_Stats_Project(data_project)),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              decoration: BoxDecoration(
                  color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0.r),
                    topRight: Radius.circular(20.0.r),
                    bottomRight: Radius.circular(20.0.r),
                    bottomLeft: Radius.circular(20.0.r),
                  )),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 5.h, bottom: 0.h),
                    child: Text(
                      "التفاصيل",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: HexColor(MyColors.Orange_primary),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: DescriptionTextWidget(
                        text: data_project.description,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (DateTime.now().isAfter(DateTime(2023, 04, 01)))
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h, bottom: 30.h),
                height: 60.h,
                child: Button_Widget(
                  fontSize: 18.sp,
                  color_text: HexColor(MyColors.white),
                  color: HexColor(MyColors.green),
                  onTap: () {
                    Navigator.pushNamed(context, Donations_Send_);
                  },
                  tittle: LocaleKeys.donate_now.tr(),
                ),
              ),
          ],
        )));
  }

  Widget getAppBarUI(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 3.w, right: 3.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            ),
            Container(
              margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
              // alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: HexColor(MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.w),
                    topRight: Radius.circular(10.w),
                    bottomLeft: Radius.circular(10.w),
                    bottomRight: Radius.circular(10.w),
                  )),
              width: AppBar().preferredSize.height + 2,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: HexColor(MyColors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
