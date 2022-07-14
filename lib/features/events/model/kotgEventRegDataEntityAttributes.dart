import 'package:kotgltd/features/events/model/kotgEventRegAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventRegDataEntityAttributes.g.dart';
@JsonSerializable(explicitToJson: true)
class KOTGEventRegDataEntityAttributes {
  String id;

  @JsonKey(name: 'data')
  KOTGEventRegAttributes eventData;

  KOTGEventRegDataEntityAttributes({
    required this.eventData,
    required this.id,
  });

  factory KOTGEventRegDataEntityAttributes.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventRegDataEntityAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventRegDataEntityAttributesToJson(this);
}
