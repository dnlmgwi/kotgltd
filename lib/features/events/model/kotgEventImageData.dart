import 'package:kotgltd/packages/dependencies.dart';
import 'package:kotgltd/features/events/model/kotgEventImageAttributes.dart';
part 'kotgEventImageData.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventImageData {
  // "image": {
  //   "data": {
  //     "attributes": {
  //       "url": "https://res.cloudinary.com/king-of-the-grid-esports/image/upload/v1644267842/Development/89266860_103330257953572_1062086983565705216_n_f5e2bf006c.jpg"
  //     }
  //   }
  // },

  @JsonKey(name: 'attributes')
  KOTGEventImageAttributes kotgEventImageAttributes;

  KOTGEventImageData({
    required this.kotgEventImageAttributes,
  });

  factory KOTGEventImageData.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventImageDataFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventImageDataToJson(this);
}
