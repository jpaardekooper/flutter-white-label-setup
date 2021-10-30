import 'package:json_annotation/json_annotation.dart';

part 'event_users.g.dart';

@JsonSerializable()
class EventUsers {
  int? id;
  String? userName;
  String? userImage;
  int? isGoing;
  bool? takesGuest;

  EventUsers(
      {this.id, this.userName, this.userImage, this.isGoing, this.takesGuest});

  factory EventUsers.fromJson(Map<String, dynamic> json) =>
      _$EventUsersFromJson(json);

  Map<String, dynamic> toJson() => _$EventUsersToJson(this);
}
