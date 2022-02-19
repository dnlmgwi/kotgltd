
// final walletProvider = Provider(
//   (ref) => WalletService(),
// );

// final systemStatusProvider = FutureProvider((ref) async {
//   final tokenClient = ref.watch(walletProvider);
//   return tokenClient.fetchSystemStatus();
// });

// final balanceProvider = FutureProvider.autoDispose<Wallet>((ref) async {
//   try {
//     final tokenClient = ref.watch(walletProvider).fetchWalletBalance();
//     return tokenClient;
//   } on SocketException {
//     ref.watch(networkAwareProvider).isOff();
//     rethrow;
//   } catch (e) {
//     rethrow;
//   }
// });

// final transactionsProvider = FutureProvider((ref) async {
//   final tokenClient = ref.watch(walletProvider);
//   return tokenClient.fetchTransactions();
// });
