// ignore_for_file: avoid_types_as_parameter_names

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/file_id.dart';
import 'package:hayaah_karimuh/empolyer/models/uploaded_file.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/providers/profile_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/edit_profile_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/widgets/custom_button.dart';
import 'package:hayaah_karimuh/empolyer/widgets/custom_text_field.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import 'notifications_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  File? image;
  late String? profileImage;
  late List<UploadedFile> images = [];
  late List<UploadedFile> documents = [];
  late String _selectedImagePath = '';
  late ProfileProvider _profileProvider;
  late MainProvider _mainProvider;

  late User currentUser;
  int currentIndex = 0;
  late TabController _controller;

  @override
  void didChangeDependencies() {
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
    images = currentUser.images ?? [];
    setState(() {
      profileImage = PreferencesManager.getString('image');
      print('profileImage >>>> ' + profileImage!);
    });
    documents = currentUser.documents ?? [];

    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _controller = TabController(length: 2, vsync: this, initialIndex: 0);
    _controller.addListener(() {
      print(_controller.index);
    });
  }

  void _refresh() {
    log('Refresh Profile Screen');
    setState(() {
      currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
    });
  }

  Future<void> _deleteImage(BuildContext context, int imageId) async {
    final FileId fileId = FileId(id: imageId);
    await _profileProvider.deleteImage(fileId, (bool route, String errorMessage) {
      if (route) {
        setState(() {
          currentUser.images!.removeWhere((element) => element.id == imageId);
          PreferencesManager.save(currentUser);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: GoogleFonts.cairo(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  Future<void> _deleteDocument(BuildContext context, int documentId) async {
    final FileId fileId = FileId(id: documentId);
    await _profileProvider.deleteDocument(fileId, (bool route, String errorMessage) {
      if (route) {
        setState(() {
          currentUser.documents!.removeWhere((element) => element.id == documentId);
          PreferencesManager.save(currentUser);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              style: GoogleFonts.cairo(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log('Current User: ${currentUser.toJson()}');
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
                            log('Logout');
                            await _mainProvider.logout();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => SplashScreen(),
                                ),
                                (route) => false);
                          } else {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (_) => const EditProfileScreen(),
                                  ),
                                )
                                .then((value) => _refresh());
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
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  SvgImages.edit,
                                  width: 14,
                                  height: 16,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "تعديل بياناتي",
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
                              mainAxisAlignment: MainAxisAlignment.start,
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
                        'الصفحة الشخصية',
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
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   icon: const Icon(
                  //     Icons.arrow_back_ios,
                  //     color: Colors.black,
                  //     textDirection: TextDirection.ltr,
                  //   ),
                  // ),
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
                height: 22,
              ),
              Consumer<ProfileProvider>(builder: (BuildContext context, value, Widget? child) {
                return Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .22,
                      width: MediaQuery.of(context).size.width * .22,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: Center(
                            child: _selectedImagePath.isEmpty
                                ? Image.network(profileImage!, height: MediaQuery.of(context).size.width * .22, width: MediaQuery.of(context).size.width * .22, fit: BoxFit.fill,
                                    errorBuilder: (BuildContext, Object, StackTrace) {
                                    return SvgPicture.asset(
                                      SvgImages.dummyUser,
                                      height: MediaQuery.of(context).size.width * .22,
                                      width: MediaQuery.of(context).size.width * .22,
                                      fit: BoxFit.scaleDown,
                                    );
                                  })
                                : Image.file(
                                    File(_selectedImagePath),
                                    fit: BoxFit.fill,
                                    height: MediaQuery.of(context).size.width * .22,
                                    width: MediaQuery.of(context).size.width * .22,
                                  )),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
                          if (result != null) {
                            image = File(result.files.single.path!);
                            Provider.of<ProfileProvider>(context, listen: false).changeImage(image: image!.path).then((value) {
                              if (value['status'] == 'success') {
                                PreferencesManager.saveString('image', value['items']['image']);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      value['message'],
                                      style: GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                );
                                log(PreferencesManager.getString('image').toString());
                                _refresh();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "خظأ في تحميل الملف",
                                      style: GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            });
                          }
                          setState(() {
                            _selectedImagePath = image!.path;
                          });
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              SvgImages.edit,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),

              const SizedBox(
                height: 8,
              ),
              Text(
                currentUser.name!,
                style: GoogleFonts.cairo(
                  color: const Color(0xff4d4d4d),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                currentUser.jobTitle!,
                style: GoogleFonts.cairo(
                  color: AppColors.appOrange,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const SizedBox(
                height: 15,
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
                    controller: _controller,
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
                      Tab(text: "معلومات شخصية"),
                      Tab(text: "مصوغات التعيين"),
                    ],
                  ),
                ),
              ),
              // TabBarView(
              //   controller: _controller,
              //   children: [
              //     personalInfoWidget(),
              //     documentsWidget(),
              //   ],
              // ),
              if (currentIndex == 0) personalInfoWidget(),
              if (currentIndex == 1) documentsWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget personalInfoWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 34,
          ),
          Container(
            height: 41,
            // alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  SvgImages.person,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    currentUser.name!,
                    style: GoogleFonts.cairo(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            height: 41,
            // alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  SvgImages.email,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    currentUser.email!,
                    style: GoogleFonts.cairo(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          Container(
            height: 41,
            // alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  SvgImages.mobile,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    currentUser.phone!,
                    style: GoogleFonts.cairo(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          // CustomTextField(
          //   height: 41,
          //   hintText: 'كلمة المرور',
          //   prefixIcon: SvgPicture.asset(
          //     SvgImages.lock,
          //     fit: BoxFit.scaleDown,
          //   ),
          //   suffixIcon: SvgPicture.asset(
          //     SvgImages.edit,
          //     fit: BoxFit.scaleDown,
          //   ),
          //   readOnly: true,
          //   fillColor: Colors.white,
          //   textInputType: TextInputType.visiblePassword,
          //   textInputAction: TextInputAction.done,
          //   // isValidator: true,
          // ),
        ],
      ),
    );
  }

  Widget documentsWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 34,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 11),
            child: Text(
              "اضف صورة",
              style: GoogleFonts.cairo(
                color: const Color(0xff4d4d4d),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
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
                  print(images);
                });
              }
            },
            fillColor: Colors.white,
            textInputAction: TextInputAction.done,
            // isValidator: true,
          ),
          const SizedBox(
            height: 16,
          ),
          if (images.isNotEmpty)
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 74 / 47),
              itemCount: images.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(6),
                  width: 74,
                  height: 47,
                  child: images[index].localPath != null
                      ? Stack(
                          children: [
                            Image.file(
                              File(images[index].localPath!),
                              height: 47,
                              width: 74,
                            ),
                            PositionedDirectional(
                              top: 5,
                              end: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    images.removeAt(index);
                                  });
                                },
                                child: Container(
                                  width: 18,
                                  height: 19,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  child: const Icon(
                                    Icons.close,
                                    size: 10,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            Image.network(
                              images[index].url!,
                              height: 47,
                              width: 74,
                            ),
                            PositionedDirectional(
                              top: 5,
                              end: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  await _deleteImage(context, images[index].id!);
                                },
                                child: Container(
                                  width: 18,
                                  height: 19,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  child: const Icon(
                                    Icons.close,
                                    size: 10,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                );
              },
            ),
          const SizedBox(
            height: 24,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 11),
            child: Text(
              "اضف ملفات",
              style: GoogleFonts.cairo(
                color: const Color(0xff4d4d4d),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextField(
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
            fillColor: Colors.white,
            textInputAction: TextInputAction.done,
            // isValidator: true,
          ),
          const SizedBox(
            height: 16,
          ),
          if (documents.isNotEmpty)
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 74 / 47),
              itemCount: documents.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(6),
                  width: 74,
                  height: 47,
                  child: documents[index].localPath != null
                      ? Stack(
                          children: [
                            SizedBox(
                              height: 47,
                              width: 74,
                              child: Center(
                                child: Text(
                                  documents[index].localPath!.substring(documents[index].localPath!.length - 3).toUpperCase(),
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: 5,
                              end: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    documents.removeAt(index);
                                  });
                                },
                                child: Container(
                                  width: 18,
                                  height: 19,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  child: const Icon(
                                    Icons.close,
                                    size: 10,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Stack(
                          children: [
                            Container(
                              color: Colors.white,
                              height: 47,
                              width: 74,
                              child: Center(
                                child: Text(
                                  documents[index].url!.substring(documents[index].url!.length - 3).toUpperCase(),
                                  style: GoogleFonts.cairo(
                                    color: const Color(0xff4d4d4d),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                            PositionedDirectional(
                              top: 5,
                              end: 5,
                              child: GestureDetector(
                                onTap: () async {
                                  await _deleteDocument(context, documents[index].id!);
                                },
                                child: Container(
                                  width: 18,
                                  height: 19,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                  child: const Icon(
                                    Icons.close,
                                    size: 10,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                );
              },
            ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            onPressed: () async {
              log('onTap');

              Map<String, dynamic> data = <String, dynamic>{};
              // data['method'] = 'put';
              if (images.isNotEmpty) {
                for (int i = 0; i < images.length; i++) {
                  if (images[i].localPath != null) {
                    data['images[]'] = await MultipartFile.fromFile(images[i].localPath!, filename: images[i].localPath!.split('/').last);
                  }
                }
              }
              if (documents.isNotEmpty) {
                for (int i = 0; i < documents.length; i++) {
                  if (documents[i].localPath != null) {
                    data['documentations[]'] = await MultipartFile.fromFile(documents[i].localPath!, filename: documents[i].localPath!.split('/').last);
                  }
                }
              }
              if (documents.isEmpty && images.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'برجاء اختيار الملفات اولا',
                      style: GoogleFonts.cairo(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (data.isNotEmpty) {
                print("ddddata>>" + data.toString());
                _profileProvider.uploadDocuments(data, (bool route, String error) {
                  if (route) {
                    setState(() {
                      // currentUser.documents!.addAll(documents);
                      // currentUser.images!.addAll(images);
                      PreferencesManager.save(currentUser);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                            route ? 'تمت الاضافة بنجاح' : error,
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          backgroundColor: AppColors.primaryColor),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          error,
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                });
              }
            },
            margin: const EdgeInsets.symmetric(horizontal: 30),
            buttonText: 'حفظ',
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
