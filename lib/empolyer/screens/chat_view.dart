import 'dart:async';
import 'dart:developer';
import 'dart:isolate';
import 'dart:math' as math;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/helpers/app_constants.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_message.dart';
import 'package:hayaah_karimuh/empolyer/models/group_member.dart';
import 'package:hayaah_karimuh/empolyer/models/notification.dart' as fcm;
import 'package:hayaah_karimuh/empolyer/models/notification_data.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/firebase_notification_request.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/save_notification_request.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:hayaah_karimuh/empolyer/providers/chat_provider.dart';
import 'package:hayaah_karimuh/empolyer/screens/one_to_one_view.dart';
import 'package:hayaah_karimuh/empolyer/screens/video_player_view.dart';
import 'package:hayaah_karimuh/empolyer/utils/app_colors.dart';
import 'package:hayaah_karimuh/empolyer/utils/echo.dart';
import 'package:hayaah_karimuh/empolyer/utils/images.dart';
import 'package:hayaah_karimuh/empolyer/widgets/voice_message_widget.dart';
import 'package:hayaah_karimuh/presentation/splashScreen.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart' ;
import 'package:url_launcher/url_launcher.dart';

import '../providers/main_provider.dart';
import 'attach_preview_view.dart';
import 'group_files_view.dart';
import 'group_members_view.dart';
import 'messages_view.dart';
import 'notifications_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? groupId;
  late User currentUser;
  ChatGroup? chatGroup;
  List<GroupMember>? members;
  int _messageType = MessageType.text;
  String? thumbnailPath;
  late ChatProvider chatProvider;
  final Record _audioRecorder = Record();
  late Timer _timer;
  late int type;
  bool isNotification = false;
  final ReceivePort _port = ReceivePort();
  late TargetPlatform platform = Theme.of(context).platform;
  late MainProvider _mainProvider;

  String? taskId;
  bool newChat = false;

  Future<bool> _checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (platform == TargetPlatform.android && androidInfo.version.sdkInt! <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  bool alreadyCallThis = false;
  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    _textEditingController.dispose();
    super.dispose();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    print('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  final FocusNode _focusNode = FocusNode();

  void play(String url) async {
    // await _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(url)));
    // await _audioPlayer.play(url);
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) async {
        chatProvider.setRecordingTime(timer.tick);
        // log('Second: ${chatProvider.recordingTime.inHours.remainder(60).toString()}:${chatProvider.recordingTime.inMinutes.remainder(60).toString()}:${chatProvider.recordingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}');
      },
    );
  }

  void _showRecordingView() async {
    startTimer();
    chatProvider.setRecoding(true);
    bool result = await _audioRecorder.hasPermission();
    if (result) {
      final dir = await getApplicationSupportDirectory();
      String? savePath = '${dir.path}/${currentUser.id}_${DateTime.now().millisecondsSinceEpoch}.aac';
      chatProvider.voicePath = savePath;
      await _audioRecorder.start(path: savePath, encoder: AudioEncoder.AAC);

      showModalBottomSheet(
          enableDrag: false,
          isDismissible: false,
          context: context,
          builder: (context) {
            final provider = Provider.of<ChatProvider>(context);
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 20, top: 10),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${provider.recordingTime.inHours.remainder(60).toString()}:${provider.recordingTime.inMinutes.remainder(60).toString()}:${provider.recordingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                      style: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Navigator.of(context).pop();
                            kEcho("stop recording 0");
                            await _audioRecorder.stop();
                            kEcho("stop recording 1");
                            _timer.cancel();
                            kEcho("stop recording 2");
                            provider.setRecordingTime(0);
                            kEcho("stop recording 3");
                            if (groupId != null && currentUser.id != null && provider.voicePath != null) {
                              await provider.uploadAudioFile(groupId!, currentUser.id!, provider.voicePath!);
                            }
                            kEcho("stop recording 4");
                            provider.voicePath = null;
                            kEcho("stop recording 5");
                            provider.setRecoding(false);
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: SvgPicture.asset(
                                  SvgImages.send,
                                  fit: BoxFit.scaleDown,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: const Icon(
                            Icons.fiber_manual_record_sharp,
                            size: 30,
                            color: Colors.red,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            provider.setRecordingTime(0);
                            provider.setRecoding(false);
                            _timer.cancel();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }

  void _showAttachmentBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              textDirection: TextDirection.rtl,
              children: [
                ListTile(
                    leading: const Icon(
                      Icons.image,
                      color: AppColors.appOrange,
                    ),
                    title: Text(
                      'صورة',
                      style: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    onTap: () => _showFilePicker(FileType.image)),
                ListTile(
                    leading: const Icon(
                      Icons.videocam,
                      color: AppColors.appOrange,
                    ),
                    title: Text('فيديو',
                        style: GoogleFonts.cairo(
                          color: AppColors.primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        )),
                    onTap: () => _showFilePicker(FileType.video)),
                ListTile(
                  leading: const Icon(
                    Icons.insert_drive_file,
                    color: AppColors.appOrange,
                  ),
                  title: Text('ملف',
                      style: GoogleFonts.cairo(
                        color: AppColors.primaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      )),
                  onTap: () => _showFilePicker(FileType.any),
                ),
              ],
            ),
          );
        });
  }

  void _showFilePicker(FileType fileType) async {
    switch (fileType) {
      case FileType.any:
        _messageType = MessageType.file;
        break;
      case FileType.media:
        _messageType = MessageType.file;
        break;
      case FileType.image:
        _messageType = MessageType.image;
        break;
      case FileType.video:
        _messageType = MessageType.video;
        break;
      case FileType.audio:
        _messageType = MessageType.file;
        break;
      case FileType.custom:
        _messageType = MessageType.file;
        break;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(type: fileType);
    if (result != null) {
      log('File Path: ${result.files.single.path!}');
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => AttachPreviewScreen(fileType: _messageType, filePath: result.files.single.path!, groupId: groupId!), fullscreenDialog: true));
    }
  }

  void _scrollDown() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void _sendMessage() async {
    if (_textEditingController.value.text.isEmpty) return;

    String receivers = '';
    if (chatGroup != null && chatGroup!.members != null) {
      for (var element in chatGroup!.members!) {
        if (element.id != currentUser.id) {
          receivers += element.id.toString() + ',';
        }
      }
    }
    if (receivers.isNotEmpty) {
      receivers = receivers.substring(0, receivers.length - 1);
    }
    print('------> receivers $receivers');
    ChatMessage chatMessage = ChatMessage(
      senderId: currentUser.id,
      message: _textEditingController.value.text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      userName: currentUser.name,
      userImage: currentUser.image ?? '',
      type: MessageType.text,
      // receivers: receivers,
    );

    await chatProvider.addMessage(groupId!, chatMessage, type);

    _textEditingController.text = '';
    _scrollDown();
    fcm.Notification notification = fcm.Notification(body: chatMessage.message, title: chatGroup!.name!);
    NotificationData notificationData = NotificationData(
      body: chatMessage.message,
      title: chatGroup!.name!,
      type: type == 0 ? 'private' : 'group',
      groupId: groupId!,
      groupName: chatGroup!.name!,
      senderName: chatMessage.userName,
    );
    List<GroupMember> groupMembers = chatGroup!.members!;
    groupMembers.removeWhere((element) => element.id == currentUser.id);
    List<String> tokensList = groupMembers.map((e) => e.fcmToken ?? '').toList();
    tokensList.removeWhere((element) => element == '');
    FirebaseNotificationRequest request = FirebaseNotificationRequest(data: notificationData, notification: notification, to: (tokensList.toString()).substring(1, (tokensList.toString().length - 1)));
    chatProvider.notifyGroupMembers(request);
    SaveNotificationRequest saveNotificationRequest = SaveNotificationRequest(senderName: chatMessage.userName, groupName: chatGroup!.name, groupId: chatGroup!.id, type: type == 0 ? 'private' : 'group', body: chatMessage.message, title: chatGroup!.name, userId: groupMembers.map((e) => e.id!).toList());
    chatProvider.saveNotification(saveNotificationRequest);
  }

  Future<void> init() async {
    if (alreadyCallThis) return;
    alreadyCallThis = true;
    final data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    groupId = data['group_id'];
    type = data['type'];
    isNotification = data['is_notification'];
    newChat = data['new_chat'];

    chatProvider = Provider.of<ChatProvider>(context);
    _mainProvider = Provider.of<MainProvider>(context);
    _mainProvider.getNotificationsCount();

    currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
    log('Current User Name: ${currentUser.name}');
  }

  void _loadGroup(String groupId, int type) async {
    chatGroup = await chatProvider.getGroup(groupId, type);
    members = chatGroup!.members!;
    setState(() {});
  }

  Widget _getMessageWidget(BuildContext context, ChatMessage chatMessage, bool isLAstMesssage) {
    if (chatMessage.type == MessageType.image) {
      return GestureDetector(
        onLongPress: () async {
          if (chatMessage.senderId == currentUser.id) {
            await HapticFeedback.vibrate();
            String? messageId = await showDialog<String>(
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
                          onPressed: () => Navigator.of(context).pop(chatMessage.id!),
                        ),
                      ],
                    ),
                  );
                });
            await chatProvider.deleteChatMessage(messageId!, groupId!, isLAstMesssage, type);
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Stack(
            children: [
              Image.network(
                chatMessage.imageUrl!,
                // width: MediaQuery.of(context).size.width / 4,
                fit: BoxFit.fitWidth,
              ),
              PositionedDirectional(
                  bottom: 5,
                  end: 5,
                  child: Text(
                    intl.DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)) + " " + intl.DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)),
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.end,
                  )),
            ],
          ),
        ),
      );
    } else if (chatMessage.type == MessageType.video) {
      return GestureDetector(
        onLongPress: () async {
          if (chatMessage.senderId == currentUser.id) {
            await HapticFeedback.vibrate();
            String? messageId = await showDialog<String>(
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
                          onPressed: () => Navigator.of(context).pop(chatMessage.id!),
                        ),
                      ],
                    ),
                  );
                });
            await chatProvider.deleteChatMessage(messageId!, groupId!, isLAstMesssage, type);
          }
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 4,
          child: Stack(children: [
            PositionedDirectional(
              top: 0,
              bottom: 0,
              start: 0,
              end: 0,
              child: Image.network(
                chatMessage.videoThumbnail!,
                width: MediaQuery.of(context).size.width / 4,
                fit: BoxFit.fitWidth,
              ),
            ),
            PositionedDirectional(
              top: 0,
              bottom: 0,
              start: 0,
              end: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoPlayerScreen(videoUrl: chatMessage.videoUrl!)));
                  },
                  child: const Icon(
                    Icons.play_circle_fill_sharp,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
            PositionedDirectional(
                bottom: 5,
                end: 5,
                child: Text(
                  intl.DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)) + " " + intl.DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)),
                  style: GoogleFonts.cairo(
                    color: const Color(0xff484848),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.end,
                )),
          ]),
        ),
      );
    } else if (chatMessage.type == MessageType.file) {
      return GestureDetector(
        onLongPress: () async {
          if (chatMessage.senderId == currentUser.id) {
            await HapticFeedback.vibrate();
            String? messageId = await showDialog<String>(
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
                          onPressed: () => Navigator.of(context).pop(chatMessage.id!),
                        ),
                      ],
                    ),
                  );
                });
            await chatProvider.deleteChatMessage(messageId!, groupId!, isLAstMesssage, type);
          }
        },
        onTap: () async {
          await launch(chatMessage.fileUrl!);
        },
        child: Center(
          child: Container(
            height: 140,
            width: MediaQuery.of(context).size.width * 0.7,
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
                  chatMessage.fileType!,
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  chatMessage.fileName!,
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                Text(
                  '${chatMessage.fileSize} MB',
                  style: GoogleFonts.cairo(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                  textDirection: TextDirection.ltr,
                ),
                Text(
                  intl.DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)) + " " + intl.DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)),
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
    } else if (chatMessage.type == MessageType.audio) {
      return GestureDetector(
          onLongPress: () async {
            if (chatMessage.senderId == currentUser.id) {
              await HapticFeedback.vibrate();
              String? messageId = await showDialog<String>(
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
                            onPressed: () => Navigator.of(context).pop(chatMessage.id!),
                          ),
                        ],
                      ),
                    );
                  });
              await chatProvider.deleteChatMessage(messageId!, groupId!, isLAstMesssage, type);
            }
          },
          child: VoiceMessageWidget(chatMessage: chatMessage));
    } else {
      //chat one to one delete option
      return GestureDetector(
        onLongPress: () async {
          print("✅  chatMessage senderId ${chatMessage.senderId} currentUser.id ${currentUser.id}");

          if (chatMessage.senderId == currentUser.id) {
            await HapticFeedback.vibrate();
            String? messageId = await showDialog<String>(
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
                          onPressed: () => Navigator.of(context).pop(chatMessage.id!),
                        ),
                      ],
                    ),
                  );
                });

            if (messageId != null) {
              await chatProvider.updatePrivateMessageAsDeleted(
                messageId,
                groupId!,
                isLAstMesssage,
                type,
              );
            }
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: chatMessage.senderId == currentUser.id ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                chatMessage.message!,
                style: GoogleFonts.cairo(
                  color: const Color(0xff484848),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: chatMessage.senderId == currentUser.id ? TextAlign.start : TextAlign.end,
              ),
              Row(
                children: [
                  if (chatMessage.senderId == currentUser.id) const Spacer(),
                  Text(
                    intl.DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)) + " " + intl.DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(chatMessage.timestamp!)),
                    style: GoogleFonts.cairo(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  if (chatMessage.senderId != currentUser.id) const Spacer(),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (groupId != null) {
          _loadGroup(groupId!, type);
        }
        final width = MediaQuery.of(context).size.width;
        final height = MediaQuery.of(context).size.height;
        return WillPopScope(
          onWillPop: () async {
            log('Will Pop');
            if (isNotification) {
              log('NOTIFICATION');
              SystemNavigator.pop();
            } else if (newChat) {
              log('NEW CHAT');
              Navigator.popUntil(context, ModalRoute.withName(type == 0 ? OneToOneScreen.routeName : MessagesScreen.routeName));
            } else {
              log('POP');
              Navigator.of(context).pop();
            }
            return Future.value(true);
          },
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: SizedBox(
                width: width,
                height: height,
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
                          // mainAxisSize: MainAxisSize.min,
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
                                  // log('onTap Members');
                                  // final membersData =
                                  //     members!.map((e) => e.toJson()).toList();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => const GroupMembersScreen(),
                                  //     settings:
                                  //         RouteSettings(arguments: membersData),
                                  //   ),
                                  // );
                                }
                                // else if (index == 1) {
                                //   log('Group Files');
                                //   Navigator.of(context).push(MaterialPageRoute(
                                //       builder: (_) => GroupFilesScreen(
                                //             groupName: chatGroup!.name!,
                                //             groupId: groupId!,
                                //           )));
                                // } else {
                                //   log('Logout');
                                //   await PreferencesManager.clearAppData();
                                //   Navigator.of(context).pushAndRemoveUntil(
                                //       MaterialPageRoute(
                                //         builder: (_) =>  SplashScreen(),
                                //       ),
                                //       (route) => false);
                                // }
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
                                // PopupMenuItem(
                                //   value: 0,
                                //   child: Row(
                                //     children: [
                                //       SvgPicture.asset(
                                //         SvgImages.dummyUser,
                                //         width: 14,
                                //         height: 16,
                                //       ),
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //       Text(
                                //         "اعضاء المجموعة",
                                //         style: GoogleFonts.cairo(
                                //           color: const Color(0xff4d4d4d),
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w600,
                                //           fontStyle: FontStyle.normal,
                                //         ),
                                //       ),
                                //     ],
                                //     textDirection: TextDirection.rtl,
                                //     // mainAxisSize: MainAxisSize.min,
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //   ),
                                // ),
                                // PopupMenuItem(
                                //   value: 1,
                                //   child: Row(
                                //     children: [
                                //       SvgPicture.asset(
                                //         SvgImages.dummyUser,
                                //         width: 14,
                                //         height: 16,
                                //       ),
                                //       const SizedBox(
                                //         width: 10,
                                //       ),
                                //       Text(
                                //         "ملفات المجموعة",
                                //         style: GoogleFonts.cairo(
                                //           color: const Color(0xff4d4d4d),
                                //           fontSize: 14,
                                //           fontWeight: FontWeight.w600,
                                //           fontStyle: FontStyle.normal,
                                //         ),
                                //       ),
                                //     ],
                                //     textDirection: TextDirection.rtl,
                                //     // mainAxisSize: MainAxisSize.min,
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //   ),
                                // ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(5),
                              bottomEnd: Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              chatGroup != null ? chatGroup!.name! : '',
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
                            // Navigator.popUntil(
                            //     context,
                            //     ModalRoute.withName(type == 0
                            //         ? OneToOneScreen.routeName
                            //         : MessagesScreen.routeName));
                            log('Will Pop');
                            if (isNotification) {
                              log('NOTIFICATION');
                              SystemNavigator.pop();
                            } else if (newChat) {
                              log('NEW CHAT');
                              Navigator.popUntil(context, ModalRoute.withName(type == 0 ? OneToOneScreen.routeName : MessagesScreen.routeName));
                            } else {
                              log('POP');
                              Navigator.of(context).pop();
                            }
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
                      height: 22,
                    ),
                    if (type == 1)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 30,
                        color: Colors.white,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                log('onTap Members');
                                final groupData = chatGroup!.toJson();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const GroupMembersScreen(),
                                    settings: RouteSettings(arguments: chatGroup!.id!),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "اعضاء المجموعة",
                                    style: GoogleFonts.cairo(
                                      color: const Color(0xffef7124),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Color(0xffef7124),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                log('Group Files');
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => GroupFilesScreen(
                                          groupName: chatGroup!.name!,
                                          groupId: groupId!,
                                        )));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "ملفات المجموعة",
                                    style: GoogleFonts.cairo(
                                      color: const Color(0xffef7124),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_left,
                                    color: Color(0xffef7124),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    StreamBuilder<QuerySnapshot>(
                      stream: Provider.of<ChatProvider>(context).getGroupMessages(groupId: groupId!, userId: currentUser.id!, type: type),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final messagesData = snapshot.data!.docs;
                          final List<ChatMessage> messages = messagesData.map((e) => ChatMessage.fromJson(e.data() as Map<String, dynamic>)).toList();
                          return Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              controller: _scrollController,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return messages[index].senderId == currentUser.id!
                                    ? Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                messages[index].userImage != null && messages[index].userImage != ''
                                                    ? CircleAvatar(
                                                        backgroundImage: NetworkImage(messages[index].userImage!),
                                                        radius: 20,
                                                      )
                                                    : const CircleAvatar(
                                                        backgroundImage: AssetImage(PngImages.user),
                                                        radius: 20,
                                                      ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  messages[index].userName!,
                                                  style: GoogleFonts.cairo(
                                                    color: const Color(0xff4d4d4d),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: width * 0.85,
                                              padding: const EdgeInsets.all(12),
                                              margin: const EdgeInsetsDirectional.only(bottom: 10, top: 5, start: 48),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(5),
                                                boxShadow: const [
                                                  BoxShadow(color: Color(0x29000000), offset: Offset(0, 1), blurRadius: 6, spreadRadius: 0),
                                                ],
                                              ),
                                              child: _getMessageWidget(context, messages[index], index == messages.length - 1),
                                            )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 5,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  messages[index].userName!,
                                                  style: GoogleFonts.cairo(
                                                    color: const Color(0xff4d4d4d),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(messages[index].userImage!),
                                                  radius: 20,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: width * 0.85,
                                              padding: const EdgeInsets.all(12),
                                              margin: const EdgeInsetsDirectional.only(bottom: 10, top: 5, end: 48),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(5),
                                                boxShadow: const [
                                                  BoxShadow(color: Color(0x29000000), offset: Offset(0, 1), blurRadius: 6, spreadRadius: 0),
                                                ],
                                              ),
                                              child: _getMessageWidget(
                                                context,
                                                messages[index],
                                                index == messages.length - 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            ),
                          );
                        } else {
                          return const Spacer();
                        }
                      },
                    ),
                    Container(
                      margin: const EdgeInsetsDirectional.only(start: 15, end: 15, bottom: 20, top: 10),
                      width: width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _focusNode.unfocus();
                              _showRecordingView();
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(SvgImages.voice),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Container(
                              height: 37,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(color: Color(0x1a000000), offset: Offset(0, 0), blurRadius: 6, spreadRadius: 0),
                                ],
                              ),
                              child: TextFormField(
                                controller: _textEditingController,
                                textAlign: TextAlign.start,
                                initialValue: null,
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  hintText: 'اكتب رسالة',
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: SvgPicture.asset(
                                    SvgImages.pen,
                                    fit: BoxFit.scaleDown,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _focusNode.unfocus();
                                      _showAttachmentBottomSheet(context);
                                    },
                                    child: SvgPicture.asset(
                                      SvgImages.attach,
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
                                  // errorStyle: const TextStyle(height: 1.5),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () => _sendMessage(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  SvgImages.send,
                                  fit: BoxFit.scaleDown,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
