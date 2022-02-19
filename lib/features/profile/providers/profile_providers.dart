import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kotgltd/features/profile/services/profile_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:phone_form_field/phone_form_field.dart';

var profileRepoProvider = Provider(
  (ref) => ProfileRepository(),
);

// var avatarsProvider = FutureProvider<List>((ref) async {
//   final avatarClient = ref.read(profileRepoProvider);
//   return avatarClient.getAvatars();
// });

var avatarProvider = StateProvider<String>((ref) => '');

var firstNameProvider = StateProvider<String>((ref) => '');

var lastNameProvider = StateProvider<String>((ref) => '');

var phoneNumberProvider =
    StateProvider<PhoneNumber>((ref) => PhoneNumber(isoCode: '', nsn: ''));

var otpProvider = StateProvider<String>((ref) => '');

var dateOfBirthProvider = StateProvider<String>((ref) => '');

var bioProvider = StateProvider<String>((ref) => '');
