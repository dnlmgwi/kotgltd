import 'package:kotgltd/packages/models.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'register_response.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 3)
class RegisterResponse extends HiveObject {
  @HiveField(0)
  Register register;

  RegisterResponse({required this.register});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}
