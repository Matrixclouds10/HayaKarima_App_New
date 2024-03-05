// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      name: json['name'] as String?,
      jobTitle: json['job_title'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => UploadedFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      documents: (json['documentations'] as List<dynamic>?)
          ?.map((e) => UploadedFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      phone: json['phone'] as String?,
      governorate: json['govern'] as String?,
      city: json['city'] as String?,
      isAccepted: json['is_accepted'] as bool? ?? false,
      token: json['token'] as String?,
      fcmToken: json['fcm_token'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'job_title': instance.jobTitle,
      'email': instance.email,
      'image': instance.image,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'documentations': instance.documents?.map((e) => e.toJson()).toList(),
      'phone': instance.phone,
      'govern': instance.governorate,
      'city': instance.city,
      'is_accepted': instance.isAccepted,
      'token': instance.token,
      'fcm_token': instance.fcmToken,
    };
