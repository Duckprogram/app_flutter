// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      interest: json['interest'],
      userCount: json['user_count'] as int?,
      introduction: json['introduction'] as String?,
      rule: json['rule'] as String?,
      content: json['content'] as String?,
      background: json['background'] as String?,
      created_date: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
      last_modified_date: json['last_modified_date'] == null
          ? null
          : DateTime.parse(json['last_modified_date'] as String),
      is_active: json['is_active'] as bool?,
    );

