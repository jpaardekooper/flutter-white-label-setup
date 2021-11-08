// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventUsers _$EventUsersFromJson(Map<String, dynamic> json) => EventUsers(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      userImage: json['userImage'] as String?,
      isGoing: json['isGoing'] as int?,
      takesGuest: json['takesGuest'] as bool?,
    );

Map<String, dynamic> _$EventUsersToJson(EventUsers instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'userImage': instance.userImage,
      'isGoing': instance.isGoing,
      'takesGuest': instance.takesGuest,
    };
