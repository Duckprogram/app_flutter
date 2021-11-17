import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.token,
    this.avatar,
    this.userId,
    this.email,
    this.name,
    this.picture,
    this.createDate,
    this.lastModifiedDate,
    this.role,
  });

  final int? userId;
  final String? name;
  final String? avatar;
  final String? email;
  final String? picture;
  final DateTime? createDate;
  final DateTime? lastModifiedDate;
  final String? role;

  @JsonKey(nullable: true)
  String? token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$name".toString();
  }
}
