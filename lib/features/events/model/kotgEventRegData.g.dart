// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventRegData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventRegEventData _$KOTGEventRegEventDataFromJson(
        Map<String, dynamic> json) =>
    KOTGEventRegEventData(
      eventData:
          KOTGEventDataEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventRegEventDataToJson(
        KOTGEventRegEventData instance) =>
    <String, dynamic>{
      'data': instance.eventData.toJson(),
    };
