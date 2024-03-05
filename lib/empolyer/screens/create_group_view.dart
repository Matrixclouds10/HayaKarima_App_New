import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';
import 'package:hayaah_karimuh/empolyer/models/group_member.dart';
import 'package:hayaah_karimuh/empolyer/models/uploaded_file.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/providers/create_group_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/chat_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/widgets/images_picker.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import '../widgets/custom_text_field.dart';
import 'edit_profile_view.dart';
import 'notifications_view.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final bool _loaded = false;
  late int type;
  final List<GroupMember> _selected = [];
  List<User> users = [];
  List<String> govs = [];
  List<String> _selectedGovs = [];
  late CreateGroupProvider _createGroupProvider;
  late TextEditingController _groupNameController;
  late TextEditingController _searchController;
  late MainProvider _mainProvider;
  List<User> usersToShow = [];
  final User _currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);

  String? groupImageUrl;

  String? groupImagePath;

  Future<void> _createGroup(BuildContext context, int type) async {
    if (type == 0) {
      final creator = GroupMember(
        id: _currentUser.id!,
        isAdmin: true,
        isOwner: true,
        fcmToken: PreferencesManager.getString(PreferencesManager.fcmToken),
        image: _currentUser.image ?? '',
        lastSeen: DateTime.now().millisecondsSinceEpoch,
        name: _currentUser.name!,
      );
      final included = _selected.any((element) => element.id == creator.id);
      if (!included) {
        _selected.add(creator);
      }
      ChatGroup chatGroup = ChatGroup(
          groupImage: _selected.where((element) => element.id != creator.id).first.image,
          name: _selected.where((element) => element.id != creator.id).first.name,
          members: _selected,
          unreadCount: 0,
          ids: _selected.map((e) => e.id!).toList(),
          lastTimestamp: 0);
      final newGroupId = await _createGroupProvider.createPrivateChat(chatGroup);
      const page = ChatScreen();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => page,
          settings: RouteSettings(arguments: {
            "group_id": newGroupId,
            "type": type,
            'is_notification': false,
            'new_chat': true,
          })));
    } else {
      if (groupImagePath == null) Fluttertoast.showToast(msg: ' يرجي اضافة صورة ');

      if (_selected.isNotEmpty && _groupNameController.value.text.isNotEmpty) {
        EasyLoading.show();
        final String imagesUrl = await _createGroupProvider.uploadGroupImage(groupImagePath!, _currentUser.id!);
        final creator = GroupMember(
          id: _currentUser.id!,
          isAdmin: true,
          fcmToken: PreferencesManager.getString(PreferencesManager.fcmToken),
          isOwner: true,
          image: _currentUser.image ?? '',
          lastSeen: DateTime.now().millisecondsSinceEpoch,
          name: _currentUser.name!,
        );
        final included = _selected.any((element) => element.id == creator.id);
        if (!included) {
          _selected.add(creator);
        }
        log('Image URL: $imagesUrl');

        ChatGroup chatGroup = ChatGroup(groupImage: imagesUrl, name: _groupNameController.value.text, members: _selected, unreadCount: 0, ids: _selected.map((e) => e.id!).toList(), lastTimestamp: 0);
        final newGroupId = await _createGroupProvider.createGroup(chatGroup);
        EasyLoading.dismiss();
        log('Created Group ID: $newGroupId');
        Navigator.of(context).pop();
        const page = ChatScreen();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => page,
            settings: RouteSettings(arguments: {
              "group_id": newGroupId,
              "type": type,
              'is_notification': false,
              'new_chat': true,
            })));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'برجاء اختيار الاعضاء و اسم المجموعه',
              style: GoogleFonts.cairo(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        );
      }
    }
  }

  Future<void> _showGroupNameDialog() async {
    List<UploadedFile> images = [];
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Dialog(
              child: StatefulBuilder(builder: (context, setState2) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 62,
                        decoration: BoxDecoration(
                          color: const Color(0xff09ab9c),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            "انشاء مجموعة",
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              "اسم المجموعة",
                              style: GoogleFonts.cairo(
                                color: const Color(0xff4d4d4d),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            CustomTextField(
                              height: 41,
                              textInputType: TextInputType.name,
                              fillColor: const Color(0xffececec),
                              controller: _groupNameController,
                              capitalization: TextCapitalization.words,
                              textInputAction: TextInputAction.next,
                              // isValidator: true,
                            ),
                            const SizedBox(
                              height: 20,
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
                            const SizedBox(height: 7),
                            const SizedBox(height: 10),
                            imagesPicker(
                                context: context,
                                images: images,
                                refresh: () {
                                  setState2(() {});
                                }),
                            const SizedBox(height: 7),
                            CustomTextField(
                              height: 41,
                              readOnly: true,
                              onTap: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
                                if (result != null) {
                                  groupImagePath = result.files.single.path!;
                                }
                                images = [UploadedFile(localPath: groupImagePath!)];

                                setState2(() {});
                              },
                              prefixIcon: const Icon(Icons.photo_size_select_actual_outlined),
                              textInputType: TextInputType.name,
                              fillColor: const Color(0xffececec),
                              textInputAction: TextInputAction.done,
                              // isValidator: true,
                            ),
                            const SizedBox(
                              height: 48,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(fixedSize: const Size(double.infinity, 46), padding: EdgeInsets.zero),
                              onPressed: () {
                                if (groupImagePath != null) {
                                  _createGroup(context, type);
                                  print('nulll');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                      "برجاء ادخال الصورة",
                                      style: GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              child: Center(
                                child: Text(
                                  "تم",
                                  style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 44,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }

  @override
  void didChangeDependencies() {
    print("✅  didChangeDependencies");
    type = ModalRoute.of(context)!.settings.arguments as int;
    _createGroupProvider = Provider.of<CreateGroupProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    _createGroupProvider.load();
    users = _createGroupProvider.users;
    users.removeWhere((element) => element.id == _currentUser.id);
    usersToShow = users;
    for (User user in users) {
      if (!govs.contains(user.governorate)) {
        govs.add(user.governorate!);
      }
    }
    _groupNameController = TextEditingController();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      final query = _searchController.value.text;
      log('Query -> $query');
      if (_searchController.value.text.isNotEmpty) {
        setState(() {
          usersToShow = _createGroupProvider.users.where((element) => element.name!.contains(query)).toList();
        });
      } else if (_searchController.value.text.isEmpty) {
        log('Empty');
        setState(() {
          usersToShow = _createGroupProvider.users;
        });
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _searchController.dispose();
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
                            log('Logout');
                            await _mainProvider.logout();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => SplashScreen(),
                                ),
                                (route) => false);
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const EditProfileScreen(),
                              ),
                            );
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
                        type == 0 ? 'الأعضاء' : 'إنشاء مجموعة',
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
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 22,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
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
                  suffixIcon: InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height / 2, maxHeight: MediaQuery.of(context).size.height),
                          context: context,
                          isDismissible: false,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          builder: (context) {
                            // List<String> selectedGovs = [];
                            return BottomSheet(
                                govs: govs,
                                selectedGovs: _selectedGovs,
                                callback: (selectedGovs) {
                                  _selectedGovs = selectedGovs;
                                  log('Selected -> ${jsonEncode(selectedGovs)}');
                                  if (selectedGovs.isNotEmpty) {
                                    setState(() {
                                      // usersToShow.clear();
                                      usersToShow = users.where((element) => selectedGovs.contains(element.governorate)).toList();
                                    });
                                    log('Filtered Users -> ${jsonEncode(usersToShow)}');
                                  } else {
                                    setState(() {
                                      usersToShow.clear();
                                      usersToShow.addAll(users);
                                    });
                                  }
                                });
                          });
                    },
                    child: SvgPicture.asset(
                      SvgImages.icFilterUsers,
                      fit: BoxFit.scaleDown,
                    ),
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: usersToShow.length,
                primary: true,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(color: Color(0x29000000), offset: Offset(0, 1), blurRadius: 6, spreadRadius: 0),
                      ],
                    ),
                    child: type == 0
                        ? ListTile(
                            onTap: () {
                              _selected.add(GroupMember(
                                  id: usersToShow[index].id,
                                  isOwner: false,
                                  isAdmin: false,
                                  fcmToken: usersToShow[index].fcmToken ?? '',
                                  lastSeen: DateTime.now().millisecondsSinceEpoch,
                                  name: usersToShow[index].name!,
                                  image: usersToShow[index].image ?? ''));
                              _createGroup(context, type);
                            },
                            isThreeLine: false,
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.iconLocation,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  usersToShow[index].governorate!,
                                  style: GoogleFonts.cairo(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                            leading: usersToShow[index].image != null && usersToShow[index].image != ''
                                ? CircleAvatar(
                                    backgroundImage: AssetImage(usersToShow[index].image!),
                                  )
                                : const CircleAvatar(
                                    backgroundImage: AssetImage(PngImages.user),
                                  ),
                            title: Text(
                              '${usersToShow[index].name!} (${usersToShow[index].jobTitle})',
                              style: GoogleFonts.cairo(
                                color: const Color(0xff484848),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          )
                        : CheckboxListTile(
                            activeColor: Theme.of(context).primaryColor,
                            isThreeLine: false,
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  SvgImages.iconLocation,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  usersToShow[index].governorate!,
                                  style: GoogleFonts.cairo(
                                    color: AppColors.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                            secondary: usersToShow[index].image != null && usersToShow[index].image != ''
                                ? CircleAvatar(
                                    backgroundImage: AssetImage(usersToShow[index].image!),
                                  )
                                : const CircleAvatar(
                                    backgroundImage: AssetImage(PngImages.user),
                                  ),
                            title: Text(
                              '${usersToShow[index].name!} (${usersToShow[index].jobTitle})',
                              style: GoogleFonts.cairo(
                                color: const Color(0xff484848),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            value: _selected.any((element) => element.id == usersToShow[index].id),
                            onChanged: (bool? value) {
                              setState(() {
                                if (_selected.any((element) => element.id == usersToShow[index].id)) {
                                  _selected.removeWhere((element) => element.id == usersToShow[index].id);
                                } else {
                                  _selected.add(GroupMember(
                                      id: usersToShow[index].id,
                                      isOwner: false,
                                      isAdmin: false,
                                      fcmToken: usersToShow[index].fcmToken ?? '',
                                      lastSeen: DateTime.now().millisecondsSinceEpoch,
                                      name: usersToShow[index].name!,
                                      image: usersToShow[index].image ?? ''));
                                }
                              });
                              log('Members: ${jsonEncode(_selected)}');
                            },
                          ),
                  );
                },
              ),
            ),
            if (type == 1)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(fixedSize: const Size(double.infinity, 46), padding: EdgeInsets.zero),
                  onPressed: () {
                    _showGroupNameDialog();
                  },
                  child: Text(
                    "انشاء",
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
    );
  }
}

class BottomSheet extends StatefulWidget {
  final List<String> govs;
  List<String> selectedGovs = [];
  void Function(List<String> govs) callback;

  BottomSheet({
    Key? key,
    required this.govs,
    required this.callback,
    required this.selectedGovs,
  }) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 45),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .13,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                  ),
                  child: Stack(
                    children: [
                      PositionedDirectional(
                        start: 35,
                        top: 0,
                        bottom: 0,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(SvgImages.whiteClose),
                        ),
                      ),
                      PositionedDirectional(
                        top: 0,
                        bottom: 0,
                        end: 0,
                        start: 0,
                        child: Center(
                          child: Text(
                            "تصفية حسب المحافظة",
                            style: GoogleFonts.cairo(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                ListView.builder(
                  // primary: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: widget.govs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsetsDirectional.only(top: index == 0 ? 0 : 8, bottom: 8, start: 35, end: 35),
                      child: CheckboxListTile(
                        activeColor: Theme.of(context).primaryColor,
                        isThreeLine: false,
                        secondary: SvgPicture.asset(SvgImages.location),
                        title: Text(
                          widget.govs[index],
                          style: GoogleFonts.cairo(
                            color: const Color(0xff4d4d4d),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        value: widget.selectedGovs.contains(widget.govs[index]),
                        onChanged: (bool? value) {
                          if (widget.selectedGovs.contains(widget.govs[index])) {
                            widget.selectedGovs.removeWhere((element) => element == widget.govs[index]);
                          } else {
                            widget.selectedGovs.add(widget.govs[index]);
                          }
                          log('Selected Govs: ${jsonEncode(widget.selectedGovs)}');
                        },
                      ),
                    );
                  },
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(fixedSize: const Size(double.infinity, 46), padding: EdgeInsets.zero),
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.callback(widget.selectedGovs);
                    },
                    child: Text(
                      "تم",
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
      ),
    );
  }
}
