import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/providers/add_group_members_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/notifications_view.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../helpers/preferences_manager.dart';
import '../models/chat_group.dart';
import '../models/group_member.dart';
import '../models/user.dart';
import '../providers/main_provider.dart';
import '../utils/app_colors.dart';
import '../utils/images.dart';
import 'edit_profile_view.dart';

class AddGroupMembersScreen extends StatefulWidget {
  const AddGroupMembersScreen({Key? key}) : super(key: key);

  @override
  _AddGroupMembersScreenState createState() => _AddGroupMembersScreenState();
}

class _AddGroupMembersScreenState extends State<AddGroupMembersScreen> {
  late MainProvider _mainProvider;
  final bool _loaded = false;
  final List<GroupMember> _selected = [];
  List<User> users = [];
  late AddGroupMembersProvider _addGroupMembersProvider;
  late TextEditingController _searchController;
  final User _currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
  late ChatGroup chatGroup;

  @override
  void didChangeDependencies() {
    final groupData = ModalRoute.of(context)!.settings.arguments! as Map<String, dynamic>;
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    chatGroup = ChatGroup.fromJson(groupData);
    log('Chat Group -> ${jsonEncode(chatGroup)}');
    // chatGroup.members!.map((e) => _selected.add(e));
    _selected.addAll(chatGroup.members!);
    log('Selected -> ${jsonEncode(_selected)}');
    _addGroupMembersProvider = Provider.of<AddGroupMembersProvider>(context);
    _addGroupMembersProvider.load();
    users = _addGroupMembersProvider.users;
    users.removeWhere((element) => element.id == _currentUser.id);
    _searchController = TextEditingController();
    _searchController.addListener(() {
      final query = _searchController.value.text;
      log('Query -> $query');
      if (_searchController.value.text.isNotEmpty) {
        setState(() {
          users = _addGroupMembersProvider.users.where((element) => element.name!.contains(query)).toList();
        });
      } else if (_searchController.value.text.isEmpty) {
        log('Empty');
        setState(() {
          users = _addGroupMembersProvider.users;
        });
      }
    });
    super.didChangeDependencies();
  }

  Future<void> _addGroupMembers() async {
    EasyLoading.show();
    await _addGroupMembersProvider.addGroupMembers(chatGroup.id!, _selected);
    EasyLoading.dismiss();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
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
                        'اضف اعضاء للمجموعة',
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
                itemCount: users.length,
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
                    child: CheckboxListTile(
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
                            users[index].governorate!,
                            style: GoogleFonts.cairo(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                      secondary: users[index].image != null && users[index].image != ''
                          ? CircleAvatar(
                              backgroundImage: AssetImage(users[index].image!),
                            )
                          : const CircleAvatar(
                              backgroundImage: AssetImage(PngImages.user),
                            ),
                      title: Text(
                        '${users[index].name!} (${users[index].jobTitle})',
                        style: GoogleFonts.cairo(
                          color: const Color(0xff484848),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      value: _selected.any((element) => element.id == users[index].id) || _selected.any((element) => element.id == users[index].id),
                      onChanged: (bool? value) {
                        setState(() {
                          if (_selected.any((element) => element.id == users[index].id)) {
                            _selected.removeWhere((element) => element.id == users[index].id);
                          } else {
                            _selected.add(GroupMember(
                                id: users[index].id,
                                isOwner: false,
                                isAdmin: false,
                                lastSeen: DateTime.now().millisecondsSinceEpoch,
                                name: users[index].name!,
                                fcmToken: users[index].fcmToken ?? '',
                                image: users[index].image ?? ''));
                          }
                        });
                        log('Members: ${jsonEncode(_selected)}');
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 36, vertical: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(fixedSize: const Size(double.infinity, 46), padding: EdgeInsets.zero),
                onPressed: () {
                  _addGroupMembers();
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
    );
  }
}
