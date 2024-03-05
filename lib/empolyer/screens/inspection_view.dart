import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/screens/full_screen_image_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/inspection.dart';
import '../providers/main_provider.dart';
import 'notifications_view.dart';

class InspectionScreen extends StatefulWidget {
  const InspectionScreen({Key? key}) : super(key: key);

  @override
  State<InspectionScreen> createState() => _InspectionScreenState();
}

class _InspectionScreenState extends State<InspectionScreen> {
  late Inspection _inspection;
  late MainProvider _mainProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final beneficiaryData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _inspection = Inspection.fromJson(beneficiaryData);
    log('Inspection: ${_inspection.toJson()}');
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
  }

  @override
  Widget build(BuildContext context) {
    String previewDate = _inspection.previewDate ?? "";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
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
                  Expanded(
                    child: Container(
                      // height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(5),
                          bottomEnd: Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        _inspection.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
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
        body: SingleChildScrollView(
          primary: true,
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        _inspection.project != null ? _inspection.project!.name! : '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          color: const Color(0xff09ab9c),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(SvgImages.calendarGreen),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      previewDate,
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(PngImages.user),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    const Spacer(),
                    SvgPicture.asset(SvgImages.location),
                    const SizedBox(
                      width: 9,
                    ),
                    Text(
                      _inspection.project!.city != null ? _inspection.project!.city! : '',
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 11,
                ),
                Text(
                  _inspection.note != null ? _inspection.note! : '',
                  style: GoogleFonts.cairo(
                    color: const Color(0xff4d4d4d),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
                _inspection.image == null
                    ? const SizedBox()
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        height: 47,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Icon(Icons.chevron_left_sharp),
                            Expanded(
                              child: ListView.builder(
                                itemCount: _inspection.image == null ? 0 : _inspection.image!.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsetsDirectional.only(start: index == 0 ? 22 : 6, end: index == _inspection.image!.length - 1 ? 22 : 6),
                                    width: 74,
                                    height: 47,
                                    child: GestureDetector(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => FullScreenImageScreen(imageUrl: _inspection.image![index].url!),
                                        ),
                                      ),
                                      child: Image.network(
                                        _inspection.image![index].url!,
                                        height: 47,
                                        width: 74,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Icon(Icons.chevron_right_sharp),
                          ],
                        ),
                      ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  height: 24,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _inspection.documentations!.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          primary: false,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                await launch(_inspection.documentations![index].url!);
                              },
                              child: Container(
                                margin: EdgeInsetsDirectional.only(start: index == 0 ? 22 : 10, end: index == _inspection.documentations!.length - 1 ? 22 : 10),
                                width: 71,
                                height: 24,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      SvgImages.icPdf,
                                      fit: BoxFit.scaleDown,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      _inspection.documentations![index].url!.substring(_inspection.documentations![index].url!.length - 3).toUpperCase(),
                                      style: GoogleFonts.cairo(
                                        color: const Color(0xff4d4d4d),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
