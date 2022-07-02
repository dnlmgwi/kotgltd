// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inviteEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteEntity _$InviteEntityFromJson(Map<String, dynamic> json) => InviteEntity(
      id: json['id'] as String,
      inviteAttributes:
          InviteAttributes.fromJson(json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InviteEntityToJson(InviteEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.inviteAttributes.toJson(),
    };
