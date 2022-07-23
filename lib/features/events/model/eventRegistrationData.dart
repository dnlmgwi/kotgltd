import 'package:kotgltd/features/events/model/eventRegistrationEntity.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'eventRegistrationData.g.dart';

@JsonSerializable(explicitToJson: true)
class EventRegistrationData {
  @JsonKey(name: 'data')
  List<EventRegistrationEntityData> eventRegistrationEntityData;

  EventRegistrationData({
    required this.eventRegistrationEntityData,
  });

  factory EventRegistrationData.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventRegistrationDataToJson(this);
}
