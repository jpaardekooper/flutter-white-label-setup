// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      firstName: json['firstName'] as String?,
      insertion: json['insertion'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      emailAddress: json['emailAddress'] as String?,
      profilePicture: json['profilePicture'] as String?,
      profilePictureData: json['profilePictureData'] as String?,
      companyName: json['companyName'] as String?,
      profession: json['profession'] as String?,
      address: json['address'] as String?,
      zipcode: json['zipcode'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      description: json['description'] as String?,
      website: json['website'] as String?,
      linkedIn: json['linkedIn'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      isBoardMember: json['isBoardMember'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
      organizationId: json['organizationId'] as int?,
      id: json['id'] as int?,
      fullName: json['fullName'] as String?,
    )..boardMemberFunction = json['boardMemberFunction'] as String?;

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'insertion': instance.insertion,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'emailAddress': instance.emailAddress,
      'profilePicture': instance.profilePicture,
      'profilePictureData': instance.profilePictureData,
      'companyName': instance.companyName,
      'profession': instance.profession,
      'address': instance.address,
      'zipcode': instance.zipcode,
      'city': instance.city,
      'country': instance.country,
      'description': instance.description,
      'website': instance.website,
      'linkedIn': instance.linkedIn,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'isBoardMember': instance.isBoardMember,
      'boardMemberFunction': instance.boardMemberFunction,
      'isAdmin': instance.isAdmin,
      'organizationId': instance.organizationId,
      'id': instance.id,
      'fullName': instance.fullName,
    };
