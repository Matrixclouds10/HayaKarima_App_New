import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/src/provider.dart';

import '../../../bloc/donations/donations_bloc.dart';
import '../../../bloc/step_pageview/pageview_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../data/model/model_donations.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widgets/List_donationstate_loading.dart';
import '../../widgets/widget_donation_stats.dart';

class DonationStats_Page extends StatefulWidget {
  @override
  _DonationStats_Page createState() => _DonationStats_Page();
}

class _DonationStats_Page extends State<DonationStats_Page> {
  final PagingController<int, Data_Donations> pagingController =
      PagingController(firstPageKey: 1);
  int PageKey = 0;
  String? goveId = '';
  String? cityId = '';
  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      // _fetchPage(pageKey);
      BlocProvider.of<DonationsBloc>(context)
          .add(Donations_loaded(pageKey, goveId!, cityId!));
    });
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: HexColor(MyColors.gray_light2),
        body: WillPopScope(
            onWillPop: () async {
              context.read<PageviewBloc>().add(Start_Eventstep());
              context.read<PageviewBloc>().add(NextStep_one(0, 0));

              return false;
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .01),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                        left: 25.w, right: 25.w, top: 15.h, bottom: 15.h),
                    child: Text(
                      LocaleKeys.Donation_stats.tr(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: HexColor(MyColors.green),
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  BlocBuilder<DonationsBloc, DonationsState>(
                      builder: (context, state) {
                    if (state is Donations_LoadingState) {
                      BlocProvider.of<DonationsBloc>(context)
                          .add(Donations_loaded(1, goveId!, cityId!));

                      return SizedBox(
                          width: width,
                          height: height,
                          child: ListView(
                            children: <Widget>[
                              List_DonationState_Loading(),
                              List_DonationState_Loading(),
                              List_DonationState_Loading(),
                              List_DonationState_Loading(),
                              List_DonationState_Loading(),
                            ],
                          ));
                    } else if (state is Donations_Loaded_State) {
                      final list = (state).list.items.data;
                      if (list.length < 20) {
                        print("----->appendLastPage");
                        pagingController.appendLastPage(list);
                      } else {
                        PageKey++;
                        final nextPageKey = PageKey + 1;
                        pagingController.appendPage(list, nextPageKey);
                      }
                      return RefreshIndicator(
                          onRefresh: () => Future.sync(() {
                                context
                                    .read<DonationsBloc>()
                                    .add(StartDonationsEvent());
                                BlocProvider.of<DonationsBloc>(context)
                                    .add(Donations_loaded(1, goveId!, cityId!));
                                pagingController.refresh();
                              }),
                          child: PagedListView<int, Data_Donations>(
                              pagingController: pagingController,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              builderDelegate:
                                  PagedChildBuilderDelegate<Data_Donations>(
                                itemBuilder: (context, item, index) =>
                                    Widget_Donation_Stats(item),
                              )));
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            )));
  }
}
