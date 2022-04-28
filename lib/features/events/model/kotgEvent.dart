import 'package:kotgltd/features/events/model/kotgEvents.dart';
import 'package:kotgltd/features/profile/model/profileAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEvent.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEvent {
  @JsonKey(name: 'events')
  KOTGEvents kotgEvents;

  KOTGEvent({required this.kotgEvents});

  factory KOTGEvent.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventToJson(this);
}
