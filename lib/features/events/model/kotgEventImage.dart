import 'package:kotgltd/features/events/model/kotgEventImageData.dart';
import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventImage.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventImage {
  // "image": {
  //   "data": {
  //     "attributes": {
  //       "url": "https://res.cloudinary.com/king-of-the-grid-esports/image/upload/v1644267842/Development/89266860_103330257953572_1062086983565705216_n_f5e2bf006c.jpg"
  //     }
  //   }
  // },

  @JsonKey(name: 'data')
  KOTGEventImageData eventImageData;

  KOTGEventImage({
    required this.eventImageData,
  });

  factory KOTGEventImage.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventImageFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventImageToJson(this);
}
