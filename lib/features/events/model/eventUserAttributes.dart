import 'package:kotgltd/packages/dependencies.dart';
part 'eventUserAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class EventUserAttributes {
  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  EventUserAttributes({
    this.firstName,
    this.lastName,
  });

  factory EventUserAttributes.fromJson(Map<String, dynamic> json) =>
      _$EventUserAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$EventUserAttributesToJson(this);
}
