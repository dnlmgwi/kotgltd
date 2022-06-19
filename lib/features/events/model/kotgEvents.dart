import 'package:kotgltd/features/events/model/kotgEventData.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEvents.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEvents {
  @JsonKey(name: 'data')
  List<KOTGEventData> eventData;

  KOTGEvents({ required this.eventData});

  factory KOTGEvents.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventsFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventsToJson(this);
}
