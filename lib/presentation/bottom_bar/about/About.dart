import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../bloc/about/about_bloc.dart';
import '../../../bloc/step_pageview/pageview_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../data/model/Model_About.dart';
import '../../../generated/locale_keys.g.dart';
import '../navigationDrawer.dart';
import '../../widgets/DescriptionTextWidget.dart';
import '../../widgets/Skeleton.dart';
import '../../widgets/widget_about_list.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/src/provider.dart';
import 'package:readmore/readmore.dart';

class AboutPage extends StatelessWidget {
  ExpandableController expandableController = new ExpandableController();

  getTile(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0.sp,
                color: HexColor(MyColors.black),
              ),
            ),
          ],
        ),
        Container(
          height: 16.0.w,
          width: 16.0.w,
          alignment: Alignment.center,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20.0.sp,
            color: HexColor(MyColors.gray),
          ),
        ),
      ],
    );
  }

  Widget bloc_about(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<AboutBloc, AboutState>(builder: (context, state) {
      if (state is About_LoadingState) {
        BlocProvider.of<AboutBloc>(context).add(Submission_AboutEvent());

        return Column(children: [
          Stack(
            children: [
              Container(
                width: width,
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
                      margin:
                          EdgeInsets.only(left: 0.w, right: 0.w, bottom: 30.h),
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
                                      bottom: 2.h),
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
            ],
          ),
          Container(
              width: width,
              margin: EdgeInsets.only(
                  left: 5.w, right: 5.w, top: 15.h, bottom: 5.h),
              child: Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: Skeleton(
                    width: width * .70,
                    height: 45.h,
                  ))),
          Container(
              width: width,
              margin:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
              child: Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: Skeleton(
                    width: width * .70,
                    height: 45.h,
                  ))),
          Container(
              width: width,
              margin:
                  EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
              child: Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: Skeleton(
                    width: width * .70,
                    height: 45.h,
                  ))),
        ]);
      } else if (state is About_Loaded_State) {
        Model_About model_about = (state).model;
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: 10.w, right: 10.w, top: 40.h, bottom: 0.h),
              decoration: BoxDecoration(
                  color: HexColor(MyColors.white),
                  //new Color.fromRGBO(255, 0, 0, 0.0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0.r),
                    topRight: Radius.circular(10.0.r),
                    bottomRight: Radius.circular(10.0.r),
                    bottomLeft: Radius.circular(10.0.r),
                  )),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
                    // child: Text(
                    //   "${LocaleKeys.About.tr()}",
                    //   style: TextStyle(
                    //       fontSize: 18.sp,
                    //       color: HexColor(MyColors.black),
                    //       fontWeight: FontWeight.w600),
                    // ),

                    child: Container(
                        margin: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: ExpandablePanel(
                            header: Container(
                                margin:
                                    EdgeInsets.only(left: 10.w, right: 10.w),
                                child: Text(
                                  '${LocaleKeys.About.tr()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: HexColor(MyColors.black)),
                                )),
                            collapsed: Container(),
                            expanded: Text(
                              '${LocaleKeys.body_news.tr()}',
                              style: TextStyle(fontSize: 18.sp),
                            ))),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 15.h),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(16.0),
                  //     child: DescriptionTextWidget(
                  //       text: '${LocaleKeys.body_news.tr()}',
                  //
                  //
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2.h, bottom: 30.h),
              width: width,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: model_about.items.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Widget_About_List(
                      "${model_about.items.data[index].name}",
                      "${model_about.items.data[index].description}");
                },
              ),
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: HexColor(MyColors.gray_light2),
        body: WillPopScope(
            onWillPop: () async {
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(0, 0));

              return false;
            },
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  width: width,
                  height: 220.0.h,
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        Image.asset('assets/img.png'),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/img.png',
                      fit: BoxFit.fill,
                    ),
                    imageUrl: '',
                  ),
                ),
                bloc_about(context),
              ],
            )));
  }
}
