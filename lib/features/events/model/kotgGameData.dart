import 'package:kotgltd/features/events/model/kotgEvents.dart';
import 'package:kotgltd/features/events/model/kotgGameDataAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgGameData.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGGameData {
  @JsonKey(name: 'data')
  KOTGGameDataAttributes gameData;

  KOTGGameData({required this.gameData});

  factory KOTGGameData.fromJson(Map<String, dynamic> json) =>
      _$KOTGGameDataFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGGameDataToJson(this);
}
