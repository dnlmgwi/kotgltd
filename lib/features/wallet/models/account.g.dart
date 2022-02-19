// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      id: json['id'] as int?,
      phoneNumber: json['phone_number'] as String,
      status: json['status'] as String,
      balance: json['balance'] as int,
      joinedDate: json['joined_date'] as int,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      lastTransaction: json['last_transaction'] as int?,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'balance': instance.balance,
      'phone_number': instance.phoneNumber,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'joined_date': instance.joinedDate,
      'last_transaction': instance.lastTransaction,
    };
