import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/my_colors.dart';
import '../../../generated/locale_keys.g.dart';
import 'Donations.dart';
import 'Donations_Project.dart';
import 'package:hexcolor/hexcolor.dart';

class Page_ViewDonations extends StatefulWidget {
  @override
  _Page_ViewDonations createState() => _Page_ViewDonations();
}

class _Page_ViewDonations extends State<Page_ViewDonations> with SingleTickerProviderStateMixin {
  late TabController controller;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: HexColor(MyColors.gray_light2),
      // body: DefaultTabController(
      //   length: 2,
      //
      //   child: Column(
      //     children: <Widget>[
      //       SizedBox(height: 10.h,),
      //       Container(
      //         width: double.infinity,
      //         margin: EdgeInsets.only(
      //             left: 25.w, right: 25.w, top: 5.h, bottom: 20.h),
      //         child: Text(
      //           "${LocaleKeys.Donations.tr()}",
      //           style: TextStyle(
      //               fontSize: 22.sp,
      //               color: HexColor(MyColors.green),
      //               fontWeight: FontWeight.w600),
      //         ),
      //       ),
      //       ButtonsTabBar(
      //         backgroundColor: HexColor(MyColors.green),
      //         // unselectedBackgroundColor: HexColor(MyColors.white),
      //         buttonMargin:  EdgeInsets.only(left: 10.w,right: 10.w),
      //         height: 50.h,
      //         duration: 100,
      //         center: false,
      //           unselectedDecoration:BoxDecoration(
      //             color: HexColor(MyColors.white),
      //
      //           ),
      //
      //         unselectedLabelStyle: TextStyle(color: HexColor(MyColors.gray),fontWeight: FontWeight.w600,fontSize: 18.sp),
      //         labelStyle: TextStyle(color:HexColor(MyColors.white), fontWeight: FontWeight.w600,fontSize: 18.sp),
      //
      //         tabs: [
      //           Tab(
      //             child:Container(
      //               width: width/2.5,
      //               height: 90.h,
      //               child: Align(
      //                 child: Text("${LocaleKeys.Project_Donations.tr()}"),
      //                 alignment: Alignment.center,
      //               ),
      //             )
      //
      //           ),
      //           Tab(
      //               child:Container(
      //                 width: width/2.5,
      //                 height: 90.h,
      //                 child: Align(
      //                   child: Text("${LocaleKeys.Beneficiaries_Donations.tr()}"),
      //                   alignment: Alignment.center,
      //                 ),
      //               )
      //
      //           ),
      //
      //         ],
      //       ),
      //       SizedBox(height: 10.h,),
      //
      //       Expanded(
      //         child: TabBarView(
      //           physics: NeverScrollableScrollPhysics(),
      //           children: <Widget>[
      //             Center(
      //               child: Project_Page(),
      //             ),
      //             Center(
      //               child: Donations_Page(),
      //             ),
      //
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      body: NestedScrollView(
          controller: _scrollController,
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                  child: Column(children: [
                SizedBox(
                  height: 10.h,
                ),
                if (DateTime.now().isAfter(DateTime(2023, 04, 01)))
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 5.h, bottom: 20.h),
                    child: Text(
                      "${LocaleKeys.Donations.tr()}",
                      style: TextStyle(fontSize: 22.sp, color: HexColor(MyColors.green), fontWeight: FontWeight.w600),
                    ),
                  ),
                Container(
                    margin: EdgeInsets.only(left: 25.w, right: 25.w),
                    child: TabBar(
                      onTap: (val) {
                        setState(() {});
                      },
                      // indicatorColor:HexColor(MyColors.white).withOpacity(.1),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          5.w,
                        ),
                        color: HexColor(MyColors.green),
                      ),
                      labelColor: HexColor(MyColors.white),
                      unselectedLabelColor: HexColor(MyColors.gray),
                      labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                      labelPadding: EdgeInsets.only(left: 5.w, right: 5.w),

                      controller: controller,
                      tabs: [
                        Container(
                            decoration: controller.index == 0
                                ? BoxDecoration()
                                : BoxDecoration(
                                    color: HexColor(MyColors.white),
                                    // border: Border.all(
                                    //   color: HexColor(MyColors.green)
                                    // ),
                                  ),
                            height: 45.h,
                            child: Align(alignment: Alignment.center, child: Text("${LocaleKeys.Project_Donations.tr()}"))),
                        Container(
                            decoration: controller.index == 1
                                ? BoxDecoration()
                                : BoxDecoration(
                                    color: HexColor(MyColors.white),
                                  ),
                            height: 45.h,
                            child: Align(alignment: Alignment.center, child: Text("${LocaleKeys.Beneficiaries_Donations.tr()}"))),
                      ],
                    )),
              ])),
            ];
          },
          body: Container(
            margin: EdgeInsets.only(top: 3.h),
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                Project_Page(),
                Donations_Page(),
              ],
            ),
          )),
    );
  }
}
