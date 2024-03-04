import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/presentation/bottom_bar/home/web_map.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../bloc/counters/counters_bloc.dart';
import '../../../bloc/partners/partners_bloc.dart';
import '../../../bloc/slider/slider_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../data/model/model_counters.dart';
import '../../../data/model/model_partners.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../router/router_path.dart';
import '../../widgets/Skeleton.dart';
import '../../widgets/button.dart';
import '../../widgets/project_stats.dart';
import '../../widgets/project_stats_loading.dart';
import '../../widgets/widget_about_home.dart';

class Home_Screen extends StatefulWidget {
  @override
  _Home_Screen createState() => _Home_Screen();
}

class _Home_Screen extends State<Home_Screen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);
  int activeIndex = 0;
  bool webIsLoading = true;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    super.initState();
  }

  facilityTile(String imag) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 95.w,
          height: 78.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: HexColor(MyColors.white),
              border: Border.all(
                color: HexColor((MyColors.gray)),
                width: .3.w,
              )),
          child: Image.asset(imag),
        ),
      ],
    );
  }

  Widget bloc_slider() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<SliderBloc, SliderState>(builder: (context, state) {
      if (state is Slider_LoadingState) {
        BlocProvider.of<SliderBloc>(context).add(const Submission_SliderEvent());

        return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
          Container(
            width: double.infinity,
            height: 165.h,
            margin: EdgeInsets.only(top: 5.h, right: 5.w, left: 5.w, bottom: 2.h),
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.only(left: 2.w, right: 2.w),
                child: Skeleton(
                  width: width,
                  height: 160.h,
                )),
          ),
          Container(
            height: 30.h,
            width: width,
            margin: EdgeInsets.only(top: 10.h, right: 5.w, left: 5.w, bottom: 5.h),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: CircleSkeleton(
                      size: 25.w,
                    )),
                Container(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: CircleSkeleton(
                      size: 25.w,
                    )),
                Container(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w),
                    child: CircleSkeleton(
                      size: 25.w,
                    )),
              ],
            ),
          )
        ]);
      } else if (state is Slider_Loaded_State) {
        Model_Partners modelPartners = (state).model;
        print("----->Slider_Loaded_State ${(state).model.items!.length}");
        return Column(
          children: <Widget>[
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
              height: 160.h,
              width: width,
              child: CarouselSlider.builder(
                itemBuilder: (context, index, realIdx) {
                  return SizedBox(
                    width: width,
                    // color: HexColor(MyColors.green),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0.w),
                        child: CachedNetworkImage(
                            repeat: ImageRepeat.repeat,
                            key: UniqueKey(),
                            imageUrl: "${modelPartners.items!.isNotEmpty ? modelPartners.items![index].path : ""}",
                            fit: BoxFit.fill,
                            useOldImageOnUrlChange: true,
                            filterQuality: FilterQuality.high,
                            // alignment: Alignment.,
                            width: double.infinity,
                            height: double.infinity,
                            placeholder: (context, url) => Image.asset('assets/logo.png'),
                            errorWidget: (context, url, error) => Image.asset(
                                  'assets/logo.png',
                                  fit: BoxFit.fill,
                                ),
                            colorBlendMode: BlendMode.darken),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  onPageChanged: (index, reson) {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                  // height: 200.h,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),

                  scrollDirection: Axis.horizontal,
                  viewportFraction: 1.0,
                ),
                itemCount: modelPartners.items!.length,
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 10.h, bottom: 10.h),
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: modelPartners.items!.length,
                  effect: JumpingDotEffect(dotHeight: 6.h, dotWidth: 40.w, activeDotColor: HexColor(MyColors.green), dotColor: HexColor(MyColors.gray)),
                )),
          ],
        );
      } else if (state is Slider_ErrorState) {
        print("----->Slider_ErrorState :  ${(state).message} ");
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w, bottom: 5.h),
          alignment: Alignment.center,
          child: Container(
              margin: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Skeleton(
                width: width,
                height: 160.h,
              )),
        );
      } else {
        return Container();
      }
    });
  }

  Widget project_state() {
    return BlocBuilder<CountersBloc, CountersState>(builder: (context, state) {
      if (state is Counters_LoadingState) {
        BlocProvider.of<CountersBloc>(context).add(const Submission_CountersEvent());

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Project_Stats_Loading(),
                ),
                Container(
                  child: Project_Stats_Loading(),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Project_Stats_Loading(),
                ),
                Container(
                  child: Project_Stats_Loading(),
                )
              ],
            ),
          ],
        );
      } else if (state is Counters_Loaded_State) {
        Model_Counters modelCounters = (state).model;
        return Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Project_Stats(
                    tittle: LocaleKeys.City.tr(),
                    count: '${modelCounters.items.cities}',
                    icon: Icon(
                      Icons.apartment_outlined,
                      size: 20,
                      color: HexColor(MyColors.white),
                    ),
                  ),
                ),
                Container(
                  child: Project_Stats(
                    tittle: LocaleKeys.villages.tr(),
                    count: '${modelCounters.items.villages}',
                    icon: Icon(
                      Icons.apartment_outlined,
                      size: 20,
                      color: HexColor(MyColors.white),
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Project_Stats(
                    tittle: LocaleKeys.Donations.tr(),
                    count: '${modelCounters.items.donations}',
                    icon: Icon(
                      Icons.favorite,
                      size: 20,
                      color: HexColor(MyColors.white),
                    ),
                  ),
                ),
                Container(
                  child: Project_Stats(
                    tittle: LocaleKeys.Governorate.tr(),
                    count: '${modelCounters.items.governments}',
                    icon: Icon(
                      Icons.location_city_sharp,
                      size: 20,
                      color: HexColor(MyColors.white),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      } else {
        return Container();
      }
      // return widget here based on BlocA's state
    });
  }

  Widget bloc_partners() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<PartnersBloc, PartnersState>(builder: (context, state) {
      if (state is Partners_LoadingState) {
        print("----->partnersLoading");
        BlocProvider.of<PartnersBloc>(context).add(const Submission_PartnersEvent());

        return Container(
          width: double.infinity,
          height: 78.h,
          margin: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w, bottom: 5.h),
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
            ],
          ),
        );
      } else if (state is Partners_Loaded_State) {
        print("----->Partners_Loaded_State ${(state).model.items!.length}");
        Model_Partners modelPartners = (state).model;
        return Container(
          width: double.infinity,
          height: 80.h,
          margin: EdgeInsets.only(top: 1.h, right: 5.w, left: 5.w, bottom: 5.h),
          alignment: Alignment.center,
          child: ListView.builder(
            itemCount: modelPartners.items!.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CachedNetworkImage(
                    imageUrl: (state).model.items![index].path!,
                    imageBuilder: (context, imageProvider) => Container(
                      height: 80.h,
                      width: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset('assets/loading.gif'),
                    errorWidget: (context, url, error) => Image.asset('assets/logo.png'),
                  ));
            },
          ),
        );
      } else if (state is Partners_ErrorState) {
        print("----->Partners_ErrorState :  ${(state).message} ");
        return Container(
          width: double.infinity,
          height: 78.h,
          margin: EdgeInsets.only(top: 20.h, right: 5.w, left: 5.w, bottom: 5.h),
          alignment: Alignment.center,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
              Container(
                  margin: EdgeInsets.only(left: 2.w, right: 2.w),
                  child: CircleSkeleton(
                    size: 90.w,
                  )),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: HexColor(MyColors.gray_light2),
        body: SafeArea(
          child: ListView(shrinkWrap: false, children: <Widget>[
            bloc_slider(),
            if (DateTime.now().isAfter(DateTime(2023, 04, 01)))
              Stack(children: [
                Container(
                  margin: EdgeInsets.only(top: 15.h, bottom: 20.h),
                  padding: EdgeInsets.only(bottom: 5.h),
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
                        margin: EdgeInsets.only(left: 35.w, right: 35.w, top: 15.h, bottom: 0.h),
                        child: Text(
                          "التبرعات",
                          style: TextStyle(fontSize: 22.sp, color: HexColor(MyColors.green), fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 1.h),
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h, left: 25.w, right: 25.w, bottom: 25.w),
                          child: Text(
                            " كل جنيه هيفرق في حياة 58 مليون مواطن تقدر وانت في مكانك تساهم في تغيير حياة اكثر من نصف سكان مصر علشان نوفرلهم حياة كريمة...",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 2.h,
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
                          Navigator.pushNamed(context, Donations_Send_);
                        },
                        tittle: LocaleKeys.donate_now.tr(),
                      ),
                    )),
              ]),
            Widget_About_Home(),
            ListTile(
                onTap: () {},
                title: Container(
                  margin: EdgeInsets.only(top: 1.h, right: 5.w, left: 5.w, bottom: 5.h),
                  child: Text(
                    LocaleKeys.Partners.tr(),
                    style: TextStyle(fontSize: 20, color: HexColor(MyColors.gray)),
                  ),
                )),
            bloc_partners(),
            ListTile(
                onTap: () {},
                title: Container(
                  margin: EdgeInsets.only(top: 15.h, right: 5.w, left: 5.w, bottom: 5.h),
                  child: Text(
                    LocaleKeys.Project_Stats.tr(),
                    style: TextStyle(fontSize: 20, color: HexColor(MyColors.gray)),
                  ),
                )),
            Container(margin: EdgeInsets.only(top: 1.h, right: 25.w, left: 25.w, bottom: 1.h), child: project_state()),
            const WebviewMap(),
          ]),
        ));
  }
}
