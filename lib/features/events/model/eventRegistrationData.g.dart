// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventRegistrationData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRegistrationData _$EventRegistrationDataFromJson(
        Map<String, dynamic> json) =>
    EventRegistrationData(
      eventRegistrationEntityData: (json['data'] as List<dynamic>)
          .map((e) =>
              EventRegistrationEntityData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventRegistrationDataToJson(
        EventRegistrationData instance) =>
    <String, dynamic>{
      'data':
          instance.eventRegistrationEntityData.map((e) => e.toJson()).toList(),
    };
