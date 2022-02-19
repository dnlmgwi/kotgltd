import 'package:kotgltd/packages/dependencies.dart';
part 'token.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 4)
class Token extends HiveObject {
  @HiveField(0)
  String jwt;

  Token({required this.jwt});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
