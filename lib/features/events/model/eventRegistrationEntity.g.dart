// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventRegistrationEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRegistrationEntityData _$EventRegistrationEntityDataFromJson(
        Map<String, dynamic> json) =>
    EventRegistrationEntityData(
      id: json['id'] as String,
      eventAttributes: EventRegistrationEntityAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventRegistrationEntityDataToJson(
        EventRegistrationEntityData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.eventAttributes.toJson(),
    };
