import 'package:json_annotation/json_annotation.dart';

part 'error.g.dart';

@JsonSerializable()
class ErrorMessage {
  String? type;
  String? title;
  int? status;
  String? detail;
  String? instance;
  String? additionalProp1;
  String? additionalProp2;
  String? additionalProp3;

  ErrorMessage(
      {this.type,
      this.title,
      this.status,
      this.detail,
      this.instance,
      this.additionalProp1,
      this.additionalProp2,
      this.additionalProp3});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorMessageToJson(this);
}
