import 'package:kotgltd/features/auth/model/user.dart';
import 'package:kotgltd/packages/dependencies.dart';

final pageProvider = StateProvider<int>((ref) => 0);

final currentUserProvider = FutureProvider.autoDispose<User?>((ref) async {
  final user = Hive.box<User>('user');
  User? _user = user.getAt(0);
  return _user;
});
