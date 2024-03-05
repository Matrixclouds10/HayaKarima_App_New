import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hayaah_karimuh/empolyer/data/dio_requests_arguments.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/project.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/select_address_screen.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/widgets/custom_text_field.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../models/uploaded_file.dart';
import '../providers/main_provider.dart';
import 'notifications_view.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int currentIndex = 0;
  late MainProvider _mainProvider;
  late Project _project;
  final User currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);

  late List<UploadedFile> images = [];
  late List<UploadedFile> documents = [];
  final TextEditingController _inspectionAddressController = TextEditingController();
  final TextEditingController _inspectionNoteController = TextEditingController();
  final TextEditingController _inspectionDateController = TextEditingController();
  final TextEditingController _inspectionNameController = TextEditingController();

  LatLng? location;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final projectData = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _project = Project.fromJson(projectData);
    _mainProvider = Provider.of<MainProvider>(context);
    _inspectionDateController.text = intl.DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          floatingActionButton: Visibility(
            visible: currentIndex == 1,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    enableDrag: true,
                    isDismissible: true,
                    context: context,
                    builder: (context) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(44), topRight: Radius.circular(44))),
                            width: double.infinity,
                            // height: MediaQuery.of(context).size.height * .8,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "اسم المشروع",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  readOnly: true,
                                  hintText: _project.name!,
                                  height: 41,
                                  textInputType: TextInputType.text,
                                  fillColor: const Color(0xFFECECEC),
                                  maxLine: 1,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "اسم المعاينة",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  height: 41,
                                  controller: _inspectionNameController,
                                  textInputType: TextInputType.text,
                                  fillColor: const Color(0xFFECECEC),
                                  maxLine: 1,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "اسم المعاين",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  height: 41,
                                  readOnly: true,
                                  hintText: currentUser.name!,
                                  textInputType: TextInputType.text,
                                  fillColor: const Color(0xFFECECEC),
                                  maxLine: 1,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "تاريخ المعاينة",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  hintText: intl.DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                  height: 41,
                                  controller: _inspectionDateController,
                                  textInputType: TextInputType.text,
                                  fillColor: const Color(0xFFECECEC),
                                  maxLine: 1,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "اضف مكان المعاينة",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  height: 41,
                                  fillColor: const Color(0xFFECECEC),
                                  // prefixIcon: SvgPicture.asset(
                                  //   SvgImages.image,
                                  //   fit: BoxFit.scaleDown,
                                  // ),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      location = await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => const SelectAddressScreen(),
                                        ),
                                      );
                                      if (location == null) return;
                                      List<Placemark> placemarks = await placemarkFromCoordinates(location!.latitude, location!.longitude);
                                      print(placemarks);
                                      Placemark place = placemarks[0];
                                      log('${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
                                      _inspectionAddressController.text = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                                    },
                                    icon: const Icon(
                                      Icons.location_on_sharp,
                                      size: 24,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  readOnly: true,
                                  controller: _inspectionAddressController,
                                  onTap: () async {
                                    location = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const SelectAddressScreen(),
                                      ),
                                    );
                                    if (location == null) return;
                                    List<Placemark> placemarks = await placemarkFromCoordinates(location!.latitude, location!.longitude);
                                    Placemark place = placemarks[0];
                                    log('${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}');
                                    _inspectionAddressController.text = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                                  },
                                  textInputAction: TextInputAction.done,
                                  // isValidator: true,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "اضف صورة",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  height: 41,
                                  fillColor: const Color(0xFFECECEC),
                                  prefixIcon: SvgPicture.asset(
                                    SvgImages.image,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);

                                      if (result != null) {
                                        setState(() {
                                          images.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      size: 24,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);

                                    if (result != null) {
                                      setState(() {
                                        images.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                                      });
                                    }
                                  },
                                  textInputAction: TextInputAction.done,
                                  // isValidator: true,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "اضف ملفات",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  height: 41,
                                  fillColor: const Color(0xFFECECEC),
                                  prefixIcon: SvgPicture.asset(
                                    SvgImages.attach,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.any);

                                      if (result != null) {
                                        setState(() {
                                          documents.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      size: 24,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.any);

                                    if (result != null) {
                                      setState(() {
                                        documents.addAll(result.paths.map((path) => UploadedFile(localPath: path!)).toList());
                                      });
                                    }
                                  },
                                  textInputAction: TextInputAction.done,
                                  // isValidator: true,
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  "اضف ملاحظات",
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  height: 41,
                                  controller: _inspectionNoteController,
                                  textInputType: TextInputType.text,
                                  fillColor: const Color(0xFFECECEC),
                                  maxLine: 1,
                                ),
                                const SizedBox(
                                  height: 27,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(fixedSize: const Size(double.infinity, 46), padding: EdgeInsets.zero),
                                    onPressed: () async {
                                      await _addInspection();
                                    },
                                    child: Text(
                                      "اضف",
                                      style: GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              backgroundColor: AppColors.primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(262),
            child: Column(
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
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        // height: 42,
                        width: MediaQuery.of(context).size.width * 0.6,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(5),
                            bottomEnd: Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          _project.name!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
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
                ),
                const SizedBox(
                  height: 23,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: const [
                        BoxShadow(color: Color(0x29000000), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0),
                      ],
                    ),
                    height: 60,
                    width: double.infinity,
                    child: TabBar(
                      onTap: (index) {
                        log('Current Index: $index');
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      labelStyle: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      unselectedLabelStyle: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                      unselectedLabelColor: const Color(0xff4d4d4d),
                      labelColor: AppColors.primaryColor,
                      // indicatorWeight: 60,
                      indicatorColor: AppColors.primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      isScrollable: false,
                      tabs: const [
                        Tab(text: "الوصف"),
                        Tab(text: "المعاينة"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              descriptionWidget(),
              inspectionWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget descriptionWidget() {
    return SingleChildScrollView(
      primary: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 23,
          ),
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "وصف المشروع",
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  _project.description ?? '',
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
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "المدة الزمنية",
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "من",
                      style: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      SvgImages.calendarGreen,
                      height: 16,
                      width: 16,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      _project.startDate != null ? _project.startDate! : '',
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "الي",
                      style: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SvgPicture.asset(
                      SvgImages.calendarGreen,
                      height: 16,
                      width: 16,
                      fit: BoxFit.scaleDown,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      _project.endDate != null ? _project.endDate! : '',
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          backgroundColor: const Color(0xFFC8C8C8),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.appOrange),
                          value: _project.finishPercentageAfterExecution! / 100,
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
                          _project.finishPercentageAfterExecution != null ? '${_project.finishPercentageAfterExecution!}%' : '0%',
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
              ],
            ),
          ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(24),
          //   decoration: const BoxDecoration(color: Colors.white),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "مدير العمليات",
          //         style: GoogleFonts.cairo(
          //           color: AppColors.primaryColor,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w700,
          //           fontStyle: FontStyle.normal,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 8,
          //       ),
          //       Row(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           CircleAvatar(
          //             backgroundImage: NetworkImage(_project.manager != null
          //                 ? _project.manager!.image!
          //                 : ''),
          //             backgroundColor: AppColors.primaryColor,
          //             radius: 20,
          //           ),
          //           const SizedBox(
          //             width: 11,
          //           ),
          //           Text(
          //             _project.manager != null ? _project.manager!.name! : '',
          //             style: GoogleFonts.cairo(
          //               color: const Color(0xff4d4d4d),
          //               fontSize: 13,
          //               fontWeight: FontWeight.w600,
          //               fontStyle: FontStyle.normal,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 15,
          // ),
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(24),
          //   decoration: const BoxDecoration(color: Colors.white),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "مشرفين العمليات",
          //         style: GoogleFonts.cairo(
          //           color: AppColors.primaryColor,
          //           fontSize: 16,
          //           fontWeight: FontWeight.w700,
          //           fontStyle: FontStyle.normal,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 8,
          //       ),
          //       Row(
          //         mainAxisSize: MainAxisSize.min,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               CircleAvatar(
          //                 backgroundColor: AppColors.primaryColor,
          //                 backgroundImage: NetworkImage(
          //                     _project.supervisors != null
          //                         ? _project.supervisors!.image!
          //                         : ''),
          //                 radius: 20,
          //               ),
          //               const SizedBox(
          //                 height: 2,
          //               ),
          //               Text(
          //                 _project.supervisors != null
          //                     ? _project.supervisors!.name!
          //                     : '',
          //                 style: GoogleFonts.cairo(
          //                   color: const Color(0xff4d4d4d),
          //                   fontSize: 13,
          //                   fontWeight: FontWeight.w600,
          //                   fontStyle: FontStyle.normal,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           // Column(
          //           //   mainAxisSize: MainAxisSize.min,
          //           //   children: [
          //           //     const CircleAvatar(
          //           //       backgroundColor: AppColors.primaryColor,
          //           //       radius: 20,
          //           //     ),
          //           //     const SizedBox(
          //           //       height: 2,
          //           //     ),
          //           //     Text(
          //           //       "اسم الشخص",
          //           //       style: GoogleFonts.cairo(
          //           //         color: const Color(0xff4d4d4d),
          //           //         fontSize: 13,
          //           //         fontWeight: FontWeight.w600,
          //           //         fontStyle: FontStyle.normal,
          //           //       ),
          //           //     ),
          //           //   ],
          //           // ),
          //           // Column(
          //           //   mainAxisSize: MainAxisSize.min,
          //           //   children: [
          //           //     const CircleAvatar(
          //           //       backgroundColor: AppColors.primaryColor,
          //           //       radius: 20,
          //           //     ),
          //           //     const SizedBox(
          //           //       height: 2,
          //           //     ),
          //           //     Text(
          //           //       "اسم الشخص",
          //           //       style: GoogleFonts.cairo(
          //           //         color: const Color(0xff4d4d4d),
          //           //         fontSize: 13,
          //           //         fontWeight: FontWeight.w600,
          //           //         fontStyle: FontStyle.normal,
          //           //       ),
          //           //     ),
          //           //   ],
          //           // ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget inspectionWidget() {
    return SingleChildScrollView(
      primary: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 23,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "المهام",
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgImages.redDot),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "غير مكتملة",
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 11,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgImages.greenDot),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "مكتملة",
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 11,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ملخص",
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgImages.checkCircleGreen),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "تم استقبال تبرع",
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 11,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgImages.checkCircleGreen),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "تم اكتمال المشروع",
                      style: GoogleFonts.cairo(
                        color: const Color(0xff4d4d4d),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 11,
                      textDirection: TextDirection.ltr,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Future<void> _addInspection() async {
    Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = _inspectionNameController.value.text;
    data['project_id'] = _project.id!;
    data['previewer_id'] = currentUser.id!;
    data['preview_date'] = _inspectionDateController.value.text;
    if (location != null) {
      data['latitude'] = location!.latitude;
      data['longitude'] = location!.longitude;
    }
    data['note'] = _inspectionNoteController;

    if (images.isNotEmpty) {
      for (int i = 0; i < images.length; i++) {
        if (images[i].localPath != null) {
          data['images[$i]'] = await MultipartFile.fromFile(images[i].localPath!, filename: images[i].localPath!.split('/').last);
        }
        print(images);
      }
    }
    if (documents.isNotEmpty) {
      for (int i = 0; i < documents.length; i++) {
        if (documents[i].localPath != null) {
          data['documentations[$i]'] = await MultipartFile.fromFile(documents[i].localPath!, filename: documents[i].localPath!.split('/').last);
        }
      }
    }
    // if (documents.isEmpty && images.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text(
    //         'برجاء اختيار الملفات اولا',
    //         style: GoogleFonts.cairo(
    //           color: Colors.white,
    //           fontSize: 14,
    //           fontWeight: FontWeight.w700,
    //           fontStyle: FontStyle.normal,
    //         ),
    //       ),
    //       backgroundColor: Colors.red,
    //     ),
    //   );
    // }
    if (data.isNotEmpty) {
      try {
        bool status = await networkAddInspection(data);
        Navigator.of(context).pop();
      } catch (e) {
        Fluttertoast.showToast(msg: '$e');
      }
    }
  }

  _showBottomSheet() {}
}
