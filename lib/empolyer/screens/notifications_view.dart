import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/providers/notifications_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/chat_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/profile_view.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:provider/provider.dart';

import '../providers/main_provider.dart';
import '../utils/app_colors.dart';
import '../utils/images.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationsProvider _notificationsProvider;
  late MainProvider _mainProvider;
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  bool init = false;

  int page = 1;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _notificationsProvider = Provider.of<NotificationsProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    if (!init) {
      _notificationsProvider.notifications.clear();
      _notificationsProvider.getUserNotifications();
      init = true;
    }
  }

  @override
  void dispose() {
    _notificationsProvider.notifications.clear();
    super.dispose();
  }

  @override
  void initState() {
    // _scrollController.addListener(pagination);
    super.initState();
  }

  // void pagination() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     log('Pagination Callback');
  //     setState(() {
  //       isLoading = true;
  // page += 1;
  // });
  // _notificationsProvider.getUserNotifications(page);
  // }
  // }

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
                        //   onTap: () {
                        //     Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //         builder: (_) => NotificationsScreen(),
                        //       ),
                        //     );
                        //   },
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
                              // PositionedDirectional(
                              //   top: 0,
                              //   start: 5,
                              //   child: Text(
                              //     _mainProvider.notificationCount.toString(),
                              //     style: GoogleFonts.cairo(
                              //       color: Colors.white,
                              //       fontSize: 10,
                              //       fontWeight: FontWeight.w700,
                              //       fontStyle: FontStyle.normal,
                              //     ),
                              //   ),
                              // ),
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
                        'الاشعارات',
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
              height: 20,
            ),
            Expanded(
              child: _notificationsProvider.notifications.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      // controller: _scrollController,
                      itemCount: _notificationsProvider.notifications.length,
                      primary: false,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const ChatScreen(),
                                settings: RouteSettings(
                                  arguments: {
                                    'group_id': _notificationsProvider.notifications[index].groupId!,
                                    'type': _notificationsProvider.notifications[index].type! == 'group' ? 1 : 0,
                                    'is_notification': false,
                                    'new_chat': false,
                                  },
                                ),
                              ),
                            );
                            await _notificationsProvider.readNotification(_notificationsProvider.notifications[index].id!);
                            await _mainProvider.getNotificationsCount();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: index == 0 ? 0 : 6, left: 15, right: 15, bottom: 6),
                            padding: const EdgeInsetsDirectional.only(top: 16, bottom: 7, start: 10, end: 13),
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
                                const CircleAvatar(
                                  radius: 22,
                                  backgroundImage: AssetImage(
                                    PngImages.logo,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _notificationsProvider.notifications[index].groupName!,
                                        style: GoogleFonts.cairo(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      Text(
                                        _notificationsProvider.notifications[index].senderName!,
                                        style: GoogleFonts.cairo(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        _notificationsProvider.notifications[index].body!,
                                        style: GoogleFonts.cairo(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
