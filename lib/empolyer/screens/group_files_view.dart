import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/helpers/app_constants.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_message.dart';
import 'package:hayaah_karimuh/empolyer/providers/group_files_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/full_screen_image_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/video_player_view.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/main_provider.dart';
import '../utils/app_colors.dart';
import '../utils/images.dart';
import 'notifications_view.dart';

class GroupFilesScreen extends StatefulWidget {
  final String groupName;
  final String groupId;

  const GroupFilesScreen({required this.groupName, required this.groupId, Key? key}) : super(key: key);

  @override
  State<GroupFilesScreen> createState() => _GroupFilesScreenState();
}

class _GroupFilesScreenState extends State<GroupFilesScreen> {
  late MainProvider _mainProvider;

  @override
  void didChangeDependencies() {
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final GroupFilesProvider _groupFilesProvider = Provider.of<GroupFilesProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(226),
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
                          widget.groupName,
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  child: TabBar(
                    indicatorColor: AppColors.primaryColor,
                    unselectedLabelStyle: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                    unselectedLabelColor: AppColors.primaryColor.withOpacity(0.5),
                    labelColor: AppColors.primaryColor,
                    labelStyle: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    ),
                    tabs: const [
                      Tab(text: 'الميديا'),
                      Tab(
                        text: 'الملفات',
                      ),
                      // Tab(
                      //   text: 'اللينكات',
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: _groupFilesProvider.getGroupMessages(groupId: widget.groupId),
            builder: (context, snapshot) {
              List<ChatMessage> mediaMessages = [];
              List<ChatMessage> fileMessages = [];

              if (snapshot.hasData) {
                List<ChatMessage> messages = snapshot.data!.docs.map((e) => ChatMessage.fromJson(e.data() as Map<String, dynamic>)).toList();
                log('Message Count: ${messages.length}');
                mediaMessages = messages.where((element) => element.type == MessageType.image || element.type == MessageType.video).toList();
                fileMessages = messages.where((element) => element.type == MessageType.file).toList();
              }

              return snapshot.hasData
                  ? TabBarView(
                      children: [
                        GridView.builder(
                            itemCount: mediaMessages.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 0,
                            ),
                            itemBuilder: (context, index) {
                              log('MessageType: ${mediaMessages[index].type}');
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => mediaMessages[index].type == MessageType.image
                                        ? FullScreenImageScreen(imageUrl: mediaMessages[index].imageUrl!)
                                        : VideoPlayerScreen(videoUrl: mediaMessages[index].videoUrl!),
                                  ),
                                ),
                                child: Image.network(
                                  mediaMessages[index].type == MessageType.image ? mediaMessages[index].imageUrl! : mediaMessages[index].videoThumbnail!,
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  fit: BoxFit.fitWidth,
                                ),
                              );
                            }),
                        GridView.builder(
                            itemCount: fileMessages.length,
                            scrollDirection: Axis.vertical,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 0,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 0,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  await launch(fileMessages[index].fileUrl!);
                                },
                                child: Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    height: MediaQuery.of(context).size.height / 4,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 4),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          fileMessages[index].fileType!,
                                          style: GoogleFonts.cairo(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        Text(
                                          intl.DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(fileMessages[index].timestamp!)),
                                          style: GoogleFonts.cairo(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        // GridView.builder(
                        //     itemCount: 0,
                        //     scrollDirection: Axis.vertical,
                        //     gridDelegate:
                        //         const SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 4,
                        //       crossAxisSpacing: 0,
                        //       childAspectRatio: 1.0,
                        //       mainAxisSpacing: 0,
                        //     ),
                        //     itemBuilder: (context, index) {
                        //       return Container();
                        //     }),
                      ],
                    )
                  : Container();
            },
          ),
        ),
      ),
    );
  }
}
