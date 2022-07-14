// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventRegAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventRegAttributes _$KOTGEventRegAttributesFromJson(
        Map<String, dynamic> json) =>
    KOTGEventRegAttributes(
      eventDate: json['event_date'] as String,
      eventTime: json['event_time'] as String,
      name: json['name'] as String,
      game: json['game'] == null
          ? null
          : KOTGGame.fromJson(json['game'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventRegAttributesToJson(
        KOTGEventRegAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'event_date': instance.eventDate,
      'event_time': instance.eventTime,
      'game': instance.game?.toJson(),
    };
