import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'inviteAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class InviteAttributes {
  bool? claimed;

  @JsonKey(name: 'invite_code')
  String? inviteCode;

  DateTime? createdAt;

  @JsonKey(name: 'user')
  UserEntityData? user;

  InviteAttributes({this.claimed, this.user, this.createdAt, this.inviteCode});

  factory InviteAttributes.fromJson(Map<String, dynamic> json) =>
      _$InviteAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$InviteAttributesToJson(this);
}
