import 'package:kotgltd/features/auth/providers/auth_state.dart';
import 'package:kotgltd/features/auth/services/auth_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';

final authRepoProvider = Provider(
  (ref) => AuthRepository(),
);

final authProvider = ChangeNotifierProvider(
  (ref) => AuthStateNotifier(ref.read(authRepoProvider)),
);

final authStateProvider =
    StreamProvider((ref) => ref.watch(authProvider).authStateChanges());
