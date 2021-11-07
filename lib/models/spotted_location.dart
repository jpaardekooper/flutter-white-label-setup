import 'package:json_annotation/json_annotation.dart';

part 'spotted_location.g.dart';

@JsonSerializable()
class SpottedLocation {
  String? title;
  String? description;
  String? address;
  String? zipcode;
  String? city;
  String? country;
  DateTime? publishDate;
  String? url;
  double? longitude;
  double? latitude;
  String? visualImageData;
  int? organizationId;
  int? id;
  String? visualImage;

  SpottedLocation(
    this.title,
    this.description,
    this.address,
    this.zipcode,
    this.city,
    this.country,
    this.publishDate,
    this.url,
    this.longitude,
    this.latitude,
    this.visualImageData,
    this.organizationId,
    this.id,
    this.visualImage,
  );

  factory SpottedLocation.fromJson(Map<String, dynamic> json) =>
      _$SpottedLocationFromJson(json);

  Map<String, dynamic> toJson() => _$SpottedLocationToJson(this);
}
