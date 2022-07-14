import 'package:kotgltd/features/events/model/kotgEventRegDataEntity.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventRegData.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventRegEventData {
  @JsonKey(name: 'data')
  KOTGEventDataEntity eventData;

  KOTGEventRegEventData({
    required this.eventData,
  });

  factory KOTGEventRegEventData.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventRegEventDataFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventRegEventDataToJson(this);
}
