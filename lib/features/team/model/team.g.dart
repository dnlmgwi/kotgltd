// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeamAdapter extends TypeAdapter<Team> {
  @override
  final int typeId = 6;

  @override
  Team read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Team(
      id: fields[0] as String,
      teamMembers: (fields[4] as List?)?.cast<dynamic>(),
      createdAt: fields[2] as String,
      inviteCode: fields[3] as String,
      teamName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Team obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.teamName)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.inviteCode)
      ..writeByte(4)
      ..write(obj.teamMembers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeamAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      id: json['id'] as String,
      teamMembers: json['team_members'] as List<dynamic>?,
      createdAt: json['created_at'] as String,
      inviteCode: json['invite_code'] as String,
      teamName: json['team_name'] as String,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'id': instance.id,
      'team_name': instance.teamName,
      'created_at': instance.createdAt,
      'invite_code': instance.inviteCode,
      'team_members': instance.teamMembers,
    };
