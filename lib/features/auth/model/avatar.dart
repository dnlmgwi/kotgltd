import 'package:kotgltd/packages/dependencies.dart';
part 'avatar.g.dart';

@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 10)
class Avatar extends HiveObject {
  @HiveField(0)
  String id;

  Avatar({
    required this.id,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) => _$AvatarFromJson(json);

  Map<String, dynamic> toJson() => _$AvatarToJson(this);
}
