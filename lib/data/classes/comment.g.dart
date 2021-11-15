// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commentitem _$CommentitemFromJson(Map<String, dynamic> json) => Commentitem(
      id: json['id'] as int?,
      comment: json['comment'] as String?,
      commnet_count: json['commnet_count'] as int?,
      created_by: json['created_by'] as String?,
      create_date: json['create_date'] == null
          ? null
          : DateTime.parse(json['create_date'] as String),
      post: json['post'] as String?,
      user_picture: json['user_picture'] as String?,
      user_name: json['user_name'] as String?,
      writtenBy_yn: json['writtenBy_yn'] as bool?,
    );

Map<String, dynamic> _$CommentitemToJson(Commentitem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'commnet_count': instance.commnet_count,
      'created_by': instance.created_by,
      'create_date': instance.create_date?.toIso8601String(),
      'post': instance.post,
      'user_picture': instance.user_picture,
      'user_name': instance.user_name,
      'writtenBy_yn': instance.writtenBy_yn,
    };
