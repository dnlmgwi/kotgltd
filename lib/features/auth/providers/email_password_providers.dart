import 'package:hooks_riverpod/hooks_riverpod.dart';

final passwordProvider = StateProvider<String>((ref) => '');

final passwordCheckProvider = StateProvider<String>((ref) => '');

final emailProvider = StateProvider<String>((ref) => '');

final usernameProvider = StateProvider<String>((ref) => '');

final passwordVisibilityProvider = StateProvider<bool>((ref) {
  return true;
});

final tcProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
