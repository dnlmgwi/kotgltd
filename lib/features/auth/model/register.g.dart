// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterAdapter extends TypeAdapter<Register> {
  @override
  final int typeId = 2;

  @override
  Register read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Register(
      jwt: fields[0] as String,
      user: fields[1] as User,
    );
  }

  @override
  void write(BinaryWriter writer, Register obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.jwt)
      ..writeByte(1)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      jwt: json['jwt'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'jwt': instance.jwt,
      'user': instance.user.toJson(),
    };
