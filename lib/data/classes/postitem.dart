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
    this.created_by,
    this.type,
    this.category,
    this.channelName,
    this.channelImage,
    this.views,
    this.create_date,
  });

  final int? id;
  final String? images;
  final String? title;
  final String? content;
  final String? comments;
  final String? created_by;
  final String? type;
  final String? category;
  final String? channelName;
  final String? channelImage;
  final int? views;
  final DateTime? create_date;

  factory Postitem.fromJson(Map<String, dynamic> json) =>
      _$PostitemFromJson(json);

  Map<String, dynamic> toJson() => _$PostitemToJson(this);

  @override
  String toString() {
    return "$title $channelName".toString();
  }
}
