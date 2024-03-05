import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/providers/one_to_one_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/chat_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/create_group_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/utils/utils.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import 'notifications_view.dart';

class OneToOneScreen extends StatefulWidget {
  const OneToOneScreen({Key? key}) : super(key: key);
  static const String routeName = 'one_to_one_screen';

  @override
  State<OneToOneScreen> createState() => _OneToOneScreenState();
}

class _OneToOneScreenState extends State<OneToOneScreen> {
  final User currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
  int refreshCount = 0;
  List<ChatGroup> _groups = [];
  late OneToOneProvider _messagesProvider;
  late TextEditingController _searchController;
  late MainProvider _mainProvider;
  bool alreadyInitData = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    _messagesProvider = Provider.of<OneToOneProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    if (alreadyInitData) return;
    refreshCount = math.Random().nextInt(500);
    _groups = _messagesProvider.groups;
    _mainProvider.getNotificationsCount();
    await _messagesProvider.load(memberId: currentUser.id!, refresh: false);
    _groups = _messagesProvider.groups;
    _searchController = TextEditingController();
    _searchController.addListener(() {
      final query = _searchController.value.text;
      if (_searchController.value.text.isNotEmpty) {
        setState(() {
          _groups = _messagesProvider.groups.where((element) => element.name!.contains(query)).toList();
        });
      } else if (_searchController.value.text.isEmpty) {
        log('Empty');
        setState(() {
          _groups = _messagesProvider.groups;
        });
      }
    });
    alreadyInitData = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                const page = CreateGroupScreen();
                dynamic xxx = await Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                        builder: (_) => page,
                        settings: const RouteSettings(arguments: 0),
                      ),
                    )
                    .then((value) {});

                await _messagesProvider.load(memberId: currentUser.id!, refresh: true);
                setState(() {});
              },
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 10,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                      margin: const EdgeInsetsDirectional.only(top: 42, start: 5, end: 24, bottom: 20),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          SizedBox(
                            width: 66,
                            height: 74,
                            child: Image.asset(
                              PngImages.logo,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
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
                        width: 122,
                        height: 42,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(5),
                            bottomEnd: Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "الرسائل",
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
                        onPressed: () => Navigator.of(context).pop(),
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
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      key: Key('_groups$refreshCount'),
                      shrinkWrap: true,
                      itemCount: _groups.length,
                      primary: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () async {
                            String? status = await showDialog<String>(
                                context: context,
                                barrierDismissible: true,
                                builder: (ctx) {
                                  return Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: SimpleDialog(
                                      title: Text(
                                        'الخيارات',
                                        style: GoogleFonts.cairo(
                                          color: AppColors.primaryColor,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      children: [
                                        SimpleDialogOption(
                                          child: Text(
                                            'مسح',
                                            style: GoogleFonts.cairo(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          onPressed: () => Navigator.of(context).pop('true'),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                            if (status != null && status == 'true') {
                              print("✅  remove group");
                              FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
                              List<int> ids = [];
                              for (var element in _groups[index].ids!) {
                                if (element != currentUser.id) {
                                  ids.add(element);
                                }
                              }
                              print("✅  _groups[index].id: ${_groups[index].id}");
                              await _firebaseFirestore.collection('private_chat').doc(_groups[index].id).update({
                                'ids': ids,
                              }).onError((error, stackTrace) {
                                print("✅  error3: $error");
                              });
                              print("✅  111");
                              await _messagesProvider.load(memberId: currentUser.id!, refresh: true);
                              _groups.removeAt(index);
                              setState(() {});
                            }
                          },
                          onTap: () async {
                            const page = ChatScreen();
                            dynamic xx = await Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                      builder: (_) => page,
                                      settings: RouteSettings(arguments: {
                                        "group_id": _groups[index].id!,
                                        "type": 0,
                                        'is_notification': false,
                                        'new_chat': false,
                                      })),
                                )
                                .then((value) {});
                            print('------> refresh');
                            alreadyInitData = false;
                            // await init();
                            await _messagesProvider.load(memberId: currentUser.id!, refresh: true);
                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                            height: 73,
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
                                _groups[index].groupImage != null
                                    ? CircleAvatar(
                                        radius: 22,
                                        backgroundImage: NetworkImage(_groups[index].groupImage!),
                                      )
                                    : const CircleAvatar(
                                        radius: 22,
                                        backgroundImage: AssetImage(PngImages.user),
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            _groups[index].members!.where((element) => element.id != currentUser.id).first.name ?? '',
                                            style: GoogleFonts.cairo(
                                              color: Theme.of(context).primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                                            child: Center(
                                              child: Text(
                                                _groups[index].unreadCount!.toString(),
                                                style: GoogleFonts.cairo(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 6,
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
                                            _groups[index].lastMessage != null ? _groups[index].lastMessage!.message! : '',
                                            style: GoogleFonts.cairo(
                                              color: const Color(0xff484848),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            _groups[index].lastMessage != null
                                                ? intl.DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(_groups[index].lastMessage!.timestamp!)).padRight(10) +
                                                    " " +
                                                    Utils().getFormattedDate(_groups[index].lastMessage!.timestamp!)
                                                : '',
                                            style: GoogleFonts.cairo(
                                              color: const Color(0xff484848),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
