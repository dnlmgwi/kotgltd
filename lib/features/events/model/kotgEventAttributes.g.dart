// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventAttributes _$KOTGEventAttributesFromJson(Map<String, dynamic> json) =>
    KOTGEventAttributes(
      description: json['description'] as String,
      eventDate: json['event_date'] as String,
      eventTime: json['event_time'] as String,
      name: json['name'] as String,
      price: json['price'] as int,
      prize: json['prize'] as int,
      kotgEventImage:
          KOTGEventImage.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventAttributesToJson(
        KOTGEventAttributes instance) =>
    <String, dynamic>{
      'name': instance.name,
      'event_date': instance.eventDate,
      'event_time': instance.eventTime,
      'image': instance.kotgEventImage.toJson(),
      'description': instance.description,
      'price': instance.price,
      'prize': instance.prize,
    };
