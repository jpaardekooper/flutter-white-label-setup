// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Events _$EventsFromJson(Map<String, dynamic> json) => Events(
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      publishDate: json['publishDate'] == null
          ? null
          : DateTime.parse(json['publishDate'] as String),
      active: json['active'] as bool?,
      url: json['url'] as String?,
      venueName: json['venueName'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      visualImage: json['visualImage'] as String?,
      mayTakeGuest: json['mayTakeGuest'] as bool?,
      organizationId: json['organizationId'] as int?,
      id: json['id'] as int?,
      eventUsers: (json['eventUsers'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : EventUsers.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventsToJson(Events instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'publishDate': instance.publishDate?.toIso8601String(),
      'active': instance.active,
      'url': instance.url,
      'venueName': instance.venueName,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'visualImage': instance.visualImage,
      'mayTakeGuest': instance.mayTakeGuest,
      'organizationId': instance.organizationId,
      'id': instance.id,
      'eventUsers': instance.eventUsers,
    };
