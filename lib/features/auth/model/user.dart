import 'package:kotgltd/features/auth/model/profile.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 5)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String email;

  User({
    required this.id,
    required this.email,
    required this.username,
    // this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
