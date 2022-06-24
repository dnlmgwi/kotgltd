import 'package:kotgltd/features/team/model/userEntity.dart';
import 'package:kotgltd/packages/dependencies.dart';
export 'package:kotgltd/features/team/model/models.dart';
part 'userEntityAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntityAttributes {
  @JsonKey(name: 'attributes')
  UserEntity userAttributes;

  UserEntityAttributes({
    required this.userAttributes,
  });

  factory UserEntityAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserEntityAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityAttributesToJson(this);
}
