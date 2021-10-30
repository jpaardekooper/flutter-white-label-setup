// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accestoken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      bearerToken: json['bearerToken'] as String?,
      expiryDate: json['expiryDate'] as int?,
      issuedAt: json['issuedAt'] as int?,
    );

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'bearerToken': instance.bearerToken,
      'expiryDate': instance.expiryDate,
      'issuedAt': instance.issuedAt,
    };
