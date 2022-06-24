import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'userData.g.dart';

@JsonSerializable(explicitToJson: true)
class UserData {
  @JsonKey(name: 'data')
  UserEntityData userData;

  UserData({required this.userData});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
