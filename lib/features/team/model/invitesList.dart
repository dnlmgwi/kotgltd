import 'package:kotgltd/features/team/model/inviteEntity.dart';
import 'package:kotgltd/features/team/model/invitesMeta.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'invitesList.g.dart';

@JsonSerializable(explicitToJson: true)
class InvitesList {
  @JsonKey(name: 'data')
  List<InviteEntity> inviteData;

  InvitesMeta? meta;

  InvitesList({required this.inviteData});

  factory InvitesList.fromJson(Map<String, dynamic> json) =>
      _$InvitesListFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesListToJson(this);
}
