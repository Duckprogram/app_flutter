import 'package:json_annotation/json_annotation.dart';
part 'postitem.g.dart';

@JsonSerializable()
class Postitem {
  Postitem(
      {this.id,
      this.title,
      this.category,
      this.content,
      this.images,
      this.views,
      this.username,
      this.userImage,
      this.createdBy,
      this.createdDate,
      this.channel,
      this.channelImage});

  final int? id;

  final String? title;
  final String? category;
  final String? content;
  final String? username;
  final String? userImage;
  final List<dynamic>? images;
  final int? views;
  final String? createdBy;
  final String? channel;
  final DateTime? createdDate;
  final String? channelImage;

  factory Postitem.fromJson(Map<String, dynamic> json) =>
      _$PostitemFromJson(json);

  Map<String, dynamic> toJson() => _$PostitemToJson(this);

  @override
  String toString() {
    return "$title".toString();
  }
}
