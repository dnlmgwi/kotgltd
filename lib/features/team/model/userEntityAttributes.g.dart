// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userEntityAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntityAttributes _$UserEntityAttributesFromJson(
        Map<String, dynamic> json) =>
    UserEntityAttributes(
      userAttributes:
          UserEntity.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserEntityAttributesToJson(
        UserEntityAttributes instance) =>
    <String, dynamic>{
      'attributes': instance.userAttributes.toJson(),
    };
