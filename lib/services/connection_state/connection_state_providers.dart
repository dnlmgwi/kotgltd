import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/services/connection_state/connection_service.dart';

final networkAwareProvider = ChangeNotifierProvider((ref) {
  return NetworkDetectorNotifier();
});

final networkStateProvider = StreamProvider((ref) {
  ref.watch(networkAwareProvider).connectionState();
  return ref.watch(networkAwareProvider).networkStateChanges();
});
