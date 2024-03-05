import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable(explicitToJson: true)
class ChatMessage {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'sender_id')
  int? senderId;
  @JsonKey(name: 'user_name')
  String? userName;
  @JsonKey(name: 'user_image')
  String? userImage;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'timestamp')
  int? timestamp;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'video_url')
  String? videoUrl;
  @JsonKey(name: 'video_thumbnail')
  String? videoThumbnail;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'file_name')
  String? fileName;
  @JsonKey(name: 'file_size')
  String? fileSize;
  @JsonKey(name: 'file_url')
  String? fileUrl;
  @JsonKey(name: 'audio_url')
  String? audioUrl;
  // @JsonKey(name: 'receivers')
  // String? receivers;
  @JsonKey(name: 'duration')
  int? duration;

  ChatMessage({
    this.id,
    this.senderId,
    this.userName,
    this.userImage,
    this.message,
    this.timestamp,
    this.type,
    this.imageUrl,
    this.videoUrl,
    this.fileUrl,
    this.videoThumbnail,
    this.fileType,
    this.audioUrl,
    this.fileName,
    // this.receivers,
    this.duration = 0,
    this.fileSize = "0",
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

// static ChatMessage fakeMessage() {
//   return ChatMessage(
//     senderId: 1,
//     userName: 'Hazem',
//     userImage:
//         'https://static.wikia.nocookie.net/jamescameronsavatar/images/b/b4/Avatar2logo2.jpg/revision/latest?cb=20201224182633',
//     message: 'Hi',
//     timestamp: DateTime.now().millisecondsSinceEpoch,
//   );
// }

// static List<ChatMessage> fakeMessages() {
//   return List.generate(
//       10,
//       (index) => index % 2 == 0
//           ? ChatMessage(
//               senderId: 1,
//               userName: 'Hazem',
//               userImage:
//                   'https://static.wikia.nocookie.net/jamescameronsavatar/images/b/b4/Avatar2logo2.jpg/revision/latest?cb=20201224182633',
//               message: 'Hi $index',
//               timestamp: DateTime.now().millisecondsSinceEpoch,
//             )
//           : ChatMessage(
//               senderId: 2,
//               userName: 'Hazem',
//               userImage:
//                   'https://static.wikia.nocookie.net/jamescameronsavatar/images/b/b4/Avatar2logo2.jpg/revision/latest?cb=20201224182633',
//               message: 'Hi $index',
//               timestamp: DateTime.now().millisecondsSinceEpoch,
//             ));
// }
}
