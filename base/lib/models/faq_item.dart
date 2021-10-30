import 'package:json_annotation/json_annotation.dart';

part 'faq_item.g.dart';

@JsonSerializable()
class FAQItem {
  int? id;
  String? question;
  String? answer;
  int? sortOrder;
  int? portalId;

  FAQItem({this.id, this.question, this.answer, this.sortOrder, this.portalId});

  factory FAQItem.fromJson(Map<String, dynamic> json) =>
      _$FAQItemFromJson(json);

  Map<String, dynamic> toJson() => _$FAQItemToJson(this);
}
