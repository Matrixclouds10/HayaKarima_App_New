import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/models/beneficiary.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import 'notifications_view.dart';

class BeneficiaryScreen extends StatefulWidget {
  const BeneficiaryScreen({Key? key}) : super(key: key);

  @override
  State<BeneficiaryScreen> createState() => _BeneficiaryScreenState();
}

class _BeneficiaryScreenState extends State<BeneficiaryScreen> {
  late Beneficiary _beneficiary;
  late MainProvider _mainProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final beneficiaryData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _beneficiary = Beneficiary.fromJson(beneficiaryData);
    log('Beneficiary: ${_beneficiary.toJson()}');
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
  }

  @override
  Widget build(BuildContext context) {
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
                        'بيانات المستفيد',
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
        body: SingleChildScrollView(
          primary: true,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(PngImages.user),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          _beneficiary.name!,
                          style: GoogleFonts.cairo(
                            color: const Color(0xff4d4d4d),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          SvgImages.location,
                          color: const Color(0xFF4d4d4d),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          _beneficiary.independent!,
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
                      height: 16,
                    ),
                    Container(
                      height: 41,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.mainBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImages.mobile),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'رقم الموبايل: ${_beneficiary.phone!}',
                            style: GoogleFonts.cairo(
                              color: const Color(0xff4d4d4d),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 41,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.mainBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImages.addressCard),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "رقم البطاقة: ${_beneficiary.idNumber!}",
                            style: GoogleFonts.cairo(
                              color: const Color(0xff4d4d4d),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 41,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.mainBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImages.building),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "المركز التابع: ${_beneficiary.independent!}",
                            style: GoogleFonts.cairo(
                              color: const Color(0xff4d4d4d),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 41,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.mainBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImages.info),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "الحالة الاجتماعية: ${_beneficiary.socialStatus!}",
                            style: GoogleFonts.cairo(
                              color: const Color(0xff4d4d4d),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_beneficiary.note != null)
                      const SizedBox(
                        height: 16,
                      ),
                    if (_beneficiary.note != null)
                      Container(
                        // height: 41,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.mainBackground,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(SvgImages.info),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "ملحوظة: ${_beneficiary.note!}",
                                style: GoogleFonts.cairo(
                                  color: const Color(0xff4d4d4d),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    // const SizedBox(
                    //   height: 16,
                    // ),
                    // Container(
                    //   height: 41,
                    //   padding: EdgeInsets.symmetric(horizontal: 12),
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     color: AppColors.mainBackground,
                    //     borderRadius: BorderRadius.circular(5),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       SvgPicture.asset(SvgImages.userAlt),
                    //       const SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text(
                    //         "عدد المعالين: ${_beneficiary.independentNumber!}",
                    //         style: GoogleFonts.cairo(
                    //           color: Color(0xff4d4d4d),
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w600,
                    //           fontStyle: FontStyle.normal,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
