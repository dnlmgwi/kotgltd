import 'package:kotgltd/features/events/model/kotgGame.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventRegAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventRegAttributes {
  String name;

  @JsonKey(name: 'event_date')
  String eventDate;

  @JsonKey(name: 'event_time')
  String eventTime;

  KOTGGame? game;

  int price;

  KOTGEventRegAttributes({
    required this.eventDate,
    required this.eventTime,
    required this.name,
    required this.game,
    required this.price,
  });

  factory KOTGEventRegAttributes.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventRegAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventRegAttributesToJson(this);
}
