import 'package:kotgltd/features/events/model/kotgGameDataAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgGame.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGGame {
  @JsonKey(name: 'data')
  KOTGGameDataAttributes gameData;

  KOTGGame({required this.gameData});

  factory KOTGGame.fromJson(Map<String, dynamic> json) =>
      _$KOTGGameFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGGameToJson(this);
}
