// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventUser _$EventUserFromJson(Map<String, dynamic> json) => EventUser(
      eventUserData:
          EventUserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventUserToJson(EventUser instance) => <String, dynamic>{
      'data': instance.eventUserData.toJson(),
    };
