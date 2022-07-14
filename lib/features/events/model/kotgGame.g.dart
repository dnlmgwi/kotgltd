// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kotgGame.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KOTGGame _$KOTGGameFromJson(Map<String, dynamic> json) => KOTGGame(
      gameData:
          KOTGGameDataAttributes.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KOTGGameToJson(KOTGGame instance) => <String, dynamic>{
      'data': instance.gameData.toJson(),
    };
