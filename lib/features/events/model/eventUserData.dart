import 'package:kotgltd/features/events/model/eventUserAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'eventUserData.g.dart';

@JsonSerializable(explicitToJson: true)
class EventUserData {
  @JsonKey(name: 'attributes')
  EventUserAttributes eventUserAttributes;

  EventUserData({
    required this.eventUserAttributes,
  });

  factory EventUserData.fromJson(Map<String, dynamic> json) =>
      _$EventUserDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventUserDataToJson(this);
}
