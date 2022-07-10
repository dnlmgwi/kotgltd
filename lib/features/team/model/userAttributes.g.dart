// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAttributes _$UserAttributesFromJson(Map<String, dynamic> json) =>
    UserAttributes(
      claimed: json['claimed'] as bool,
      userEntity: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserAttributesToJson(UserAttributes instance) =>
    <String, dynamic>{
      'claimed': instance.claimed,
      'user': instance.userEntity.toJson(),
    };
