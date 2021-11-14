// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postitem _$PostitemFromJson(Map<String, dynamic> json) => Postitem(
    id: json['id'] as int?,
    images: json['images'] as List<dynamic>?,
    title: json['title'] as String?,
    content: json['content'] as String?,
    // username: json['username'] as String?,
    // userImage: json['user_image'] as String?,
    username: "닉네임",
    userImage:
        "https://cdn.pixabay.com/photo/2021/10/23/03/35/mountain-6734031_960_720.jpg",
    category: json['category'] as String?,
    views: json['views'] as int?,
    createdBy: json['created_by'] as String?,
    createdDate: DateTime.parse(json['create_date'] as String),
    channel: json['channel'] as String?,
    channelImage: json['channel_image'] as String?);

Map<String, dynamic> _$PostitemToJson(Postitem instance) => <String, dynamic>{
      'id': instance.id,
      'images': instance.images,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'views': instance.views,
      'created_by': instance.createdBy,
      'created_date': instance.createdDate?.toIso8601String(),
    };
