import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/providers/inspections_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/inspection_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/echo.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/widgets/preview_bottom_sheet.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../helpers/preferences_manager.dart';
import '../models/uploaded_file.dart';
import '../models/user.dart';
import '../providers/main_provider.dart';
import 'notifications_view.dart';

class InspectionsScreen extends StatefulWidget {
  const InspectionsScreen({Key? key}) : super(key: key);

  @override
  State<InspectionsScreen> createState() => _InspectionsScreenState();
}

class _InspectionsScreenState extends State<InspectionsScreen> {
  late InspectionsProvider _inspectionsProvider;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  late MainProvider _mainProvider;
  bool init = false;

  int page = 1;
  final User currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
  // late Project _project;
  late List<UploadedFile> images = [];
  late List<UploadedFile> documents = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _inspectionsProvider = Provider.of<InspectionsProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    if (!init) {
      if (page == 1 || (_inspectionsProvider.totalPages != null && page <= _inspectionsProvider.totalPages!)) _inspectionsProvider.getInspections(page);
      init = true;
    }
  }

  @override
  void dispose() {
    _inspectionsProvider.inspections.clear();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(pagination);
    super.initState();
  }

  void pagination() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      kEcho('Pagination Callback ${_inspectionsProvider.totalPages}');
      setState(() {
        // isLoading = true;
        page += 1;
      });
      _inspectionsProvider.getInspections(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            previewBottomSheet(context, currentUser);
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(262),
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
                                  size: 32,
                                  color: AppColors.primaryColor,
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
                        'المعاينات',
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
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
            ],
          ),
        ),
        body: ListView.builder(
          primary: false,
          controller: _scrollController,
          itemCount: _inspectionsProvider.inspections.length,
          itemBuilder: (context, index) {
            String previewDate = _inspectionsProvider.inspections[index].previewDate ?? "";
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const InspectionScreen(),
                    settings: RouteSettings(
                      arguments: _inspectionsProvider.inspections[index].toJson(),
                    ),
                  ),
                );
              },
              child: Container(
                // height: 84,
                padding: const EdgeInsetsDirectional.only(top: 14, start: 32, end: 30, bottom: 11),
                margin: EdgeInsets.only(top: index == 0 ? 28 : 9, bottom: index == _inspectionsProvider.inspections.length - 1 ? 28 : 9),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(color: Color(0x29000000), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Text(
                            _inspectionsProvider.inspections[index].project != null ? _inspectionsProvider.inspections[index].project!.name! : "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cairo(
                              color: const Color(0xff4d4d4d),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        // const Spacer(),
                        SvgPicture.asset(SvgImages.location),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          _inspectionsProvider.inspections[index].project!.city != null ? _inspectionsProvider.inspections[index].project!.city!.toString() : "",
                          style: GoogleFonts.cairo(
                            color: const Color(0xff4d4d4d),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(SvgImages.calendarGreen),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          previewDate,
                          style: GoogleFonts.cairo(
                            color: const Color(0xff09ab9c),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
