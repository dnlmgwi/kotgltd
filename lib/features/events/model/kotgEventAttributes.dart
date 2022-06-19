import 'package:kotgltd/features/events/model/kotgEventImage.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventAttributes {
  String name;

  @JsonKey(name: 'event_date')
  String eventDate;

  @JsonKey(name: 'event_time')
  String eventTime;

  @JsonKey(name: 'image')
  KOTGEventImage kotgEventImage;

  String description;

  @JsonKey(name: 'max_participants')
  int maxParticipants;

  int price;

  int prize;

  KOTGEventAttributes({
    required this.description,
    required this.eventDate,
    required this.eventTime,
    required this.name,
    required this.price,
    required this.prize,
    required this.maxParticipants,
    required this.kotgEventImage,
  });

  factory KOTGEventAttributes.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventAttributesToJson(this);
}
