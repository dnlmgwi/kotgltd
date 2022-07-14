// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventRegDataEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventDataEntity _$KOTGEventDataEntityFromJson(Map<String, dynamic> json) =>
    KOTGEventDataEntity(
      id: json['id'] as String,
      eventRegAttributes: KOTGEventRegAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventDataEntityToJson(
        KOTGEventDataEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.eventRegAttributes.toJson(),
    };
