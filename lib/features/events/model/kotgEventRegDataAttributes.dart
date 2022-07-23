import 'package:kotgltd/features/events/model/kotgEventRegAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventRegDataAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventRegDataAttributes {
  String id;

  @JsonKey(name: 'data')
  KOTGEventRegAttributes eventData;

  KOTGEventRegDataAttributes({
    required this.eventData,
    required this.id,
  });

  factory KOTGEventRegDataAttributes.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventRegDataAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventRegDataAttributesToJson(this);
}
