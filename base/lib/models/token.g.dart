// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Token _$TokenFromJson(Map<String, dynamic> json) => Token(
      accessToken: json['accessToken'] == null
          ? null
          : AccessToken.fromJson(json['accessToken'] as Map<String, dynamic>),
      refreshToken: json['refreshToken'] == null
          ? null
          : AccessToken.fromJson(json['refreshToken'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
