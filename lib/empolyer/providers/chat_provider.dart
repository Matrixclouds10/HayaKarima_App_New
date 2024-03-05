import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/data/echo.dart';
import 'package:hayaah_karimuh/empolyer/helpers/app_constants.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_message.dart';
import 'package:hayaah_karimuh/empolyer/models/requests/firebase_notification_request.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:media_info/media_info.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../data/network_repo.dart';
import '../models/requests/save_notification_request.dart';

class ChatProvider extends ChangeNotifier {
  bool _isRecording = false;
  String? voicePath;
  Duration recordingTime = Duration.zero;

  void setRecordingTime(int tick) {
    recordingTime = Duration(seconds: tick);
    log('Second: ${recordingTime.inHours.remainder(60).toString()}:${recordingTime.inMinutes.remainder(60).toString()}:${recordingTime.inSeconds.remainder(60).toString().padLeft(2, '0')}');
    notifyListeners();
  }

  void setRecoding(bool isRecording) {
    _isRecording = isRecording;
    notifyListeners();
  }

  bool get isRecording => _isRecording;

  Stream<QuerySnapshot> getGroupMessages({required String groupId, required int userId, required int type}) {
    // EasyLoading.show();
    final stream = type == 0 ? FirebaseHelper().getPrivateMessages(groupId: groupId, userId: userId) : FirebaseHelper().getGroupMessages(groupId: groupId, userId: userId);
    // EasyLoading.dismiss();
    return stream;
  }

  Future<void> notifyGroupMembers(FirebaseNotificationRequest request) async {
    await NetworkRepo().notifyGroupMembers(request);
  }

  Future<void> addMessage(String groupId, ChatMessage chatMessage, int type) async {
    type == 0 ? await FirebaseHelper().addPrivateMessage(groupId, chatMessage) : await FirebaseHelper().addMessage(groupId, chatMessage);
  }

  Future<void> deleteChatMessage(
    String messageId,
    String groupId,
    bool isLastMsg,
    int type,
  ) async {
    print("✅  deleteChatMessage");

    FirebaseHelper().updatePrivateMessage(
      groupId: groupId,
      messageId: messageId,
      chatMessage: "Message has been deleted 1",
      isItPrivateChat: type == 0,
      isItLastMessage: isLastMsg,
      type: 1,
    );

    // return FirebaseHelper().deleteChatMessage(
    //   messageId: messageId,
    //   groupId: groupId,
    //   islastmessage: isLastMsg,
    // );
  }

  Future<bool> updatePrivateMessageAsDeleted(
    String messageId,
    String groupId,
    bool isLastMsg,
    int type,
  ) async {
    print("✅  updatePrivateMessageAsDeleted");
    return FirebaseHelper().updatePrivateMessage(
      groupId: groupId,
      messageId: messageId,
      chatMessage: "Message has been deleted",
      isItPrivateChat: type == 0,
      isItLastMessage: isLastMsg,
    );
  }

  Future<ChatGroup> getGroup(String groupId, int type) async {
    return type == 0 ? FirebaseHelper().getPrivateChat(groupId) : FirebaseHelper().getGroup(groupId);
  }

  Future<String> getVideoThumbnail(String filePath) async {
    log('Video Path: $filePath');
    final thumbnailPath = await VideoThumbnail.thumbnailFile(video: filePath, maxHeight: 0, maxWidth: 0, imageFormat: ImageFormat.PNG, timeMs: 0);
    log('Thumbnail Path: $thumbnailPath');
    // await FirebaseHelper().uploadFile(thumbnail.path, FileType.image);
    return thumbnailPath!;
  }

  Future<void> uploadAudioFile(String groupId, int userId, String filePath) async {
    kEcho("stop recording 3.1");
    final MediaInfo _mediaInfo = MediaInfo();
    kEcho("stop recording 3.2 $filePath");
    int fileDuration = 300;
    try {
      // final fileInfo = await _mediaInfo.getMediaInfo(filePath);
      // fileDuration = fileInfo['durationMs'];
    } catch (e) {
      kEcho(" error $e");
    }
    kEcho("stop recording 3.3");
    kEcho("stop recording 3.4");
    String fileType = basename(filePath).substring(basename(filePath).length - 3).toUpperCase();
    kEcho("stop recording 3.5");
    String? fileName = basename(filePath);
    kEcho("stop recording 3.6");
    String? fileSize = ((await File(filePath).length() / 1024) / 1024).toStringAsFixed(2);
    kEcho("stop recording 3.7");

    final User currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);
    kEcho("stop recording 3.8");

    final fileUrl = await FirebaseHelper().uploadFile(filePath, userId, MessageType.audio);
    log('File URL: $fileUrl');
    kEcho("stop recording 3.9");

    ChatMessage chatMessage = ChatMessage(
      senderId: currentUser.id,
      message: '',
      timestamp: DateTime.now().millisecondsSinceEpoch,
      userName: currentUser.name,
      userImage: currentUser.image ?? '',
      fileType: fileType,
      fileSize: fileSize,
      fileName: fileName,
      audioUrl: fileUrl,
      duration: fileDuration,
      type: MessageType.audio,
    );

    kEcho("stop recording 3.10");
    await FirebaseHelper().addMessage(groupId, chatMessage);
    kEcho("stop recording 3.11");
    EasyLoading.dismiss();
    kEcho("stop recording 3.12");

    // await FirebaseHelper().updateMessage(groupId, messageId, {
    //   'image_url': messageType == MessageType.image ? fileUrl : null,
    //   'video_url': messageType == MessageType.video ? fileUrl : null,
    //   'file_url': messageType == MessageType.file ? fileUrl : null,
    // });
  }

  Future saveNotification(SaveNotificationRequest request) async {
    await NetworkRepo().saveNotification(request);
  }
}
