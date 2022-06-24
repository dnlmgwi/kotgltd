import 'package:kotgltd/packages/dependencies.dart';
import 'package:lottie/lottie.dart';

class OnboardingPageModel {
  final String title;
  final String description;
  final LottieBuilder image;
  final Color bgColor;
  final Color textColor;

  OnboardingPageModel(
      {required this.title,
      required this.description,
      required this.image,
      this.bgColor = Colors.black,
      this.textColor = Colors.white});
}
