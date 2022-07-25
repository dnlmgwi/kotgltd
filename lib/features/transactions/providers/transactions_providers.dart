import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kotgltd/features/transactions/services/transactions_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';

var transactionRepoProvider = Provider(
  (ref) => TransactionRepository(),
);

var transactionProvider = FutureProvider.autoDispose((ref) async {
  final transactionClient = ref.read(transactionRepoProvider);
  return transactionClient.myTransactions();
});
