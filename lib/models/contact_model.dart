class ContactModel {
  int? id;
  int? wordPressId;
  int? portalId;
  String? firstName;
  String? inBetween;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? profilePicture;
  String? companyName;
  String? address;
  String? city;
  String? zipcode;
  String? description;
  String? website;
  String? linkedIn;
  String? twitter;
  String? facebook;
  bool? isAdmin;
  bool? isBoardMember;
  String? boardMemberFunction;
  String? portal;
  String? lastAccessedTime;
  String? fullName;
  String? fullLastName;

  ContactModel(
      {this.id,
      this.wordPressId,
      this.portalId,
      this.firstName,
      this.inBetween,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.profilePicture,
      this.companyName,
      this.address,
      this.city,
      this.zipcode,
      this.description,
      this.website,
      this.linkedIn,
      this.twitter,
      this.facebook,
      this.isAdmin,
      this.isBoardMember,
      this.boardMemberFunction,
      this.portal,
      this.lastAccessedTime,
      this.fullName,
      this.fullLastName});

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wordPressId = json['wordPressId'];
    portalId = json['portalId'];
    firstName = json['firstName'];
    inBetween = json['inBetween'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    companyName = json['companyName'];
    address = json['address'];
    city = json['city'];
    zipcode = json['zipcode'];
    description = json['description'];
    website = json['website'];
    linkedIn = json['linkedIn'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    isAdmin = json['isAdmin'];
    isBoardMember = json['isBoardMember'];
    boardMemberFunction = json['boardMemberFunction'];
    portal = json['portal'];
    lastAccessedTime = json['lastAccessedTime'];
    fullName = json['fullName'];
    fullLastName = json['fullLastName'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['wordPressId'] = wordPressId;
    data['portalId'] = portalId;
    data['firstName'] = firstName;
    data['inBetween'] = inBetween;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    data['companyName'] = companyName;
    data['address'] = address;
    data['city'] = city;
    data['zipcode'] = zipcode;
    data['description'] = description;
    data['website'] = website;
    data['linkedIn'] = linkedIn;
    data['twitter'] = twitter;
    data['facebook'] = facebook;
    data['isAdmin'] = isAdmin;
    data['isBoardMember'] = isBoardMember;
    data['boardMemberFunction'] = boardMemberFunction;
    data['portal'] = portal;
    data['lastAccessedTime'] = lastAccessedTime;
    data['fullName'] = fullName;
    data['fullLastName'] = fullLastName;
    return data;
  }
}
