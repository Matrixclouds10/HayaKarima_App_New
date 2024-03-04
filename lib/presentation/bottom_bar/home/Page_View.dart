import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/data/echo.dart';
import '../../../bloc/langouage/langouage_cubit.dart';
import '../../../bloc/step_pageview/pageview_bloc.dart';
import '../Complaints/complaints_page.dart';
import '../about/About.dart';
import '../donation_stats/Donation_Stats.dart';
import '../donations/Page_ViewDonations.dart';
import '../interactive_map/interactive_map.dart';
import '../langouage/langouage.dart';
import '../new_details/new_details.dart';
import '../news_screen/News_Screen.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Home_Screen.dart';

class Page_View extends StatefulWidget {
  @override
  _Page_View createState() => _Page_View();
}

class _Page_View extends State<Page_View> {
  PageController controller = PageController();
  int index = 0;

  int _curr = 0;
  late int tab = 0;

  Widget bloc_page() {
    return BlocListener<PageviewBloc, PageviewState>(
        listener: (context, state) {
          kEcho("state is $state");
          // do stuff here based on BlocA's state
          if (state is step_indexstate_one) {
            controller.jumpToPage((state).step_index);
            tab = (state).index;
          }
        },
        child: Container(
            // margin: EdgeInsets.only(top: 40.h),
            child: PageView(
          physics: NeverScrollableScrollPhysics(),

          children: [
            Center(child: new Home_Screen()),
            Center(child: new AboutPage()),
            Center(child: DonationStats_Page()),
            Center(child: News_Screen()),
            Center(child: Langouage_Screen()),
            Center(child: Interactive_Map()),
            Center(child: Page_ViewDonations()),
            Center(child: complaints_page()),
          ],
          scrollDirection: Axis.horizontal,

          // reverse: true,
          // physics: BouncingScrollPhysics(),
          controller: controller,
          onPageChanged: (num) {
            setState(() {
              _curr = num;
            });
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: bloc_page(),
    );
  }
}
