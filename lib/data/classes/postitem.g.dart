// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'postitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Postitem _$PostitemFromJson(Map json) => Postitem(
      no: json['no'] as int,
      imagePath: json['imagePath'] as String?,
      title: json['title'] as String?,
      username: json['username'] as String?,
      type: json['type'] as String?,
      channelName: json['channelName'] as String?,
      channelImage: json['channelImage'] as String?,
      numOfView: json['numOfView'] as int,
    );

Map<String, dynamic> _$PostitemToJson(Postitem instance) => <String, dynamic>{
      'no': instance.no,
      'imagePath': instance.imagePath,
      'title': instance.title,
      'username': instance.username,
      'type': instance.type,
      'channelName': instance.channelName,
      'channelImage': instance.channelImage,
      'numOfView': instance.numOfView,
    };
