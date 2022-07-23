import 'package:kotgltd/features/events/model/kotgEventRegAttributes.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventRegDataEntity.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventDataEntity {
  String id;

  @JsonKey(name: 'attributes')
  KOTGEventRegAttributes eventRegAttributes;

  KOTGEventDataEntity({
    required this.id,
    required this.eventRegAttributes,
  });

  factory KOTGEventDataEntity.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventDataEntityToJson(this);
}
