import 'package:kotgltd/packages/dependencies.dart';

part 'team.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable(explicitToJson: true)
@HiveType(typeId: 6)
class Team extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  @JsonKey(name: 'team_name')
  String teamName;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  @JsonKey(name: 'invite_code')
  String inviteCode;

  @HiveField(4)
  @JsonKey(name: 'team_members')
  List? teamMembers;

  @HiveField(5)
  bool deleted;

  @HiveField(6)
  @JsonKey(name: 'deleted_at')
  DateTime? deletedAt;

  Team({
    required this.id,
    required this.deleted,
    required this.deletedAt,
    this.teamMembers,
    required this.createdAt,
    required this.inviteCode,
    required this.teamName,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
