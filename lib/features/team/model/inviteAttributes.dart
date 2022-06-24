import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'inviteAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class InviteAttributes {
  bool claimed;

  @JsonKey(name: 'user')
  UserEntityData user;

  InviteAttributes({required this.claimed, required this.user});

  factory InviteAttributes.fromJson(Map<String, dynamic> json) =>
      _$InviteAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$InviteAttributesToJson(this);
}
