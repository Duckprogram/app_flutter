import 'package:json_annotation/json_annotation.dart';

part 'postitem.g.dart';

@JsonSerializable()
class Postitem {
  Postitem({
    required this.no,
    this.imagePath,
    this.title,
    this.username,
    this.type,
    this.channelName,
    this.channelImage,
    required this.numOfView,
  });

  @JsonKey(name: "no")
  final int no;

  final String? imagePath;
  final String? title;
  final String? username;
  final String? type;
  final String? channelName;
  final String? channelImage;
  final int numOfView;

  factory Postitem.fromJson(Map<String, dynamic> json) =>
      _$PostitemFromJson(json);

  Map<String, dynamic> toJson() => _$PostitemToJson(this);

  @override
  String toString() {
    return "$title $channelName".toString();
  }
}
