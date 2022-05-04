import 'package:kotgltd/features/events/model/kotgEventAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventData.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventData {
  String id;

  @JsonKey(name: 'attributes')
  KOTGEventAttributes eventAttributes;

  KOTGEventData({required this.id, required this.eventAttributes});

  factory KOTGEventData.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventDataFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventDataToJson(this);
}
