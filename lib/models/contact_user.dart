import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:io' as Io;

part 'contact_user.g.dart';

@JsonSerializable()
class ContactUser with ChangeNotifier {
  String? firstName;
  String? insertion;
  String? lastName;
  String? phoneNumber;
  String? emailAddress;
  String? profilePicture;
  String? profilePictureData;
  String? companyName;
  String? profession;
  String? address;
  String? zipcode;
  String? city;
  String? country;
  String? description;
  String? website;
  String? linkedIn;
  String? facebook;
  String? instagram;
  String? twitter;
  bool? isBoardMember;
  String? boardMemberFunction;
  bool? isAdmin;
  int? organizationId;
  int? id;
  bool? isFavorite;

  ContactUser({
    this.firstName,
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
    this.instagram,
    this.twitter,
    this.isBoardMember,
    this.isAdmin,
    this.organizationId,
    this.id,
    this.isFavorite,
  });

  updateFirstname(String value) {
    firstName = value;
  }

  updateInsertion(String value) {
    insertion = value;
  }

  updateLastname(String value) {
    lastName = value;
  }

  updatePhonenumber(String value) {
    phoneNumber = value;
  }

  updateEmail(String value) {
    emailAddress = value;
  }

  updateProfilePictureData(XFile value) async {
    try {
      Uint8List bytes = Io.File(value.path).readAsBytesSync();
//"data:image/jpg;base64" +
      String base64 = "data:image/jpg;base64," + base64Encode(bytes);

      profilePictureData = base64;
    } catch (_) {
      //do something later
    }
  }

  updateCompanyname(String value) {
    companyName = value;
  }

  updateProffesion(String value) {
    profession = value;
  }

  updateAddress(String value) {
    address = value;
  }

  updateZipcode(String value) {
    zipcode = value;
  }

  updateCity(String value) {
    city = value;
  }

  updateCountry(String value) {
    country = value;
  }

  updateDescription(String value) {
    description = value;
  }

  updateWebsite(String value) {
    website = value;
  }

  updateLinkedIn(String value) {
    linkedIn = value;
  }

  updateFacebook(String value) {
    facebook = value;
  }

  updateTwitter(String value) {
    twitter = value;
  }

  updateInstagram(String value) {
    instagram = value;
  }

  updateBoardmemberFunction(String value) {
    boardMemberFunction = value;
  }

  updateIsFavorite(bool value) {
    isFavorite = value;
    notifyListeners();
  }

  factory ContactUser.fromJson(Map<String, dynamic> json) =>
      _$ContactUserFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUserToJson(this);
}
