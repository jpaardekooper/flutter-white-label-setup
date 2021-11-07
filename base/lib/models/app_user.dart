import 'package:json_annotation/json_annotation.dart';

part 'app_user.g.dart';

@JsonSerializable()
class AppUser {
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'insertion')
  String? insertion;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'emailAddress')
  String? emailAddress;
  @JsonKey(name: 'profilePicture')
  String? profilePicture;
  @JsonKey(name: 'profilePictureData')
  String? profilePictureData;
  @JsonKey(name: 'companyName')
  String? companyName;
  @JsonKey(name: 'profession')
  String? profession;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'zipcode')
  String? zipcode;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'country')
  String? country;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'website')
  String? website;
  @JsonKey(name: 'linkedIn')
  String? linkedIn;
  @JsonKey(name: 'facebook')
  String? facebook;
  @JsonKey(name: 'twitter')
  String? twitter;
  @JsonKey(name: 'isBoardMember')
  bool? isBoardMember;
  @JsonKey(name: 'boardMemberFunction')
  String? boardMemberFunction;
  @JsonKey(name: 'isAdmin')
  bool? isAdmin;
  @JsonKey(name: 'organizationId')
  int? organizationId;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'fullName')
  String? fullName;

  AppUser(
      {this.firstName,
      this.insertion,
      this.lastName,
      this.phoneNumber,
      this.emailAddress,
      this.profilePicture,
      this.profilePictureData,
      this.companyName,
      this.profession,
      this.address,
      this.zipcode,
      this.city,
      this.country,
      this.description,
      this.website,
      this.linkedIn,
      this.facebook,
      this.twitter,
      this.isBoardMember,
      this.isAdmin,
      this.organizationId,
      this.id,
      this.fullName});

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}
