import 'package:kotgltd/features/wallet/models/transaction_record.dart';
import 'package:kotgltd/features/wallet/models/wallet.dart';

abstract class IWalletRepository {
  Future<Wallet?> getUserWallet({required String token});

  Future getStatus();

  Future transfer({
    required int amount,
    required int recipientID,
    required String token,
  });

  Future<List<TransactionRecord>> getUserTransactions({required String token});
}
