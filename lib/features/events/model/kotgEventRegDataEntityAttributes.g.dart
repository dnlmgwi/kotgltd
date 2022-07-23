// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventRegDataEntityAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventRegDataEntityAttributes _$KOTGEventRegDataEntityAttributesFromJson(
        Map<String, dynamic> json) =>
    KOTGEventRegDataEntityAttributes(
      eventData:
          KOTGEventRegAttributes.fromJson(json['data'] as Map<String, dynamic>),
      id: json['id'] as String,
    );

Map<String, dynamic> _$KOTGEventRegDataEntityAttributesToJson(
        KOTGEventRegDataEntityAttributes instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.eventData.toJson(),
    };
