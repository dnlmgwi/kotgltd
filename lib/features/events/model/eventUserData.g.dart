// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventUserData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventUserData _$EventUserDataFromJson(Map<String, dynamic> json) =>
    EventUserData(
      eventUserAttributes: EventUserAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventUserDataToJson(EventUserData instance) =>
    <String, dynamic>{
      'attributes': instance.eventUserAttributes.toJson(),
    };
