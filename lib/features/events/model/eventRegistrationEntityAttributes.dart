import 'package:kotgltd/features/auth/model/user.dart';
import 'package:kotgltd/features/events/model/eventUser.dart';
import 'package:kotgltd/features/events/model/kotgEventRegData.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'eventRegistrationEntityAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class EventRegistrationEntityAttributes {
  KOTGEventRegEventData event;

  EventUser user;

  String reference;

  String status;

  @JsonKey(name: 'registered_at')
  DateTime registeredAt;

  @JsonKey(name: 'transaction_id')
  String? transactionId;

  DateTime createdAt;

  EventRegistrationEntityAttributes({
    required this.event,
    required this.createdAt,
    required this.reference,
    required this.registeredAt,
    required this.status,
    required this.transactionId,
    required this.user,
  });

  factory EventRegistrationEntityAttributes.fromJson(
          Map<String, dynamic> json) =>
      _$EventRegistrationEntityAttributesFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EventRegistrationEntityAttributesToJson(this);
}
