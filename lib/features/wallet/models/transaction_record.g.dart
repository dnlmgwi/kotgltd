// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionRecordAdapter extends TypeAdapter<TransactionRecord> {
  @override
  final int typeId = 7;

  @override
  TransactionRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionRecord(
      sender: fields[1] as String,
      recipient: fields[2] as String,
      amount: fields[3] as int,
      timestamp: fields[4] as int,
      transId: fields[5] as String,
      transType: fields[6] as int,
      blockId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionRecord obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.recipient)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.transId)
      ..writeByte(6)
      ..write(obj.transType)
      ..writeByte(7)
      ..write(obj.blockId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionRecord _$TransactionRecordFromJson(Map<String, dynamic> json) =>
    TransactionRecord(
      sender: json['sender'] as String,
      recipient: json['recipient'] as String,
      amount: json['amount'] as int,
      timestamp: json['timestamp'] as int,
      transId: json['trans_id'] as String,
      transType: json['trans_type'] as int,
      blockId: json['block_id'] as String?,
    );

Map<String, dynamic> _$TransactionRecordToJson(TransactionRecord instance) =>
    <String, dynamic>{
      'sender': instance.sender,
      'recipient': instance.recipient,
      'amount': instance.amount,
      'timestamp': instance.timestamp,
      'trans_id': instance.transId,
      'trans_type': instance.transType,
      'block_id': instance.blockId,
    };
