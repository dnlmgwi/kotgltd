// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEvents.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEvents _$KOTGEventsFromJson(Map<String, dynamic> json) => KOTGEvents(
      eventData: (json['data'] as List<dynamic>)
          .map((e) => KOTGEventData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KOTGEventsToJson(KOTGEvents instance) =>
    <String, dynamic>{
      'data': instance.eventData.map((e) => e.toJson()).toList(),
    };
