import 'dart:convert';
import 'dart:io';
import 'package:kotgltd/data/enviroment_creds.dart';
// import 'package:supabase/supabase.dart';
import 'package:http/http.dart' as http;
import 'package:kotgltd/features/wallet/exceptions/api_exception.dart';
import 'package:kotgltd/features/wallet/interfaces/i_wallet_repository.dart';
import 'package:kotgltd/features/wallet/models/transaction_record.dart';
import 'package:kotgltd/features/wallet/models/wallet.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

class WalletRepository extends IWalletRepository {
  static const _baseURL = Env.perrowApi;

  @override
  Future<Wallet?> getUserWallet({required String token}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseURL/v1/user/account'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception('Network Error');
      }

      return Wallet.fromJson(json.decode(response.body)['data']['account']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getStatus() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseURL/v1/info/status'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        },
      );
      if (response.statusCode == 404) {
        throw Exception('Not Found');
      }

      if (response.statusCode == 401) {
        throw Exception('Token Expired');
      }

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception('Network Error');
      }

      return json.decode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future transfer({
    required int amount,
    required int recipientID,
    required String token,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse('$_baseURL/v1/wallet/transfer'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          "Authorization": "Bearer $token"
        },
        body:
            jsonEncode(<String, dynamic>{'id': recipientID, 'amount': amount}),
      );

      print('${response.statusCode} ${response.body}');

      if (response.statusCode == 403) {
        throw PendingTransactionException(
            json.decode(response.body)['data']['message']);
      }
      if (response.statusCode == 404) {
        throw Exception('Account Not Found');
      }
      if (response.statusCode != 200) {
        throw NetworkErrorException();
      }

      var result = json.decode(response.body)['data'];

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TransactionRecord>> getUserTransactions(
      {required String token}) async {
    //Todo Handling
    var jsonTransactions = <TransactionRecord>[];
    try {
      final http.Response response = await http.get(
        Uri.parse('$_baseURL/v1/user/transactions'),
        headers: <String, String>{
          HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
          "Authorization": "Bearer $token"
        },
      );
      if (response.statusCode == 404) {
        throw Exception('User Has No Transactions');
      }
      if (response.statusCode != 200) {
        throw NetworkErrorException();
      }

      var result = json.decode(response.body)['data']['transactions'] as List;

      for (var item in result) {
        jsonTransactions.add(TransactionRecord.fromJson(item));
      }

      return jsonTransactions;
    } catch (e) {
      throw NetworkErrorException();
    }
  }
}
