// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQItem _$FAQItemFromJson(Map<String, dynamic> json) => FAQItem(
      id: json['id'] as int?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      sortOrder: json['sortOrder'] as int?,
      portalId: json['portalId'] as int?,
    );

Map<String, dynamic> _$FAQItemToJson(FAQItem instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answer': instance.answer,
      'sortOrder': instance.sortOrder,
      'portalId': instance.portalId,
    };
