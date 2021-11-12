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
  String? fullName;

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
    this.fullName,
  });

  updateFirstname(String value) {
    firstName = value;
    notifyListeners();
  }

  updateInsertion(String value) {
    insertion = value;
    notifyListeners();
  }

  updateLastname(String value) {
    lastName = value;
    notifyListeners();
  }

  updatePhonenumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  updateEmail(String value) {
    emailAddress = value;
    notifyListeners();
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
    notifyListeners();
  }

  updateProffesion(String value) {
    profession = value;
    notifyListeners();
  }

  updateAddress(String value) {
    address = value;
    notifyListeners();
  }

  updateZipcode(String value) {
    zipcode = value;
    notifyListeners();
  }

  updateCity(String value) {
    city = value;
    notifyListeners();
  }

  updateCountry(String value) {
    country = value;
    notifyListeners();
  }

  updateDescription(String value) {
    description = value;
    notifyListeners();
  }

  updateWebsite(String value) {
    website = value;
    notifyListeners();
  }

  updateLinkedIn(String value) {
    linkedIn = value;
    notifyListeners();
  }

  updateFacebook(String value) {
    facebook = value;
    notifyListeners();
  }

  updateTwitter(String value) {
    twitter = value;
    notifyListeners();
  }

  updateInstagram(String value) {
    instagram = value;
    notifyListeners();
  }

  updateBoardmemberFunction(String value) {
    boardMemberFunction = value;
    notifyListeners();
  }

  updateIsFavorite(bool value) {
    isFavorite = value;
    notifyListeners();
  }

  factory ContactUser.fromJson(Map<String, dynamic> json) =>
      _$ContactUserFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUserToJson(this);
}
