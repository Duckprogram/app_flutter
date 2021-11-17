// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postitem _$PostitemFromJson(Map<String, dynamic> json) => Postitem(
      id: json['id'] as int?,
      title: json['title'] as String?,
      category: json['category'] as String?,
      content: json['content'] as String?,
      images: json['images'] as List<dynamic>?,
      views: json['views'] as int?,
      user_name: json['user_name'] as String?,
      userImage: json['userImage'] as String?,
      createdBy: json['createdBy'] as String?,
      create_date: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      channel: json['channel'] as String?,
      channelImage: json['channelImage'] as String?,
    );

Map<String, dynamic> _$PostitemToJson(Postitem instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'content': instance.content,
      'user_name': instance.user_name,
      'userImage': instance.userImage,
      'images': instance.images,
      'views': instance.views,
      'createdBy': instance.createdBy,
      'channel': instance.channel,
      'create_date': instance.create_date?.toIso8601String(),
      'channelImage': instance.channelImage,
    };
