// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Channel _$ChannelFromJson(Map<String, dynamic> json) => Channel(
      id: json['id'] as int?,
      name: json['name'] as String?,
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
      icon: json['icon'] as String?,
      numOfPeople: json['numOfPeople'] as int?,
    );

Map<String, dynamic> _$ChannelToJson(Channel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'introduction': instance.introduction,
      'rule': instance.rule,
      'content': instance.content,
      'background': instance.background,
      'created_date': instance.created_date?.toIso8601String(),
      'last_modified_date': instance.last_modified_date?.toIso8601String(),
      'is_active': instance.is_active,
      'icon': instance.icon,
      'numOfPeople': instance.numOfPeople,
    };
