import 'package:kotgltd/features/profile/model/profileAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
class Profile {
  String id;

  @JsonKey(name: 'attributes')
  ProfileAttributes profileAttributes;

  Profile({required this.id, required this.profileAttributes});

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
