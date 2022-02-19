// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterResponseAdapter extends TypeAdapter<RegisterResponse> {
  @override
  final int typeId = 3;

  @override
  RegisterResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterResponse(
      register: fields[0] as Register,
    );
  }

  @override
  void write(BinaryWriter writer, RegisterResponse obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.register);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      register: Register.fromJson(json['register'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'register': instance.register.toJson(),
    };
