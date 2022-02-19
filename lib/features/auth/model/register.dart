import 'package:kotgltd/packages/models.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'register.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 2)
class Register extends HiveObject {
  @HiveField(0)
  String jwt;

  @HiveField(1)
  User user;

  Register({required this.jwt, required this.user});

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
