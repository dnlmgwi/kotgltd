// import 'package:kotgltd/features/auth/exception/input_exception.dart';
// import 'package:kotgltd/features/auth/model/token.dart';
// import 'package:kotgltd/features/wallet/models/transaction_record.dart';
// import 'package:kotgltd/features/wallet/models/wallet.dart';
// import 'package:kotgltd/features/wallet/services/wallet_repository.dart';
// import 'package:kotgltd/packages/core.dart';
// import 'package:kotgltd/packages/dependencies.dart';

// class WalletService {
//   final _perrowApi = WalletRepository();
//   final tokens = Hive.box<Token>('token');

//   Future fetchSystemStatus() async {
//     Map? response;
//     try {
//       response = await _perrowApi.getStatus();
//     } on UnauthorisedException catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//     return response!;
//   }

//   Future<Wallet> fetchWalletBalance() async {
//     Wallet? response;
//     try {
//       response = await _perrowApi.getUserWallet(token: tokens.get(0)!.jwt);
//     } on UnauthorisedException catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//       rethrow;
//     }
//     return response!;
//   }

//   Future<Map> transferAmount({required int amount}) async {
//     //TODO Create KOTG System Account
//     var recipientID = 0;
//     Map response;
//     try {
//       response = await _perrowApi.transfer(
//           amount: amount, recipientID: recipientID, token: tokens.get(0)!.jwt);
//       print(response); //Show User
//     } catch (e) {
//       rethrow;
//     }
//     return response;
//   }

//   Future<List<TransactionRecord>> fetchTransactions() async {
//     var response = <TransactionRecord>[];
//     try {
//       response =
//           await _perrowApi.getUserTransactions(token: tokens.get(0)!.jwt);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
