import 'package:base/models/event_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'events.g.dart';

@JsonSerializable()
class Events {
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? publishDate;
  bool? active;
  String? url;
  String? venueName;
  double? longitude;
  double? latitude;
  String? visualImage;
  bool? mayTakeGuest;
  int? organizationId;
  int? id;
  List<EventUsers?>? eventUsers;

  Events(
      {this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.publishDate,
      this.active,
      this.url,
      this.venueName,
      this.longitude,
      this.latitude,
      this.visualImage,
      this.mayTakeGuest,
      this.organizationId,
      this.id,
      this.eventUsers});

  factory Events.fromJson(Map<String, dynamic> json) => _$EventsFromJson(json);

  Map<String, dynamic> toJson() => _$EventsToJson(this);
}
