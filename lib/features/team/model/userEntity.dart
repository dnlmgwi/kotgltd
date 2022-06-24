import 'package:kotgltd/features/auth/model/user.dart';
import 'package:kotgltd/packages/dependencies.dart';
export 'package:kotgltd/features/team/model/models.dart';
part 'userEntity.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntity {
  String email;

  String username;

  UserEntity({
    required this.email,
    required this.username,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
