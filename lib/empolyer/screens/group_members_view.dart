import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/providers/group_members_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/add_group_member_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../helpers/preferences_manager.dart';
import '../providers/main_provider.dart';
import 'edit_profile_view.dart';
import 'messages_view.dart';
import 'notifications_view.dart';

class GroupMembersScreen extends StatefulWidget {
  const GroupMembersScreen({Key? key}) : super(key: key);

  @override
  State<GroupMembersScreen> createState() => _GroupMembersScreenState();
}

class _GroupMembersScreenState extends State<GroupMembersScreen> {
  // late ChatGroup chatGroup;
  late String groupId;
  final User _currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
  late GroupMembersProvider _groupMembersProvider;
  late MainProvider _mainProvider;

  late ChatGroup _currentGroup;

  Future<void> _deleteGroup() async {
    await _groupMembersProvider.deleteGroup(groupId);
    Navigator.popUntil(context, ModalRoute.withName(MessagesScreen.routeName));
  }

  @override
  void didChangeDependencies() {
    groupId = ModalRoute.of(context)!.settings.arguments as String;
    // chatGroup = ChatGroup.fromJson(groupData);
    _groupMembersProvider = Provider.of<GroupMembersProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    super.didChangeDependencies();
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              'حذف المجموعة؟',
              style: GoogleFonts.cairo(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            content: Text(
              'هل تريد حذف المجموعة؟',
              style: GoogleFonts.cairo(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'موافق',
                  style: GoogleFonts.cairo(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () async {
                  await _groupMembersProvider.deleteGroup(groupId);
                  Navigator.popUntil(context, ModalRoute.withName(MessagesScreen.routeName));
                },
              ),
              TextButton(
                child: Text(
                  'الغاء',
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getMemberButton(ChatGroup chatGroup, int index) {
    final myRole = chatGroup.members!.where((element) => element.id == _currentUser.id).first;
    if (myRole.isOwner) {
      if (chatGroup.members![index].id == _currentUser.id) {
        return SvgPicture.asset(SvgImages.iconLeaveGroup);
      } else {
        return const Icon(
          Icons.delete,
          color: Colors.red,
        );
      }
    } else if (!myRole.isOwner && myRole.isAdmin) {
      if (chatGroup.members![index].id == _currentUser.id) {
        return SvgPicture.asset(SvgImages.iconLeaveGroup);
      } else {
        if (!chatGroup.members![index].isOwner && !chatGroup.members![index].isAdmin) {
          return const Icon(
            Icons.delete,
            color: Colors.red,
          );
        } else {
          return Container();
        }
      }
    } else if (!myRole.isOwner && !myRole.isAdmin) {
      if (chatGroup.members![index].id == _currentUser.id) {
        return SvgPicture.asset(SvgImages.iconLeaveGroup);
      } else {
        return Container();
      }
    } else {
      return Container();
    }
  }

  Future<void> _showSetAdminDialog(int userId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              'اضف ادمن',
              style: GoogleFonts.cairo(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            content: Text(
              'هل تريد اضافة هذا العضو كأدمن؟',
              style: GoogleFonts.cairo(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'موافق',
                  style: GoogleFonts.cairo(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () async {
                  await _groupMembersProvider.setMemberAdmin(groupId, userId);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'الغاء',
                  style: GoogleFonts.cairo(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_currentGroup.members!.where((element) => element.id == _currentUser.id).first.isOwner || _currentGroup.members!.where((element) => element.id == _currentUser.id).first.isAdmin) {
              const page = AddGroupMembersScreen();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => page, settings: RouteSettings(arguments: _currentGroup.toJson())),
              );
            }
          },
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 10,
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
                        'اعضاء المجموعة',
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
              height: 23,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: _groupMembersProvider.getGroupMembers(groupId),
              builder: (ctx, snapshot) {
                if (snapshot.hasData && snapshot.data!.exists) {
                  _currentGroup = ChatGroup.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                  final myRole = _currentGroup.members!.where((element) => element.id == _currentUser.id).first;
                  _groupMembersProvider.setCanAddMembers(myRole.isOwner || myRole.isAdmin);
                  return Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _currentGroup.members!.length,
                        primary: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () async {
                              log('Long Press');
                              await HapticFeedback.vibrate();
                              await _showSetAdminDialog(_currentGroup.members![index].id!);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 8,
                                left: 14,
                                right: 14,
                                bottom: (index == _currentGroup.members!.length - 1) ? 74 : 8,
                              ),
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(color: Color(0x29000000), offset: Offset(0, 1), blurRadius: 6, spreadRadius: 0),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  _currentGroup.members![index].image != null && _currentGroup.members![index].image != ''
                                      ? CircleAvatar(
                                          radius: 22,
                                          backgroundImage: NetworkImage(_currentGroup.members![index].image!),
                                        )
                                      : const CircleAvatar(
                                          radius: 22,
                                          backgroundImage: AssetImage(PngImages.user),
                                        ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    _currentGroup.members![index].name!,
                                    style: GoogleFonts.cairo(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (_currentGroup.members![index].isOwner)
                                    Text(
                                      '(Owner)',
                                      style: GoogleFonts.cairo(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  if (!_currentGroup.members![index].isOwner && _currentGroup.members![index].isAdmin)
                                    Text(
                                      '(Admin)',
                                      style: GoogleFonts.cairo(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final myRole = _currentGroup.members!.where((element) => element.id == _currentUser.id).first;
                                      if (myRole.isOwner) {
                                        if (_currentGroup.members![index].id == _currentUser.id) {
                                          _showConfirmationDialog(context);
                                        } else {
                                          await _groupMembersProvider.leaveGroup(_currentGroup.id!, _currentGroup.members![index].id!);
                                        }
                                      } else if (!myRole.isOwner && myRole.isAdmin) {
                                        if (_currentGroup.members![index].id == _currentUser.id) {
                                          await _groupMembersProvider.leaveGroup(_currentGroup.id!, _currentGroup.members![index].id!);
                                          Navigator.popUntil(context, ModalRoute.withName(MessagesScreen.routeName));
                                        } else {
                                          if (!_currentGroup.members![index].isOwner && !_currentGroup.members![index].isAdmin) {
                                            await _groupMembersProvider.leaveGroup(_currentGroup.id!, _currentGroup.members![index].id!);
                                          }
                                        }
                                      } else if (!myRole.isOwner && !myRole.isAdmin) {
                                        if (_currentGroup.members![index].id == _currentUser.id) {
                                          await _groupMembersProvider.leaveGroup(_currentGroup.id!, _currentGroup.members![index].id!);
                                          Navigator.popUntil(context, ModalRoute.withName(MessagesScreen.routeName));
                                        }
                                      }
                                    },
                                    child: _getMemberButton(_currentGroup, index),
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
