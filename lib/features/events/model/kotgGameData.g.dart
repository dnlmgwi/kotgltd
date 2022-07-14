// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgGameData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGGameData _$KOTGGameDataFromJson(Map<String, dynamic> json) => KOTGGameData(
      gameData:
          KOTGGameDataAttributes.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGGameDataToJson(KOTGGameData instance) =>
    <String, dynamic>{
      'data': instance.gameData.toJson(),
    };
