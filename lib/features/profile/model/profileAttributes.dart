import 'package:kotgltd/packages/dependencies.dart';
part 'profileAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileAttributes {
  @JsonKey(name: 'first_name')
  late String firstName;

  @JsonKey(name: 'last_name')
  late String lastName;

  @JsonKey(name: 'date_of_birth')
  late String dateOfBirth;

  late String gender;

  @JsonKey(name: 'iso_code')
  late String isoCode;

  @JsonKey(name: 'phone_number')
  late String phoneNumber;

  late String username;

  late String email;

  late DateTime createdAt;

  ProfileAttributes({
    required this.createdAt,
    required this.email,
    required this.username,
    this.gender = "",
    this.dateOfBirth = "",
    this.firstName = "",
    this.isoCode = "",
    this.lastName = "",
    this.phoneNumber = "",
  });

  factory ProfileAttributes.fromJson(Map<String, dynamic> json) =>
      _$ProfileAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileAttributesToJson(this);
}
