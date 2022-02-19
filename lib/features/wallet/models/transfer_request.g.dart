// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferRequest _$TransferRequestFromJson(Map<String, dynamic> json) =>
    TransferRequest(
      id: json['id'] as int?,
      amount: json['amount'] as int?,
    );

Map<String, dynamic> _$TransferRequestToJson(TransferRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
    };
