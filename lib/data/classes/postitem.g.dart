// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postitem _$PostitemFromJson(Map<String, dynamic> json) => Postitem(
      id: json['id'] as int?,
      images: json['images'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      comments: json['comments'] as String?,
      created_by: json['created_by'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      channelName: json['channelName'] as String?,
      channelImage: json['channelImage'] as String?,
      views: json['views'] as int?,
      create_date: json['created_date'] == null
          ? null
          : DateTime.parse(json['created_date'] as String),
    );

Map<String, dynamic> _$PostitemToJson(Postitem instance) => <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
      'title': instance.title,
      'content': instance.content,
      'comments': instance.comments,
      'created_by': instance.created_by,
      'type': instance.type,
      'category': instance.category,
      'channelName': instance.channelName,
      'channelImage': instance.channelImage,
      'views': instance.views,
      'created_date': instance.create_date?.toIso8601String(),
    };
