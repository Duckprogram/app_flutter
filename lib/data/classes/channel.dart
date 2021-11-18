import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  Channel({
    this.id,
    this.icon,
    this.name,
    this.interest,
    this.userCount,
    this.introduction,
    this.rule,
    this.content,
    this.background,
    this.created_date,
    this.last_modified_date,
    this.is_active,
  });

  final int? id;
  final String? name;
  final String? introduction;
  final String? rule;
  final String? content;
  final String? background;
  final List<dynamic>? interest;
  final DateTime? created_date;
  final DateTime? last_modified_date;
  final bool? is_active;
  final String? icon;
  final int? userCount;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  @override
  String toString() {
    return "id: $id, name: $name, introduction: $introduction, rule: $rule, content: $content, background: $background, interest: $interest, created_date: $created_date, last_modified_date: $last_modified_date, is_active: $is_active, icon: $icon, userCount: $userCount";
  }
}
