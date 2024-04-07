// ignore_for_file: public_member_api_docs

import 'package:json_annotation/json_annotation.dart';

part 'support.g.dart';

@JsonSerializable()
class Support {
  Support({this.url, this.text});

  factory Support.fromJson(Map<String, dynamic> json) =>
      _$SupportFromJson(json);

  String? url;
  String? text;

  Map<String, dynamic> toJson() => _$SupportToJson(this);
}
