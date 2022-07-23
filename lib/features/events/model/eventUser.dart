import 'package:kotgltd/features/events/model/eventUserData.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'eventUser.g.dart';

@JsonSerializable(explicitToJson: true)
class EventUser {
  @JsonKey(name: 'data')
  EventUserData eventUserData;

  EventUser({
    required this.eventUserData,
  });

  factory EventUser.fromJson(Map<String, dynamic> json) =>
      _$EventUserFromJson(json);

  Map<String, dynamic> toJson() => _$EventUserToJson(this);
}
