// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventRegDataAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventRegDataAttributes _$KOTGEventRegDataAttributesFromJson(
        Map<String, dynamic> json) =>
    KOTGEventRegDataAttributes(
      eventData:
          KOTGEventRegAttributes.fromJson(json['data'] as Map<String, dynamic>),
      id: json['id'] as String,
    );

Map<String, dynamic> _$KOTGEventRegDataAttributesToJson(
        KOTGEventRegDataAttributes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.eventData.toJson(),
    };
