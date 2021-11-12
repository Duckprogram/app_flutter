import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.token,
    this.avatar,
    this.id,
    this.email,
    this.name,
    this.picture,
  });

  final int? id;
  final String? name;
  final String? avatar;
  final String? email;
  final String? picture;

  @JsonKey(nullable: true)
  String? token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$name".toString();
  }
}
