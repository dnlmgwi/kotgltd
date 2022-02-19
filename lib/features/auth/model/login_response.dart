import 'package:kotgltd/packages/models.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'login_response.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 1)
class LoginResponse extends HiveObject {
  @HiveField(0)
  Login login;

  LoginResponse({required this.login});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
