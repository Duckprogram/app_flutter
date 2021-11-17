// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      token: json['token'] as String?,
      avatar: json['avatar'] as String?,
      userId: json['userId'] as int?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      picture: json['picture'] as String?,
      createDate: json['createDate'] == null
          ? null
          : DateTime.parse(json['createDate'] as String),
      lastModifiedDate: json['lastModifiedDate'] == null
          ? null
          : DateTime.parse(json['lastModifiedDate'] as String),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
      'picture': instance.picture,
      'createDate': instance.createDate?.toIso8601String(),
      'lastModifiedDate': instance.lastModifiedDate?.toIso8601String(),
      'role': instance.role,
      'token': instance.token,
    };
