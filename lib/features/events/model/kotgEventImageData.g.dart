// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgEventImageData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGEventImageData _$KOTGEventImageDataFromJson(Map<String, dynamic> json) =>
    KOTGEventImageData(
      kotgEventImageAttributes: KOTGEventImageAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGEventImageDataToJson(KOTGEventImageData instance) =>
    <String, dynamic>{
      'attributes': instance.kotgEventImageAttributes.toJson(),
    };
