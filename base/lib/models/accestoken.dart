import 'package:json_annotation/json_annotation.dart';

part 'accestoken.g.dart';

@JsonSerializable()
class AccessToken {
  AccessToken({this.bearerToken, this.expiryDate, this.issuedAt});
  @JsonKey(name: 'bearerToken')
  String? bearerToken;
  @JsonKey(name: 'expiryDate')
  int? expiryDate;
  @JsonKey(name: 'issuedAt')
  int? issuedAt;

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}
