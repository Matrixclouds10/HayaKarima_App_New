import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../bloc/about_home/about_home_bloc.dart';
import '../../constants/my_colors.dart';
import '../../data/model/model_about_home.dart';
import '../../generated/locale_keys.g.dart';
import 'DescriptionTextWidget_home.dart';
import 'Skeleton.dart';
import 'button.dart';

class Widget_About_Home extends StatefulWidget {
  @override
  _Widget_About_Home createState() => _Widget_About_Home();
}

class _Widget_About_Home extends State<Widget_About_Home> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return BlocBuilder<AboutHomeBloc, AboutHomeState>(
        builder: (context, state) {
      if (state is About_LoadingState) {
        BlocProvider.of<AboutHomeBloc>(context)
            .add(const Submission_AboutHomeEvent());

        return Container(
            margin: EdgeInsets.only(bottom: 5.h),
            child: Stack(
              children: [
                Container(
                  width: width,
                  margin: EdgeInsets.only(top: 15.h, bottom: 25.h),
                  decoration: BoxDecoration(
                      color: HexColor(MyColors.white),
                      //new Color.fromRGBO(255, 0, 0, 0.0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0.r),
                        topRight: Radius.circular(20.0.r),
                        bottomRight: Radius.circular(20.0.r),
                        bottomLeft: Radius.circular(20.0.r),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          width: width * .40,
                          margin: EdgeInsets.only(
                              left: 30.w, right: 30.w, top: 15.h, bottom: 5.h),
                          child: Container(
                              margin: EdgeInsets.only(left: 2.w, right: 2.w),
                              child: Skeleton(
                                width: width * .70,
                                height: 10.h,
                              ))),
                      Container(
                        margin: EdgeInsets.only(
                            left: 0.w, right: 0.w, bottom: 20.h),
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                        top: 10.h,
                                        bottom: 5.h),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 2.w, right: 2.w),
                                        child: Skeleton(
                                          width: width * .70,
                                          height: 10.h,
                                        ))),
                                Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        left: 15.w,
                                        right: 15.w,
                                        top: 10.h,
                                        bottom: 5.h),
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 2.w, right: 2.w),
                                        child: Skeleton(
                                          width: width * .70,
                                          height: 10.h,
                                        ))),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 140.h,
                    right: width / 3.5,
                    left: width / 3.5,
                    child: Container(
                      alignment: Alignment.center,
                      width: width,
                      height: 40.h,
                      color: HexColor(MyColors.gray).withOpacity(.2),
                    )),
              ],
            ));
      } else if (state is About_Loaded_State) {
        Model_About_Home modelAboutHome = (state).model;
        RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
        String des =
            modelAboutHome.items.description.toString().replaceAll(exp, '');
        return Container(
            child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15.h, bottom: 20.h),
              decoration: BoxDecoration(
                  color: HexColor(MyColors.white),
                  //new Color.fromRGBO(255, 0, 0, 0.0),
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
                    margin: EdgeInsets.only(
                        left: 35.w, right: 35.w, top: 15.h, bottom: 0.h),
                    child: Text(
                      modelAboutHome.items.name,
                      style: TextStyle(
                          fontSize: 22.sp,
                          color: HexColor(MyColors.green),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  ListTile(
                      onTap: () {
                        print("----->flaggggg ");
                        setState(() {
                          flag = !flag;
                        });
                      },
                      title: Container(
                        margin:
                            EdgeInsets.only(left: 0.w, right: 0.w, bottom: 1.h),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 1.h, left: 25.w, right: 25.w, bottom: 25.w),
                          child: DescriptionTextWidget_Home(
                            flag: flag,
                            text: des.replaceAll(';nbsp&','').replaceAll('&nbsp;',''),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            flag
                ? Positioned(
                    bottom: 4.h,
                    right: width / 3.5,
                    left: width / 3.5,
                    child: Container(
                      alignment: Alignment.center,
                      width: width,
                      height: 40.h,
                      child: Button_Widget(
                        fontSize: 18.sp,
                        color_text: HexColor(MyColors.white),
                        color: HexColor(MyColors.green),
                        onTap: () {
                          setState(() {
                            flag = !flag;
                          });
                        },
                        tittle: LocaleKeys.More.tr(),
                      ),
                    ))
                : Container(),
          ],
        ));
      } else {
        return Container();
      }
    });
  }
}
