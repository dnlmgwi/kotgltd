// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventRegistrationEntityAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRegistrationEntityAttributes _$EventRegistrationEntityAttributesFromJson(
        Map<String, dynamic> json) =>
    EventRegistrationEntityAttributes(
      event:
          KOTGEventRegEventData.fromJson(json['event'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      reference: json['reference'] as String,
      registeredAt: DateTime.parse(json['registered_at'] as String),
      status: json['status'] as String,
      transactionId: json['transaction_id'] as String?,
      user: EventUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EventRegistrationEntityAttributesToJson(
        EventRegistrationEntityAttributes instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
      'user': instance.user.toJson(),
      'reference': instance.reference,
      'status': instance.status,
      'registered_at': instance.registeredAt.toIso8601String(),
      'transaction_id': instance.transactionId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
