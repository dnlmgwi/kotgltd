import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'userAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class UserAttributes {
  bool claimed;

  @JsonKey(name: 'user')
  UserEntity userEntity;

  UserAttributes({required this.claimed, required this.userEntity});

  factory UserAttributes.fromJson(Map<String, dynamic> json) =>
      _$UserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$UserAttributesToJson(this);
}
