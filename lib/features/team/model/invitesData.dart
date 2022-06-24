import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'invitesData.g.dart';

@JsonSerializable(explicitToJson: true)
class InvitesData {
  @JsonKey(name: 'invites')
  InvitesList invites;

  InvitesData({required this.invites});

  factory InvitesData.fromJson(Map<String, dynamic> json) =>
      _$InvitesDataFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesDataToJson(this);
}
