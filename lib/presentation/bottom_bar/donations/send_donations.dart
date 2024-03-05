// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hayaah_karimuh/constants/my_colors.dart';
import 'package:hayaah_karimuh/generated/locale_keys.g.dart';
import 'package:hayaah_karimuh/presentation/auth/login/login_screen.dart';
import 'package:hayaah_karimuh/presentation/widgets/DescriptionTextWidget.dart';
import 'package:hayaah_karimuh/presentation/widgets/button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/strings.dart';
import '../../widgets/customAlertDialoge.dart';
import '../../widgets/myNaviagtor.dart';
import '../../widgets/webView.dart';

class Donations_Send extends StatelessWidget {
  late var email, password;
  TextEditingController textEditingController_email = TextEditingController();
  TextEditingController textEditingController_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor(MyColors.gray_light2),
          elevation: 0.0,
          toolbarHeight: 105.h,
          flexibleSpace: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.w), bottomRight: Radius.circular(40.w)), gradient: LinearGradient(colors: [HexColor(MyColors.white), Colors.white], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 25.w, right: 25.w),
                      // child: SvgPicture.asset(
                      //   'assets/menu.svg',
                      // ),
                    )),
                Container(
                  color: HexColor(MyColors.white),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40.h, bottom: 4.h),
                  width: 85.w,
                  child: Image.asset('assets/logo.png'),
                ),
                InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: SvgPicture.asset(
                        'assets/svgexport.svg',
                      ),
                    )),
              ],
            ),
          ),
        ),
        backgroundColor: HexColor(MyColors.gray_light2),
        body: SafeArea(
            child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30.h),
              width: width,
              height: 170.0.h,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                placeholder: (context, url) => Image.asset('assets/img.png'),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/img.png',
                  fit: BoxFit.fill,
                ),
                imageUrl: '',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15.h),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 5.h, bottom: 5.h),
                    child: Text(
                      "كل جنيه هيفرق في حياه 58 مليون مواطن",
                      style: TextStyle(fontSize: 18.sp, color: HexColor(MyColors.green), fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 15.h),
                    child: Padding(
                      padding: EdgeInsets.all(0.w),
                      child: DescriptionTextWidget(
                        text: LocaleKeys.body_news.tr(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
            //   decoration: BoxDecoration(
            //     color: HexColor(
            //         MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(2.r),
            //       bottomRight: Radius.circular(2.r),
            //       topLeft: Radius.circular(2.r),
            //       topRight: Radius.circular(2.r),
            //     ),
            //   ),
            //   child: NameInput(
            //     icon: Icon(
            //       Icons.person,
            //       color: HexColor(MyColors.green),
            //     ),
            //     textEditingController: textEditingController_email,
            //     validation_Message: '',
            //     onSaved: (val) {},
            //     maxLines: 1,
            //     onChanged: (val) {},
            //     hintText: "${LocaleKeys.fname.tr()}",
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
            //   decoration: new BoxDecoration(
            //     color: HexColor(
            //         MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
            //     borderRadius: new BorderRadius.only(
            //       bottomLeft: Radius.circular(2.r),
            //       bottomRight: Radius.circular(2.r),
            //       topLeft: Radius.circular(2.r),
            //       topRight: Radius.circular(2.r),
            //     ),
            //   ),
            //   child: NameInput(
            //     icon: Icon(
            //       Icons.email,
            //       color: HexColor(MyColors.green),
            //     ),
            //     textEditingController: textEditingController_email,
            //     validation_Message: '',
            //     onSaved: (val) {},
            //     maxLines: 1,
            //     onChanged: (val) {},
            //     hintText: "${LocaleKeys.mail.tr()}",
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
            //   decoration: new BoxDecoration(
            //     color: HexColor(
            //         MyColors.white), //new Color.fromRGBO(255, 0, 0, 0.0),
            //     borderRadius: new BorderRadius.only(
            //       bottomLeft: Radius.circular(2.r),
            //       bottomRight: Radius.circular(2.r),
            //       topLeft: Radius.circular(2.r),
            //       topRight: Radius.circular(2.r),
            //     ),
            //   ),
            //   child: NameInput(
            //     icon: Icon(
            //       Icons.phone_android,
            //       color: HexColor(MyColors.green),
            //     ),
            //     textEditingController: textEditingController_email,
            //     validation_Message: '',
            //     onSaved: (val) {},
            //     maxLines: 1,
            //     onChanged: (val) {},
            //     hintText: "${LocaleKeys.mobile.tr()}",
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
            //   width: double.infinity,
            //   alignment: Alignment.center,
            //   color: HexColor(MyColors.white),
            //   child: DropdownButtonFormField(
            //     onSaved: (val) {},
            //     validator: (String? val) {
            //       if (val == null || val.trim().length == 0) {
            //         return "${LocaleKeys.Governorate.tr()}";
            //       }
            //       return null;
            //     },

            //     decoration: InputDecoration(
            //       fillColor: Colors.grey,
            //       prefixIcon: Icon(
            //         Icons.add_location_rounded,
            //         color: HexColor(MyColors.green),
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(0.w),
            //         borderSide: BorderSide(
            //           color: HexColor(MyColors.white),
            //         ),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(0.w),
            //         borderSide: BorderSide(
            //           color: HexColor(MyColors.white),
            //         ),
            //       ),
            //     ),
            //     // underline: SizedBox.shrink(),
            //     hint: Text(
            //       "  ${LocaleKeys.Governorate.tr()} ",
            //       style: TextStyle(
            //         color: HexColor(MyColors.gray),
            //         fontSize: 16.sp,
            //       ),
            //     ),
            //     isExpanded: false,
            //     // value: travellers.type,
            //     items: [
            //       const DropdownMenuItem(
            //         child: const Text("cairo"),
            //         value: '',
            //       ),
            //       const DropdownMenuItem(
            //         child: const Text(" cairo"),
            //         value: 'Mrs',
            //       ),
            //       const DropdownMenuItem(
            //         child: const Text(" cairo"),
            //         value: 'Miss',
            //       )
            //     ],
            //     onChanged: (value) {},
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 4.h),
            //   width: double.infinity,
            //   alignment: Alignment.center,
            //   color: HexColor(MyColors.white),
            //   child: DropdownButtonFormField(
            //     onSaved: (val) {},
            //     validator: (String? val) {
            //       if (val == null || val.trim().length == 0) {
            //         return "${LocaleKeys.Governorate.tr()}";
            //       }
            //       return null;
            //     },

            //     decoration: InputDecoration(
            //       fillColor: Colors.white,
            //       prefixIcon: Icon(
            //         Icons.apartment_outlined,
            //         color: HexColor(MyColors.green),
            //       ),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(0.w),
            //         borderSide: BorderSide(
            //           color: HexColor(MyColors.white),
            //         ),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(0.w),
            //         borderSide: BorderSide(
            //           color: HexColor(MyColors.white),
            //         ),
            //       ),
            //     ),
            //     // underline: SizedBox.shrink(),
            //     hint: Text(
            //       "  ${LocaleKeys.City.tr()} ",
            //       style: TextStyle(
            //         color: HexColor(MyColors.gray),
            //         fontSize: 16.sp,
            //       ),
            //     ),
            //     isExpanded: false,
            //     // value: travellers.type,
            //     items: [
            //       const DropdownMenuItem(
            //         child: Text("cairo"),
            //         value: '',
            //       ),
            //       const DropdownMenuItem(
            //         child: Text(" cairo"),
            //         value: 'Mrs',
            //       ),
            //       const DropdownMenuItem(
            //         child: Text(" cairo"),
            //         value: 'Miss',
            //       )
            //     ],
            //     onChanged: (value) {},
            //   ),
            // ),
            if (DateTime.now().isAfter(DateTime(2023, 04, 01)))
              Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 30.h),
                height: 50.h,
                child: Button_Widget(
                  fontSize: 18.sp,
                  color_text: HexColor(MyColors.white),
                  color: HexColor(MyColors.green),
                  onTap: () async {
                    SharedPreferences preferences = await SharedPreferences.getInstance();
                    preferences.getString(ACCESS_TOKEN) == null
                        ? showDialog(
                            barrierColor: Colors.black26,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialog(
                                fromLogin: false,
                                title: "يرجي التسجيل اولا",
                                image: 'assets/lo.png',
                                onBtnTap: () {
                                  myNavigate(screen: Login_Screen(), context: context);
                                },
                                btnTitle: 'تسجيل الدخول',
                              );
                            },
                          )
                        : myNavigate(context: context, screen: const WebViewPage('https://hayhkarima.com/payments'));
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
              width: AppBar().preferredSize.height + 20,
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
