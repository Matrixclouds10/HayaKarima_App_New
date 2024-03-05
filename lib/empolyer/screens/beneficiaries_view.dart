import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/providers/beneficiaries_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/beneficiary_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../enums/filter_enum.dart';
import '../providers/main_provider.dart';
import 'filter_dialog.dart';
import 'notifications_view.dart';

class BeneficiariesScreen extends StatefulWidget {
  const BeneficiariesScreen({Key? key}) : super(key: key);

  @override
  State<BeneficiariesScreen> createState() => _BeneficiariesScreenState();
}

class _BeneficiariesScreenState extends State<BeneficiariesScreen> {
  late BeneficiariesProvider _beneficiariesProvider;
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  late MainProvider _mainProvider;
  bool init = false;
  final TextEditingController _searchController = TextEditingController();
  String benifetsName = 'نوع التبرع';

  int page = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _beneficiariesProvider = Provider.of<BeneficiariesProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    if (!init) {
      _beneficiariesProvider.getBeneficiaries(page);
      init = true;
    }
  }

  @override
  void initState() {
    _scrollController.addListener(pagination);
    _searchController.addListener(() {
      _beneficiariesProvider.setSearchQuery(
        _searchController.value.text,
      );
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
      _beneficiariesProvider.getBeneficiaries(page);
    }
  }

  @override
  void dispose() {
    _beneficiariesProvider.beneficiaries.clear();
    super.dispose();
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
                        'المستفيدين',
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
                                // await _beneficiariesProvider.getCountries(
                                //     page: page);
                                log('Filter Clicked!');
                                log('Show Filter -> ${_beneficiariesProvider.showFilter}');

                                if (!_beneficiariesProvider.showFilter) {
                                  _beneficiariesProvider.setShowFilter(true);
                                } else {
                                  _beneficiariesProvider.setShowFilter(false);
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
                        log('Query -> ${_beneficiariesProvider.query}');
                        setState(() {
                          page = 1;
                        });
                        _beneficiariesProvider.searchBenefets(page: page, queries: {
                          'beneficiary_type_id': _beneficiariesProvider.benifitesTypes != null ? _beneficiariesProvider.benifitesTypes!.id : '',
                          'search': _beneficiariesProvider.query ?? '',
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
                visible: _beneficiariesProvider.showFilter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showFilterDialog(context, type: Filter.benifetsType, queries: {
                          'beneficiary_type_id': _beneficiariesProvider.benifitesTypes != null ? _beneficiariesProvider.benifitesTypes!.id : '',
                          'search': _beneficiariesProvider.query ?? '',
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
                              // ignore: unnecessary_null_comparison
                              _beneficiariesProvider.benifitesTypes != null ? _beneficiariesProvider.benifitesTypes!.name! : benifetsName,
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
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: _beneficiariesProvider.beneficiaries.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const BeneficiaryScreen(),
                          settings: RouteSettings(
                            arguments: _beneficiariesProvider.beneficiaries[index].toJson(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 14),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      // height: 104,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(PngImages.user),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 85,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      _beneficiariesProvider.beneficiaries[index].name!,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: 2,
                                      style: GoogleFonts.cairo(
                                        color: const Color(0xff4d4d4d),
                                        fontSize: 13,
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
                                      width: 5,
                                    ),
                                    Text(
                                      _beneficiariesProvider.beneficiaries[index].independent!,
                                      style: GoogleFonts.cairo(
                                        color: const Color(0xff4d4d4d),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Text(
                                    //   "مشروع قرى الصعيد",
                                    //   style: GoogleFonts.cairo(
                                    //     color: const Color(0xff09ab9c),
                                    //     fontSize: 15,
                                    //     fontWeight: FontWeight.w600,
                                    //     fontStyle: FontStyle.normal,
                                    //   ),
                                    // ),
                                    const Spacer(),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "تفاصيل",
                                          style: GoogleFonts.cairo(
                                            color: AppColors.appOrange,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        SvgPicture.asset(SvgImages.orangeArrow),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
}
