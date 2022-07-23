// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventUserAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventUserAttributes _$EventUserAttributesFromJson(Map<String, dynamic> json) =>
    EventUserAttributes(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
    );

Map<String, dynamic> _$EventUserAttributesToJson(
        EventUserAttributes instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
