import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  static const fromJsonFactory = _$UserFromJson;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String id;
  final String? avatarUrl;
  final bool? isSpidUser;
  final bool? isEnabled;
  final String? avatarId;
  final String permissionCode;
  final String email;
  final String firstName;
  final String fiscalCode;
  final String lastName;
  final String? phoneNumber;

  User({
    required this.id,
    this.avatarUrl,
    required this.isSpidUser,
    required this.isEnabled,
    this.avatarId,
    required this.permissionCode,
    required this.email,
    required this.firstName,
    required this.fiscalCode,
    required this.lastName,
    this.phoneNumber,
  });
}
