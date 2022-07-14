// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgGameDataAttributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGGameDataAttributes _$KOTGGameDataAttributesFromJson(
        Map<String, dynamic> json) =>
    KOTGGameDataAttributes(
      gameAttributes: KOTGGameAttributes.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGGameDataAttributesToJson(
        KOTGGameDataAttributes instance) =>
    <String, dynamic>{
      'attributes': instance.gameAttributes.toJson(),
    };
