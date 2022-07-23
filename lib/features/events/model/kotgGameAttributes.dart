import 'package:kotgltd/features/events/model/kotgEvents.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgGameAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGGameAttributes {
  String name;

  KOTGGameAttributes({
    required this.name,
  });

  factory KOTGGameAttributes.fromJson(Map<String, dynamic> json) =>
      _$KOTGGameAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGGameAttributesToJson(this);
}
