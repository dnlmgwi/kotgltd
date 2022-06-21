import 'package:kotgltd/features/profile/model/profile.dart';
import 'package:phone_form_field/phone_form_field.dart';

abstract class IProfileRepository {
  ///Get User Profile
  Future<Profile> getProfile();

  ///Update User Profile
  Future updateProfile({
    required String firstName,
    required String lastName,
    required String gender,
    required String dateOfBirth,
  });
}
