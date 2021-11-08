// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spotted_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpottedLocation _$SpottedLocationFromJson(Map<String, dynamic> json) =>
    SpottedLocation(
      json['title'] as String?,
      json['description'] as String?,
      json['address'] as String?,
      json['zipcode'] as String?,
      json['city'] as String?,
      json['country'] as String?,
      json['publishDate'] == null
          ? null
          : DateTime.parse(json['publishDate'] as String),
      json['url'] as String?,
      (json['longitude'] as num?)?.toDouble(),
      (json['latitude'] as num?)?.toDouble(),
      json['visualImageData'] as String?,
      json['organizationId'] as int?,
      json['id'] as int?,
      json['visualImage'] as String?,
    );

Map<String, dynamic> _$SpottedLocationToJson(SpottedLocation instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'zipcode': instance.zipcode,
      'city': instance.city,
      'country': instance.country,
      'publishDate': instance.publishDate?.toIso8601String(),
      'url': instance.url,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'visualImageData': instance.visualImageData,
      'organizationId': instance.organizationId,
      'id': instance.id,
      'visualImage': instance.visualImage,
    };
