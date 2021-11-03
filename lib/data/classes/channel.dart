import 'package:json_annotation/json_annotation.dart';

part 'channel.g.dart';

@JsonSerializable()
class Channel {
  Channel({
    this.id,
    this.name,
    this.introduction,
    this.rule,
    this.content,
    this.background,
    this.created_date,
    this.last_modified_date,
    this.is_active,
    this.icon,
    this.numOfPeople,
  });

  final int? id;
  final String? name;
  final String? introduction;
  final String? rule;
  final String? content;
  final String? background;
  final DateTime? created_date;
  final DateTime? last_modified_date;
  final bool? is_active;
  final String? icon;
  final int? numOfPeople;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelToJson(this);

  @override
  String toString() {
    return "$name $introduction".toString();
  }
}
