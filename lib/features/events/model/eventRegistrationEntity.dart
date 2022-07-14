import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/events/model/eventRegistrationEntityAttributes.dart';
part 'eventRegistrationEntity.g.dart';

@JsonSerializable(explicitToJson: true)
class EventRegistrationEntityData {
  String id;

  @JsonKey(name: 'attributes')
  EventRegistrationEntityAttributes eventAttributes;

  EventRegistrationEntityData(
      {required this.id, required this.eventAttributes});

  factory EventRegistrationEntityData.fromJson(Map<String, dynamic> json) =>
      _$EventRegistrationEntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventRegistrationEntityDataToJson(this);
}
