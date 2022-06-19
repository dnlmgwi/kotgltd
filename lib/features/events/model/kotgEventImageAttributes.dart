import 'package:kotgltd/packages/dependencies.dart';
part 'kotgEventImageAttributes.g.dart';

@JsonSerializable(explicitToJson: true)
class KOTGEventImageAttributes {
  // "image": {
  //   "data": {
  //     "attributes": {
  //       "url": "https://res.cloudinary.com/king-of-the-grid-esports/image/upload/v1644267842/Development/89266860_103330257953572_1062086983565705216_n_f5e2bf006c.jpg"
  //     }
  //   }
  // },

  String url;

  KOTGEventImageAttributes({
    required this.url,
  });

  factory KOTGEventImageAttributes.fromJson(Map<String, dynamic> json) =>
      _$KOTGEventImageAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$KOTGEventImageAttributesToJson(this);
}
