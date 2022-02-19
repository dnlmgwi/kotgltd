import 'package:kotgltd/packages/models.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'login.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 0)
class Login extends HiveObject {
  @HiveField(0)
  String jwt;

  @HiveField(1)
  User user;

  Login({required this.jwt, required this.user});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
