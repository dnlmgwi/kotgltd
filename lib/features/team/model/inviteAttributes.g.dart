// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inviteAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteAttributes _$InviteAttributesFromJson(Map<String, dynamic> json) =>
    InviteAttributes(
      claimed: json['claimed'] as bool,
      user: UserEntityData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InviteAttributesToJson(InviteAttributes instance) =>
    <String, dynamic>{
      'claimed': instance.claimed,
      'user': instance.user.toJson(),
    };
