import 'package:kotgltd/features/events/model/kotgGameAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgGameDataAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGGameDataAttributes {
  @JsonKey(name: 'attributes')
  KOTGGameAttributes gameAttributes;

  KOTGGameDataAttributes({required this.gameAttributes});

  factory KOTGGameDataAttributes.fromJson(Map<String, dynamic> json) =>
      _$KOTGGameDataAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGGameDataAttributesToJson(this);
}
