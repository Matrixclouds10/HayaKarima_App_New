import 'package:json_annotation/json_annotation.dart';

part 'group_member.g.dart';

@JsonSerializable(explicitToJson: true)
class GroupMember {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'last_seen')
  int? lastSeen;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'is_admin')
  bool isAdmin;
  @JsonKey(name: 'is_owner')
  bool isOwner;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;
  GroupMember(
      {this.id,
      this.lastSeen,
      this.isOwner = false,
      this.isAdmin = false,
      this.name,
      this.fcmToken,
      this.image});

  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  Map<String, dynamic> toJson() => _$GroupMemberToJson(this);

// static List<GroupMember> fakeMembers() {
//   return List.generate(
//       2,
//       (index) => GroupMember(
//           id: 1, lastSeen: DateTime.now().millisecondsSinceEpoch));
// }
}
