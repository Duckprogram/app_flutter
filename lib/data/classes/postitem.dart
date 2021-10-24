import 'package:json_annotation/json_annotation.dart';

part 'postitem.g.dart';

@JsonSerializable()
class Post {
  Post({
    this.imagePath,
    this.title,
    this.username,
    this.type,
    this.channelName,
    this.channelImage,
    required this.numOfView,
  });

  final String? imagePath;
  final String? title;
  final String? username;
  final String? type;
  final String? channelName;
  final String? channelImage;
  final int numOfView;

  factory Post.fromJson(Map<String, dynamic> json) =>
      _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() {
    return "$title $channelName".toString();
  }

}
