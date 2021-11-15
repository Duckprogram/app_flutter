import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
class Commentitem {
  Commentitem(
    {
      this.id,
      this.comment,
      this.commnet_count,
      this.created_by,
      this.create_date,
      this.post,
      this.user_picture,
      this.user_name,
      this.writtenBy_yn,
    }
  );

  final int? id;
  final String? comment;
  final int? commnet_count;
  final String? created_by;
  final DateTime? create_date;
  final String? post;
  final String? user_picture;
  final String? user_name;
  final bool? writtenBy_yn;

  factory Commentitem.fromJson(Map<String, dynamic> json) =>
      _$CommentitemFromJson(json);

  Map<String, dynamic> toJson() => _$CommentitemToJson(this);

  @override
  String toString() {
    return "$comment".toString();
  }
}
