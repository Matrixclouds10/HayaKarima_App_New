import 'package:hayaah_karimuh/empolyer/models/chat_message.dart';
import 'package:hayaah_karimuh/empolyer/models/group_member.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_group.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatGroup {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'ids')
  List<int>? ids;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'members')
  List<GroupMember>? members;
  @JsonKey(name: 'last_message')
  ChatMessage? lastMessage;
  @JsonKey(name: 'last_timestamp')
  int? lastTimestamp;
  @JsonKey(ignore: true)
  int? unreadCount;
  @JsonKey(name: 'group_image')
  String? groupImage;
  // @JsonKey(name: 'group_owner')
  // int? groupOwner;
  // @JsonKey(name: 'admins')
  // List<int>? admins;

  ChatGroup(
      {this.id,
      this.name,
      this.ids,
      this.members,
      // this.admins,
      this.lastMessage,
      this.unreadCount,
      this.groupImage,
      // this.groupOwner,
      this.lastTimestamp});

  factory ChatGroup.fromJson(Map<String, dynamic> json) => _$ChatGroupFromJson(json);

  Map<String, dynamic> toJson() => _$ChatGroupToJson(this);

// static ChatGroup fakeGroup() {
//   return ChatGroup(
//       name: 'Fake Group',
//       members: GroupMember.fakeMembers(),
//       lastMessage: ChatMessage.fakeMessages().first);
// }
}
