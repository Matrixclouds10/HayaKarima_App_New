import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/enums/filter_enum.dart';
import 'package:hayaah_karimuh/empolyer/providers/projects_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/filter_dialog.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/project_details_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import 'notifications_view.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late ProjectsProvider _projectsProvider;
  late MainProvider _mainProvider;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _countriesScrollController = ScrollController();
  final ScrollController _govsScrollController = ScrollController();
  final ScrollController _citiesScrollController = ScrollController();
  final ScrollController _villagesScrollController = ScrollController();
  final ScrollController _independentsScrollController = ScrollController();

  bool isLoading = false;
  bool refresh = false;
  String? _searchQuery;

  bool init = false;

  int page = 1;

  String govName = 'المحافظة';
  String cityName = 'المدينة';
  String villageName = 'القرية';
  String independentName = 'التابع';

  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _projectsProvider = Provider.of<ProjectsProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    if (!init) {
      _projectsProvider.getProjects(
        page: page,
        queries: {
          'country': 1,
          'govern_id': _projectsProvider.governorate != null ? _projectsProvider.governorate!.id : '',
          'city': _projectsProvider.city != null ? _projectsProvider.city!.id : '',
          'village': _projectsProvider.village != null ? _projectsProvider.village!.id : '',
          'independent': _projectsProvider.independent != null ? _projectsProvider.independent!.id : '',
          'search': _projectsProvider.query ?? '',
        },
      );
      init = true;
    }
  }

  Future<void> _showFilterDialog(BuildContext context, {required Filter type, Map<String, dynamic>? queries}) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FilterDialog(
          filterType: type,
          queries: queries,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _projectsProvider.projects.clear();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(pagination);
    _searchController.addListener(() {
      _projectsProvider.setSearchQuery(_searchController.value.text);
    });
    super.initState();
  }

  void pagination() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      log('Pagination Callback');
      setState(() {
        // isLoading = true;
        page += 1;
      });
      _projectsProvider.getProjects(page: page, queries: {
        'country': 1,
        'govern_id': _projectsProvider.governorate != null ? _projectsProvider.governorate!.id : '',
        'city': _projectsProvider.city != null ? _projectsProvider.city!.id : '',
        'village': _projectsProvider.village != null ? _projectsProvider.village!.id : '',
        'independent': _projectsProvider.independent != null ? _projectsProvider.independent!.id : '',
        'search': _projectsProvider.query ?? '',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 114,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Color(0x29000000), offset: Offset(0, 2), blurRadius: 6, spreadRadius: 0),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsetsDirectional.only(top: 42, start: 5, end: 26, bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton<int>(
                        onSelected: (index) async {
                          if (index == 0) {
                            log('Profile');
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                          } else {
                            log('Logout');
                            await _mainProvider.logout();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => SplashScreen(),
                                ),
                                (route) => false);
                          }
                        },
                        shape: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffc1c1c1),
                            width: 1,
                          ),
                        ),
                        color: Colors.white,
                        icon: SvgPicture.asset(SvgImages.optionsMenu),
                        itemBuilder: (ctx) => [
                          PopupMenuItem(
                            value: 0,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  SvgImages.dummyUser,
                                  width: 14,
                                  height: 16,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "البروفايل",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                              textDirection: TextDirection.rtl,
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  SvgImages.logout,
                                  width: 14,
                                  height: 16,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "خروج",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                              textDirection: TextDirection.rtl,
                              // mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 66,
                        height: 74,
                        child: Image.asset(
                          PngImages.logo,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: Stack(
                            children: [
                              const PositionedDirectional(
                                bottom: 0,
                                end: 0,
                                child: Icon(
                                  Icons.notifications,
                                  color: AppColors.primaryColor,
                                  size: 32,
                                ),
                              ),
                              PositionedDirectional(
                                top: 0,
                                start: 0,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.appOrange,
                                  ),
                                  child: Center(
                                    child: Text(
                                      _mainProvider.notificationCount.toString(),
                                      style: GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(5),
                        bottomEnd: Radius.circular(5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'المشاريع',
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        height: 41,
                        // alignment: Alignment.centerLeft,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          textAlignVertical: TextAlignVertical.center,
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          initialValue: null,
                          textInputAction: TextInputAction.done,
                          style: GoogleFonts.cairo(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                          decoration: InputDecoration(
                            hintText: 'بحث',
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                // await _projectsProvider.getCountries(
                                //     page: page);
                                // log('Filter Clicked!');
                                log('Show Filter -> ${_projectsProvider.showFilter}');

                                if (!_projectsProvider.showFilter) {
                                  _projectsProvider.setShowFilter(true);
                                } else {
                                  _projectsProvider.setShowFilter(false);
                                }
                              },
                              child: const Icon(Icons.filter_alt_outlined),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Theme.of(context).primaryColor),
                            ),
                            hintStyle: GoogleFonts.cairo(
                              color: AppColors.hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            floatingLabelStyle: GoogleFonts.cairo(
                              color: AppColors.hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            counterStyle: GoogleFonts.cairo(
                              color: AppColors.hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            helperStyle: GoogleFonts.cairo(
                              color: AppColors.hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            labelStyle: GoogleFonts.cairo(
                              color: AppColors.hintColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                            errorStyle: const TextStyle(height: 1.5),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        log('Query -> ${_projectsProvider.query}');
                        setState(() {
                          page = 1;
                        });
                        _projectsProvider.searchProjects(page: page, queries: {
                          'country': 1,
                          'govern_id': _projectsProvider.governorate != null ? _projectsProvider.governorate!.id : '',
                          'city': _projectsProvider.city != null ? _projectsProvider.city!.id : '',
                          'village': _projectsProvider.village != null ? _projectsProvider.village!.id : '',
                          'independent': _projectsProvider.independent != null ? _projectsProvider.independent!.id : '',
                          'search': _projectsProvider.query ?? '',
                        });
                      },
                      child: const SizedBox(
                        height: 38,
                        child: Icon(Icons.search),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _projectsProvider.showGovs,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showFilterDialog(context, type: Filter.governorates, queries: {'county_id': 1});
                      },
                      child: Container(
                        height: 41,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _projectsProvider.governorate != null ? _projectsProvider.governorate!.name! : govName,
                              style: GoogleFonts.cairo(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              (Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _projectsProvider.showCities,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showFilterDialog(context, type: Filter.cities, queries: {
                          'country': 1,
                          'govern_id': _projectsProvider.governorate != null ? _projectsProvider.governorate!.id : '',
                          'city': _projectsProvider.city != null ? _projectsProvider.city!.id : '',
                          'village': _projectsProvider.village != null ? _projectsProvider.village!.id : '',
                          'independent': _projectsProvider.independent != null ? _projectsProvider.independent!.id : '',
                          'search': _projectsProvider.query ?? '',
                        });
                      },
                      child: Container(
                        height: 41,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _projectsProvider.city != null ? _projectsProvider.city!.name! : cityName,
                              style: GoogleFonts.cairo(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              (Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _projectsProvider.showVillages,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showFilterDialog(context, type: Filter.villages, queries: {
                          'country': 1,
                          'government': _projectsProvider.governorate != null ? _projectsProvider.governorate!.id : '',
                          'city': _projectsProvider.city != null ? _projectsProvider.city!.id : '',
                          'village': _projectsProvider.village != null ? _projectsProvider.village!.id : '',
                          'independent': _projectsProvider.independent != null ? _projectsProvider.independent!.id : '',
                          'search': _projectsProvider.query ?? '',
                        });
                      },
                      child: Container(
                        height: 41,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _projectsProvider.village != null ? _projectsProvider.village!.name! : villageName,
                              style: GoogleFonts.cairo(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              (Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _projectsProvider.showIndependents,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showFilterDialog(context, type: Filter.independents, queries: {
                          'country': 1,
                          'govern_id': _projectsProvider.governorate != null ? _projectsProvider.governorate!.id : '',
                          'city': _projectsProvider.city != null ? _projectsProvider.city!.id : '',
                          'village': _projectsProvider.village != null ? _projectsProvider.village!.id : '',
                          'independent': _projectsProvider.independent != null ? _projectsProvider.independent!.id : '',
                          'search': _projectsProvider.query ?? '',
                        });
                      },
                      child: Container(
                        height: 41,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _projectsProvider.independent != null ? _projectsProvider.independent!.name! : independentName,
                              style: GoogleFonts.cairo(
                                color: AppColors.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              (Icons.keyboard_arrow_down),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _projectsProvider.projects.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: _projectsProvider.projects.length,
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          log('Project: ${_projectsProvider.projects[index].toJson()}');
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ProjectDetailsScreen(),
                                  settings: RouteSettings(arguments: _projectsProvider.projects[index].toJson()),
                                ),
                              );
                            },
                            child: Container(
                              width: width,
                              // height: 125,
                              margin: const EdgeInsets.symmetric(vertical: 9),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(color: Color(0x29000000), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(start: 32, end: 32, top: 15),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            _projectsProvider.projects[index].name ?? '',
                                            style: GoogleFonts.cairo(
                                              color: AppColors.textColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        SvgPicture.asset(
                                          SvgImages.location,
                                          color: const Color(0xFF4d4d4d),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          _projectsProvider.projects[index].govern ?? '',
                                          style: GoogleFonts.cairo(
                                            color: const Color(0xff4d4d4d),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 32),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(SvgImages.calendarGreen),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text((_projectsProvider.projects[index].endDate!).toString()),
                                        // Text(
                                        //   intl.DateFormat.yMMMEd(
                                        //           const Locale('ar', 'EG')
                                        //               .languageCode)
                                        //       .format(
                                        //           intl.DateFormat('yyyy-MM-dd')
                                        //               .parse(_projectsProvider
                                        //                   .projects[index]
                                        //                   .startDate!)),
                                        //   style: GoogleFonts.cairo(
                                        //     color: AppColors.primaryColor,
                                        //     fontSize: 16,
                                        //     fontWeight: FontWeight.w600,
                                        //     fontStyle: FontStyle.normal,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 24,
                                      end: 19,
                                      bottom: 14,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: LinearProgressIndicator(
                                              backgroundColor: const Color(0xFFC8C8C8),
                                              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.appOrange),
                                              value: ((_projectsProvider.projects[index].finishPercentageAfterExecution) ?? 0) / 100,
                                              minHeight: 8,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Container(
                                          width: 42,
                                          height: 42,
                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColor),
                                          child: Center(
                                            child: Text(
                                              _projectsProvider.projects[index].finishPercentageAfterExecution != null ? '${_projectsProvider.projects[index].finishPercentageAfterExecution!}%' : '0%',
                                              style: GoogleFonts.cairo(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
