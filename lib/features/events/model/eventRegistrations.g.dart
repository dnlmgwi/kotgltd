// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventRegistrations.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRegistrations _$EventRegistrationsFromJson(Map<String, dynamic> json) =>
    EventRegistrations(
      eventRegistations: EventRegistrationData.fromJson(
          json['eventRegistrations'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventRegistrationsToJson(EventRegistrations instance) =>
    <String, dynamic>{
      'eventRegistrations': instance.eventRegistations.toJson(),
    };
