import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'inviteEntity.g.dart';

@JsonSerializable(explicitToJson: true)
class InviteEntity {
  String id;

  @JsonKey(name: 'attributes')
  InviteAttributes inviteAttributes;

  InviteEntity({required this.id, required this.inviteAttributes});

  factory InviteEntity.fromJson(Map<String, dynamic> json) =>
      _$InviteEntityFromJson(json);

  Map<String, dynamic> toJson() => _$InviteEntityToJson(this);
}
