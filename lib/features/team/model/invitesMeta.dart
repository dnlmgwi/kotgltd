import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/team/model/models.dart';
part 'invitesMeta.g.dart';

@JsonSerializable(explicitToJson: true)
class InvitesMeta {
  // @JsonKey(name: 'invitesMeta')
  // InvitesMeta invitesMeta;

  InvitesMeta();

  factory InvitesMeta.fromJson(Map<String, dynamic> json) =>
      _$InvitesMetaFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesMetaToJson(this);
}
