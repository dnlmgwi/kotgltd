// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventData _$KOTGEventDataFromJson(Map<String, dynamic> json) =>
    KOTGEventData(
      id: json['id'] as String,
      eventAttributes: KOTGEventAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventDataToJson(KOTGEventData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.eventAttributes.toJson(),
    };
