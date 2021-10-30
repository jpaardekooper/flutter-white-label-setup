import 'package:json_annotation/json_annotation.dart';
import 'accestoken.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'accessToken')
  AccessToken? accessToken;
  @JsonKey(name: 'refreshToken')
  AccessToken? refreshToken;

  Token({this.accessToken, this.refreshToken});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
