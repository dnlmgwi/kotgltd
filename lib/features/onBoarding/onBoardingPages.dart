import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/onBoarding/model/on_boarding_page_model.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:lottie/lottie.dart';

final onBoardingPages = [
  OnboardingPageModel(
    title: 'Play Games, Win Prizes',
    description:
        'Enjoy and compete against the in malawi right from the palm of your hands.',
    image: Lottie.asset(
      'assets/images/gaming-news-animation.json',
      height: 110.sp,
    ),
    bgColor: kotgBlack,
  ),
  OnboardingPageModel(
    title: 'Create Teams',
    description: 'Connect with your friends and prepare to play',
    image: Lottie.asset(
      'assets/images/gaming-community.json',
      height: 110.sp,
    ),
    bgColor: kotgBlack,
  ),
  OnboardingPageModel(
    title: 'Play from anywhere',
    description: 'Console, Mobile or PC you pick your platfrom',
    image: Lottie.asset(
      'assets/images/game-console-animation.json',
      height: 110.sp,
    ),
    bgColor: kotgBlack,
  ),
  // OnboardingPageModel(
  //   title: 'Follow Us',
  //   description: 'Follow our pages to stay in the loop.',
  //   image: Lottie.asset('assets/images/official_logo.json', width: 95.sp),
  //   bgColor: kotgBlack,
  // ),
];
