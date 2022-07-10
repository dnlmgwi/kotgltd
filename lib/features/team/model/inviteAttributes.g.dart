// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inviteAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteAttributes _$InviteAttributesFromJson(Map<String, dynamic> json) =>
    InviteAttributes(
      claimed: json['claimed'] as bool?,
      user: json['user'] == null
          ? null
          : UserEntityData.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      inviteCode: json['invite_code'] as String?,
    );

Map<String, dynamic> _$InviteAttributesToJson(InviteAttributes instance) =>
    <String, dynamic>{
      'claimed': instance.claimed,
      'invite_code': instance.inviteCode,
      'createdAt': instance.createdAt?.toIso8601String(),
      'user': instance.user?.toJson(),
    };
