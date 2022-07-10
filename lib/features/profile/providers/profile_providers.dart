import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kotgltd/features/profile/model/profile.dart';
import 'package:kotgltd/features/profile/services/profile_repository.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:intl/intl.dart';

var profileRepoProvider = Provider(
  (ref) => ProfileRepository(),
);

// var avatarsProvider = FutureProvider<List>((ref) async {
//   final avatarClient = ref.read(profileRepoProvider);
//   return avatarClient.getAvatars();
// });

var firstNameProvider = StateProvider.autoDispose<String>((ref) => '');

var lastNameProvider = StateProvider.autoDispose<String>((ref) => '');

enum Gender { Man, Woman, None }

var genderProvider =
    StateProvider.autoDispose<String>((ref) => Gender.None.name);

var phoneNumberProvider = StateProvider<PhoneNumber>((ref) => PhoneNumber(
      isoCode: IsoCode.MW,
      nsn: '',
    ));

var otpProvider = StateProvider<String>((ref) => '');

var dateOfBirthProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

var dateOfBirthFinalProvider =
    StateProvider.family<String, DateTime?>((ref, date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date ?? DateTime.now());
  return formatted;
});

var profileProvider = FutureProvider<Profile>((ref) async {
  final profileClient = ref.read(profileRepoProvider);
  return profileClient.getProfile();
});

var bioProvider = StateProvider<String>((ref) => '');
