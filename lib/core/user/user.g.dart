// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      isSpidUser: json['isSpidUser'] as bool?,
      isEnabled: json['isEnabled'] as bool?,
      avatarId: json['avatarId'] as String?,
      permissionCode: json['permissionCode'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      fiscalCode: json['fiscalCode'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'avatarUrl': instance.avatarUrl,
      'isSpidUser': instance.isSpidUser,
      'isEnabled': instance.isEnabled,
      'avatarId': instance.avatarId,
      'permissionCode': instance.permissionCode,
      'email': instance.email,
      'firstName': instance.firstName,
      'fiscalCode': instance.fiscalCode,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
    };
