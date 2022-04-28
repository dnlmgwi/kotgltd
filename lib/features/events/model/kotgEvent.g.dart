// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEvent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEvent _$KOTGEventFromJson(Map<String, dynamic> json) => KOTGEvent(
      kotgEvents: KOTGEvents.fromJson(json['events'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventToJson(KOTGEvent instance) => <String, dynamic>{
      'events': instance.kotgEvents.toJson(),
    };
