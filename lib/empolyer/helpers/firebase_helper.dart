import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hayaah_karimuh/empolyer/data/network_repo.dart';
import 'package:hayaah_karimuh/empolyer/helpers/preferences_manager.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_group.dart';
import 'package:hayaah_karimuh/empolyer/models/chat_message.dart';
import 'package:hayaah_karimuh/empolyer/models/group_member.dart';
import 'package:hayaah_karimuh/empolyer/models/user_fcm_token.dart';
import 'package:hayaah_karimuh/empolyer/utils/database_keys.dart';
import 'package:path/path.dart';

import 'app_constants.dart';

class FirebaseHelper {
  static FirebaseFirestore? _firebaseFirestore;
  static FirebaseStorage? _firebaseStorage;
  static FirebaseMessaging? _firebaseMessaging;

  static Future<void> init() async {
    _firebaseFirestore = FirebaseFirestore.instance;
    _firebaseStorage = FirebaseStorage.instance;
    _firebaseMessaging = FirebaseMessaging.instance;
    final fcmToken = await _firebaseMessaging!.getToken();
    log('Firebase Token: $fcmToken');
    await PreferencesManager.saveString(PreferencesManager.fcmToken, fcmToken!);
    //TODO this shoud be moved
    // NetworkRepo().updateProfile({'fcm_token': PreferencesManager.getString(PreferencesManager.fcmToken)});
    // _firebaseMessaging!.onTokenRefresh.listen((token) async {
    //   log('Refreshed Firebase Token: $fcmToken');
    //   await PreferencesManager.saveString(PreferencesManager.fcmToken, token);
    //   NetworkRepo().updateProfile({'fcm_token': PreferencesManager.getString(PreferencesManager.fcmToken)});
    // });
  }

  Future<void> updateFcmToken() async {
    final fcmToken = await _firebaseMessaging!.getToken();
    log('Firebase Token: $fcmToken');
    await PreferencesManager.saveString(PreferencesManager.fcmToken, fcmToken!);
    NetworkRepo().updateProfile({'fcm_token': PreferencesManager.getString(PreferencesManager.fcmToken)});
  }

  Future<String> addGroup(ChatGroup chatGroup) async {
    final groupDocumentRef = _firebaseFirestore!.collection(DatabaseKeys.groups).doc();
    log('Group Doc Ref: ${groupDocumentRef.id}');
    // ChatGroup chatGroup = ChatGroup.fakeGroup();
    chatGroup.id = groupDocumentRef.id;
    await groupDocumentRef.set(chatGroup.toJson());
    return groupDocumentRef.id;
  }

  Future<void> deleteChatMessage({required String messageId, required groupId, required bool islastmessage}) async {
    log("✅ messageId: $messageId - groupId: $groupId - islastmessage: $islastmessage");
    try {
      _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update(
        {
          DatabaseKeys.lastMessage: "تم حذف الرسالة",
          'last_timestamp': DateTime.now().millisecondsSinceEpoch,
          'file_type': null,
        },
      ).onError((error, stackTrace) {
        print("✅  onDelete $error");
      });
    } catch (e) {
      print("✅  onDelete 2 $e");
    }
    if (false) return _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).doc(messageId).delete().then((value) {});
  }

  //   Future<void> deleteChatItem(
  //     {required String messageId, required groupId}) async {
  //   return _firebaseFirestore!
  //       .collection(DatabaseKeys.messages)
  //       .doc(groupId)
  //       .collection(DatabaseKeys.messages)
  //       .doc(messageId)
  //       .delete();
  // }

  Future<String> addPrivate(ChatGroup chatGroup) async {
    final groupDocumentRef = _firebaseFirestore!.collection('private_chat').doc();
    log('Group Doc Ref: ${groupDocumentRef.id}');
    // ChatGroup chatGroup = ChatGroup.fakeGroup();
    chatGroup.id = groupDocumentRef.id;
    await groupDocumentRef.set(chatGroup.toJson());
    return groupDocumentRef.id;
  }

  Future<void> deleteGroup(String groupId) async {
    return await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).delete();
  }

  Future<void> leaveGroup(String groupId, int memberId) async {
    final groupData = await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).get();
    ChatGroup chatGroup = ChatGroup.fromJson(groupData.data()!);
    List<int> ids = chatGroup.ids!;
    List<GroupMember> members = chatGroup.members!;
    // List<int> admins = chatGroup.admins!;
    ids.removeWhere((element) => element == memberId);
    members.removeWhere((element) => element.id == memberId);
    // admins.removeWhere((element) => element == memberId);
    chatGroup.members = members;
    chatGroup.ids = ids;
    // chatGroup.admins = admins;
    return await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update(chatGroup.toJson());
  }

  Future<void> addGroupMembers(String groupId, List<GroupMember> newMembers) async {
    final groupData = await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).get();
    ChatGroup chatGroup = ChatGroup.fromJson(groupData.data()!);
    List<int> ids = chatGroup.ids!;
    List<GroupMember> members = chatGroup.members!;

    for (GroupMember member in newMembers) {
      if (!ids.contains(member.id!)) {
        ids.add(member.id!);
      }
      if (!members.any((element) => element.id == member.id)) {
        members.add(member);
      }
    }

    chatGroup.members = members;
    chatGroup.ids = ids;
    return await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update(chatGroup.toJson());
  }

  Future<List<UserFcmToken>> getUsersFcmTokens() async {
    final tokensData = await _firebaseFirestore!.collection('fcm_tokens').get();
    return tokensData.docs.map((e) => UserFcmToken.fromJson(e.data())).toList();
  }

  Future<String> addMessage(String groupId, ChatMessage chatMessage) async {
    final messageRef = _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).doc();
    chatMessage.id = messageRef.id;

    await messageRef.set(chatMessage.toJson());
    var a = await FirebaseFirestore.instance.collection(DatabaseKeys.groups).doc(groupId).get();
    if (a.exists) {
      await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update({DatabaseKeys.lastMessage: chatMessage.toJson(), 'last_timestamp': chatMessage.timestamp});
    } else {
      await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).set({DatabaseKeys.lastMessage: chatMessage.toJson(), 'last_timestamp': chatMessage.timestamp});
    }
    return messageRef.id;
  }

  Future<String> addPrivateMessage(String groupId, ChatMessage chatMessage) async {
    final messageRef = _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).doc();
    chatMessage.id = messageRef.id;

    await messageRef.set(chatMessage.toJson());
    await _firebaseFirestore!.collection('private_chat').doc(groupId).update({DatabaseKeys.lastMessage: chatMessage.toJson(), 'last_timestamp': chatMessage.timestamp});
    return messageRef.id;
  }

  Future<bool> updatePrivateMessage({
    required String groupId,
    required String messageId,
    required String chatMessage,
    required bool isItPrivateChat,
    required bool isItLastMessage,
    int? type,
  }) async {
    print("✅  groupId $groupId");
    print("✅  messageId $messageId");
    print("✅  chatMessage $chatMessage");
    print("✅  isItPrivateChat $isItPrivateChat");

    _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).doc(messageId).update({
      "message": chatMessage,
      if (type != null) "type": type,
    }).onError((error, stackTrace) {
      print("✅  error: $error");
    });

    if (isItPrivateChat && isItLastMessage) {
      await _firebaseFirestore!.collection('private_chat').doc(groupId).update({
        DatabaseKeys.lastMessage: ChatMessage(
          message: chatMessage,
          type: type,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          id: messageId,
        ).toJson(),
        'last_timestamp': DateTime.now().millisecondsSinceEpoch
      });
    }
    if (!isItPrivateChat && isItLastMessage) {
      await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update({
        DatabaseKeys.lastMessage: ChatMessage(
          message: chatMessage,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          id: messageId,
          type: type,
        ).toJson(),
        'last_timestamp': DateTime.now().millisecondsSinceEpoch,
      }).onError((error, stackTrace) {
        print("✅  error3: $error");
      });
    }

    return true;
  }

  Future<List<ChatGroup>> getGroups({required int memberId}) async {
    log('Loading Groups');
    final groupsData = await _firebaseFirestore!.collection(DatabaseKeys.groups).orderBy('last_timestamp', descending: true).where('ids', arrayContains: memberId).get();
    log('groups data');
    List<ChatGroup> groups = groupsData.docs.map((e) => ChatGroup.fromJson(e.data())).toList();
    log('Groups Count: ${groups.length}');
    log('Groups: ${jsonEncode(groups)}');
    for (int i = 0; i < groups.length; i++) {
      log('members: ${groups[i].members!.first.lastSeen}');
      int index = groups[i].members!.indexWhere((element) => element.id == memberId);
      int lastRead = index != -1 ? groups[i].members![index].lastSeen! : 0;
      log('Last Seen: $lastRead');
      if (lastRead < DateTime.now().millisecondsSinceEpoch) {
        log('Time is less than current');
        final messagesData = await _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groups[i].id).collection(DatabaseKeys.messages).get();
        final messages = messagesData.docs.map((e) => ChatMessage.fromJson(e.data())).toList();
        log('Messages Count: ${messages.length}');
        final unreadMessage = messages.where((element) => element.timestamp! > lastRead).toList();
        int unreadCount = unreadMessage.length;
        log('Unread Count: $unreadCount');
        groups[i].unreadCount = unreadCount;
      }
    }
    return groups;
  }

  Stream<QuerySnapshot> getStreamGroups({required int memberId}) {
    log('Loading Groups');
    // log('groups data');
    // log('Groups Count: ${groups.length}');
    // log('Groups: ${jsonEncode(groups)}');
    // for (int i = 0; i < groups.length; i++) {
    //   log('members: ${groups[i].members!.first.lastSeen}');
    //   int index =
    //       groups[i].members!.indexWhere((element) => element.id == memberId);
    //   int lastRead = index != -1 ? groups[i].members![index].lastSeen! : 0;
    //   log('Last Seen: $lastRead');
    //   if (lastRead < DateTime.now().millisecondsSinceEpoch) {
    //     log('Time is less than current');
    //     final messagesData = await _firebaseFirestore!
    //         .collection(DatabaseKeys.messages)
    //         .doc(groups[i].id)
    //         .collection(DatabaseKeys.messages)
    //         .get();
    //     final messages = messagesData.docs
    //         .map((e) => ChatMessage.fromJson(e.data()))
    //         .toList();
    //     log('Messages Count: ${messages.length}');
    //     final unreadMessage =
    //         messages.where((element) => element.timestamp! > lastRead).toList();
    //     int unreadCount = unreadMessage.length;
    //     log('Unread Count: $unreadCount');
    //     groups[i].unreadCount = unreadCount;
    //   }
    // }
    return _firebaseFirestore!.collection(DatabaseKeys.groups).orderBy('last_timestamp', descending: true).where('ids', arrayContains: memberId).snapshots();
  }

  Future<List<ChatGroup>> getPrivateChats({required int memberId}) async {
    log('Member ID -> $memberId');
    log('Loading Groups');
    final groupsData = await _firebaseFirestore!.collection('private_chat').orderBy('last_timestamp', descending: true).where('ids', arrayContains: memberId).get();
    log('groups data');
    log('Docs Count -> ${groupsData.docs.length}');
    List<ChatGroup> groups = groupsData.docs.map((e) => ChatGroup.fromJson(e.data())).toList();
    log('Groups Count: ${groups.length}');
    log('Groups: ${jsonEncode(groups)}');
    for (int i = 0; i < groups.length; i++) {
      log('members: ${groups[i].members!.first.lastSeen}');
      int index = groups[i].members!.indexWhere((element) => element.id == memberId);
      int lastRead = index != -1 ? groups[i].members![index].lastSeen! : 0;
      log('Last Seen: $lastRead');
      if (lastRead < DateTime.now().millisecondsSinceEpoch) {
        log('Time is less than current');
        final messagesData = await _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groups[i].id).collection(DatabaseKeys.messages).get();
        final messages = messagesData.docs.map((e) => ChatMessage.fromJson(e.data())).toList();
        log('Messages Count: ${messages.length}');
        final unreadMessage = messages.where((element) => element.timestamp! > lastRead).toList();
        int unreadCount = unreadMessage.length;
        log('Unread Count: $unreadCount');
        groups[i].unreadCount = unreadCount;
      }
    }
    return groups;
  }

  Future<void> setMessagesAsRead({required String groupId, required int userId}) async {
    final groupData = await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).get();
    ChatGroup chatGroup = ChatGroup.fromJson(groupData.data()!);
    List<GroupMember> members = chatGroup.members!;
    int userIndex = members.indexWhere((element) => element.id == userId);
    members[userIndex].lastSeen = DateTime.now().millisecondsSinceEpoch;
    await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update({DatabaseKeys.members: members.map((e) => e.toJson()).toList()});
  }

  Stream<QuerySnapshot> getGroupMessages({required String groupId, required int userId}) {
    // setMessagesAsRead(groupId: groupId, userId: userId);
    return _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).orderBy('timestamp', descending: false).snapshots();
  }

  Stream<QuerySnapshot> getPrivateMessages({required String groupId, required int userId}) {
    // setMessagesAsRead(groupId: groupId, userId: userId);
    return _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).orderBy('timestamp', descending: false).snapshots();
  }

  Future<QuerySnapshot> getGroupMessagesOnce({required String groupId}) {
    // setMessagesAsRead(groupId: groupId, userId: userId);
    return _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).orderBy('timestamp', descending: false).get();
  }

  Future<QuerySnapshot> getPrivateMessagesOnce({required String groupId}) {
    // setMessagesAsRead(groupId: groupId, userId: userId);
    return _firebaseFirestore!.collection(DatabaseKeys.messages).doc(groupId).collection(DatabaseKeys.messages).orderBy('timestamp', descending: false).get();
  }

  Future<void> _updateGroupTimestamp(String groupId) async {
    await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update({'last_timestamp': DateTime.now().millisecondsSinceEpoch});
  }

  Future<ChatGroup> getGroup(String groupId) async {
    final groupData = await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).get();
    return ChatGroup.fromJson(groupData.data()!);
  }

  Future<ChatGroup> getPrivateChat(String groupId) async {
    final groupData = await _firebaseFirestore!.collection('private_chat').doc(groupId).get();
    return ChatGroup.fromJson(groupData.data()!);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getGroupStream(String groupId) {
    return _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getPrivateChatStream(String groupId) {
    return _firebaseFirestore!.collection('private_chat').doc(groupId).snapshots();
  }

  Future<String> uploadFile(String filePath, int userId, int type) async {
    final int random = DateTime.now().millisecondsSinceEpoch;
    String fileType = basename(filePath).substring(basename(filePath).length - 3).toUpperCase();

    if (type == MessageType.image) {
      log('File Type: Image');
      final imageRef = _firebaseStorage!.ref('images/${userId}_$random.$fileType');
      await imageRef.putFile(File(filePath));
      return await imageRef.getDownloadURL();
    } else if (type == MessageType.video) {
      log('File Type: Video');
      final videoRef = _firebaseStorage!.ref('videos/${userId}_$random.$fileType');
      await videoRef.putFile(File(filePath));
      return await videoRef.getDownloadURL();
    } else if (type == MessageType.audio) {
      log('File Type: Audio');
      final audioRef = _firebaseStorage!.ref('audios/${userId}_$random.$fileType');
      await audioRef.putFile(File(filePath));
      return await audioRef.getDownloadURL();
    } else {
      log('File Type: File');
      final fileRef = _firebaseStorage!.ref('files/${userId}_$random.$fileType');
      await fileRef.putFile(File(filePath));
      return await fileRef.getDownloadURL();
    }
  }

  Future<String> uploadGroupImage(String filePath, int userId) async {
    final int random = DateTime.now().millisecondsSinceEpoch;
    String fileType = basename(filePath).substring(basename(filePath).length - 3).toUpperCase();

    final groupImagesRef = _firebaseStorage!.ref('group_images/${userId}_$random.$fileType');
    await groupImagesRef.putFile(File(filePath));
    return await groupImagesRef.getDownloadURL();
  }

  Future<void> updateMessage(
    String groupId,
    String messageId,
    Map<String, dynamic> data,
  ) async {
    await _firebaseFirestore!.collection('messages').doc(groupId).collection('messages').doc(messageId).update(data);
  }

  Future<void> setUserAdmin(String groupId, int userId) async {
    ChatGroup chatGroup = await getGroup(groupId);
    List<GroupMember> members = chatGroup.members!;
    List<GroupMember> newMembers = [];

    for (GroupMember member in members) {
      if (member.id == userId) {
        member.isAdmin = true;
      }
      newMembers.add(member);
    }
    return await _firebaseFirestore!.collection(DatabaseKeys.groups).doc(groupId).update({'members': newMembers.map((e) => e.toJson()).toList()});
  }
}
