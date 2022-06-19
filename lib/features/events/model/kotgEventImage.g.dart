// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventImage _$KOTGEventImageFromJson(Map<String, dynamic> json) =>
    KOTGEventImage(
      eventImageData:
          KOTGEventImageData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventImageToJson(KOTGEventImage instance) =>
    <String, dynamic>{
      'data': instance.eventImageData.toJson(),
    };
