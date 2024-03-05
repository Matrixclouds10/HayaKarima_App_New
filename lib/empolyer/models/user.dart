import 'package:hayaah_karimuh/empolyer/models/uploaded_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'job_title')
  String? jobTitle;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'image')
  String? image;
  @JsonKey(name: 'images')
  List<UploadedFile>? images;
  @JsonKey(name: 'documentations')
  List<UploadedFile>? documents;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'govern')
  String? governorate;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'is_accepted')
  bool? isAccepted;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;

  User({this.id, this.name, this.jobTitle, this.email, this.image, this.images, this.documents, this.phone, this.governorate, this.city, this.isAccepted, this.token, this.fcmToken});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
