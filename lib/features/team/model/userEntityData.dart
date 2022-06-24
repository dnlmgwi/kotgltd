import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'userEntityData.g.dart';

@JsonSerializable(explicitToJson: true)
class UserEntityData {
  @JsonKey(name: 'data')
  UserEntityAttributes data;

  UserEntityData({required this.data});

  factory UserEntityData.fromJson(Map<String, dynamic> json) =>
      _$UserEntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityDataToJson(this);
}
