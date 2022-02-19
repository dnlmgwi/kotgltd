import 'package:kotgltd/features/auth/model/avatar.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'profile.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 9)
class Profile extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  Avatar? avatar;

  Profile({
    required this.id,
    this.avatar,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
