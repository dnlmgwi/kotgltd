import 'package:kotgltd/features/events/model/eventRegistrationData.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'eventRegistrations.g.dart';

@JsonSerializable(explicitToJson: true)
class EventRegistrations {
  @JsonKey(name: 'eventRegistrations')
  EventRegistrationData eventRegistations;

  EventRegistrations({required this.eventRegistations});

  factory EventRegistrations.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationsFromJson(json);

  Map<String, dynamic> toJson() => _$EventRegistrationsToJson(this);
}
