// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitesList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesList _$InvitesListFromJson(Map<String, dynamic> json) => InvitesList(
      inviteData: (json['data'] as List<dynamic>)
          .map((e) => InviteEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..meta = json['meta'] == null
        ? null
        : InvitesMeta.fromJson(json['meta'] as Map<String, dynamic>);

Map<String, dynamic> _$InvitesListToJson(InvitesList instance) =>
    <String, dynamic>{
      'data': instance.inviteData.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };
