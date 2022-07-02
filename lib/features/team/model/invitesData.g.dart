// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitesData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesData _$InvitesDataFromJson(Map<String, dynamic> json) => InvitesData(
      invites: InvitesList.fromJson(json['invites'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvitesDataToJson(InvitesData instance) =>
    <String, dynamic>{
      'invites': instance.invites.toJson(),
    };
