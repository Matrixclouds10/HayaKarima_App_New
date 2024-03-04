import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../bloc/AuthHandel/auth_handel_bloc.dart';
import '../../bloc/about/about_bloc.dart';
import '../../bloc/about_home/about_home_bloc.dart';
import '../../bloc/beneficiaries/beneficiaries_bloc.dart';
import '../../bloc/bloc_complain/complain_bloc.dart';
import '../../bloc/counters/counters_bloc.dart';
import '../../bloc/country_list/flight_country_list_bloc.dart';
import '../../bloc/donations/donations_bloc.dart';
import '../../bloc/idea_area/idea_area_bloc.dart';
import '../../bloc/news/news_bloc.dart';
import '../../bloc/partners/partners_bloc.dart';
import '../../bloc/project/project_bloc.dart';
import '../../bloc/slider/slider_bloc.dart';
import '../../bloc/step_pageview/pageview_bloc.dart';
import '../../constants/my_colors.dart';
import '../../data/data_source/local/local.dart';
import '../../generated/locale_keys.g.dart';
import 'donations/Page_ViewDonations.dart';
import 'home/Page_View.dart';
import 'navigationDrawer.dart' as drawer;
import 'profile/profile_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../data/data_source/api/services.dart';
import '../../data/repository/repository.dart';
import 'Complaints/complaints_page.dart';

class Bottom_Bar_Screen extends StatefulWidget {
  @override
  _Bottom_Bar_Screen createState() => _Bottom_Bar_Screen();
}

class _Bottom_Bar_Screen extends State<Bottom_Bar_Screen> {
  int _selectedIndex = 0;
  late Repository repository;

  static List<Widget> _widgetOptions = <Widget>[
    Page_View(),
    complaints_page(),
    Profile_Screen(),
  ];

  @override
  void initState() {
    repository = Repository(Services(), Data_Local());

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.read<PageviewBloc>().add(Start_Eventstep());
    context.read<PageviewBloc>().add(NextStep_one(0, 0));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Repository>(create: (context) => repository),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<NewsBloc>(create: (BuildContext context) => NewsBloc(repository)),
              // BlocProvider<PageviewBloc>(
              //     create: (BuildContext context) => PageviewBloc()),
              BlocProvider<CountryListBloc>(create: (BuildContext context) => CountryListBloc(repository)),
              BlocProvider<IdeaAreaBloc>(create: (BuildContext context) => IdeaAreaBloc(repository)),
              BlocProvider<ComplainBloc>(create: (BuildContext context) => ComplainBloc(repository)),
              BlocProvider<CountersBloc>(create: (BuildContext context) => CountersBloc(repository)),
              BlocProvider<PartnersBloc>(create: (BuildContext context) => PartnersBloc(repository)),
              BlocProvider<SliderBloc>(create: (BuildContext context) => SliderBloc(repository)),
              BlocProvider<AboutHomeBloc>(create: (BuildContext context) => AboutHomeBloc(repository)),
              BlocProvider<AboutBloc>(create: (BuildContext context) => AboutBloc(repository)),
              BlocProvider<DonationsBloc>(create: (BuildContext context) => DonationsBloc(repository)),
              BlocProvider<BeneficiariesBloc>(create: (BuildContext context) => BeneficiariesBloc(repository)),
              BlocProvider<ProjectBloc>(create: (BuildContext context) => ProjectBloc(repository)),
              BlocProvider<AuthHandelBloc>(create: (BuildContext context) => AuthHandelBloc(repository)),
            ],
            child: Scaffold(
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
                            child: SvgPicture.asset(
                              'assets/menu.svg',
                            ),
                          )),
                      Container(
                        color: HexColor(MyColors.white),
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 40.h, bottom: 4.h),
                        width: 85.w,
                        child: Image.asset('assets/logo.png'),
                      ),
                      if (DateTime.now().isAfter(DateTime(2023, 04, 01)))
                        InkWell(
                            onTap: () {
                              context.read<PageviewBloc>().add(Start_Eventstep());
                              context.read<PageviewBloc>().add(NextStep_one(6, 1));
                            },
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
              drawer: drawer.NavigationDrawer(
                onTap: () {
                  //current index
                  _onItemTapped(0);
                },
              ),
              bottomNavigationBar: Container(
                  height: 86.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20.w), topLeft: Radius.circular(20.w)),
                    boxShadow: [
                      BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
                    ],
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.w),
                        topRight: Radius.circular(20.w),
                      ),
                      child: BottomNavigationBar(
                        items: <BottomNavigationBarItem>[
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.home,
                              size: 27.w,
                              color: HexColor(MyColors.green),
                            ),
                            label: LocaleKeys.Home.tr(),
                          ),
                          BottomNavigationBarItem(
                            icon: SvgPicture.asset(
                              'assets/complaint.svg',
                              height: 27.w,
                            ),
                            label: LocaleKeys.Complaints_and_suggestions.tr(),
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(
                              Icons.person,
                              size: 27.w,
                              color: HexColor(MyColors.green),
                            ),
                            label: LocaleKeys.profile_page.tr(),
                          ),
                        ],
                        currentIndex: _selectedIndex,
                        selectedItemColor: HexColor(MyColors.black),
                        unselectedLabelStyle: TextStyle(
                          color: HexColor(MyColors.black),
                        ),
                        selectedLabelStyle: TextStyle(
                          color: HexColor(MyColors.black),
                        ),
                        unselectedItemColor: HexColor(MyColors.black),
                        onTap: _onItemTapped,
                      ))),
              body: Container(
                margin: EdgeInsets.only(top: 10.h),
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            )));
  }
}
