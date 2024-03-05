import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hayaah_karimuh/empolyer/helpers/app_constants.dart';
import 'package:hayaah_karimuh/empolyer/helpers/firebase_helper.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_message.dart';
import 'package:hayaah_karimuh/empolyer/models/user.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AttachPreviewProvider extends ChangeNotifier {
  Future<void> uploadFile(String groupId, String filePath, int messageType) async {
    String? videoThumbnail;
    String fileType = basename(filePath).substring(basename(filePath).length - 3).toUpperCase();
    String? fileName = basename(filePath);
    String? fileSize = ((await File(filePath).length() / 1024) / 1024).toStringAsFixed(2);

    final User currentUser = User.fromJson(PreferencesManager.load(User().runtimeType) as Map<String, dynamic>);

    final fileUrl = await FirebaseHelper().uploadFile(filePath, currentUser.id!, messageType);
    log('File URL: $fileUrl');

    if (messageType == MessageType.video) {
      String thumbnailPath = await getVideoThumbnail(filePath);
      videoThumbnail = await FirebaseHelper().uploadFile(thumbnailPath, currentUser.id!, MessageType.image);
      log('Thumbnail URL: $videoThumbnail');
    }

    ChatMessage chatMessage = ChatMessage(
        senderId: currentUser.id,
        message: '',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        userName: currentUser.name,
        userImage: currentUser.image ?? '',
        fileType: fileType,
        fileSize: fileSize,
        fileName: fileName,
        videoThumbnail: messageType == MessageType.video ? videoThumbnail : null,
        fileUrl: messageType == MessageType.file ? fileUrl : null,
        videoUrl: messageType == MessageType.video ? fileUrl : null,
        imageUrl: messageType == MessageType.image ? fileUrl : null,
        type: messageType);

    await FirebaseHelper().addMessage(groupId, chatMessage);
    EasyLoading.dismiss();

    // await FirebaseHelper().updateMessage(groupId, messageId, {
    //   'image_url': messageType == MessageType.image ? fileUrl : null,
    //   'video_url': messageType == MessageType.video ? fileUrl : null,
    //   'file_url': messageType == MessageType.file ? fileUrl : null,
    // });
  }

  Future<String> getVideoThumbnail(String filePath) async {
    log('Video Path: $filePath');
    final thumbnailPath = await VideoThumbnail.thumbnailFile(video: filePath, maxHeight: 0, maxWidth: 0, imageFormat: ImageFormat.PNG, timeMs: 0);
    log('Thumbnail Path: $thumbnailPath');
    // await FirebaseHelper().uploadFile(thumbnail.path, FileType.image);
    return thumbnailPath!;
  }
}
