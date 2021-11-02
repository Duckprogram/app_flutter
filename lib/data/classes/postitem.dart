import 'package:json_annotation/json_annotation.dart';

part 'postitem.g.dart';

@JsonSerializable()
class Postitem {
  Postitem({
    this.id,
    this.images,
    this.title,
    this.content,
    this.comments,
    this.username,
    this.type,
    this.category,
    this.channelName,
    this.channelImage,
    this.views,
  });

  final int? id;
  final String? images;
  final String? title;
  final String? content;
  final String? comments;
  final String? username;
  final String? type;
  final String? category;
  final String? channelName;
  final String? channelImage;
  final int? views;

  factory Postitem.fromJson(Map<String, dynamic> json) =>
      _$PostitemFromJson(json);

  Map<String, dynamic> toJson() => _$PostitemToJson(this);

  @override
  String toString() {
    return "$title $channelName".toString();
  }
}
