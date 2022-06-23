// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profileAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileAttributes _$ProfileAttributesFromJson(Map<String, dynamic> json) =>
    ProfileAttributes(
      createdAt: DateTime.parse(json['createdAt'] as String),
      email: json['email'] as String,
      username: json['username'] as String,
      gender: json['gender'] as String? ?? "",
      dateOfBirth: json['date_of_birth'] as String? ?? "",
      firstName: json['first_name'] as String? ?? "",
      isoCode: json['iso_code'] as String? ?? "",
      lastName: json['last_name'] as String? ?? "",
      phoneNumber: json['phone_number'] as String? ?? "",
    );

Map<String, dynamic> _$ProfileAttributesToJson(ProfileAttributes instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_of_birth': instance.dateOfBirth,
      'gender': instance.gender,
      'iso_code': instance.isoCode,
      'phone_number': instance.phoneNumber,
      'username': instance.username,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
    };
