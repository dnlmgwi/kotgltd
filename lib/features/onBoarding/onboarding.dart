import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kotgltd/common/color.dart';
import 'package:kotgltd/features/auth/pages/sign_in_page.dart';
import 'package:kotgltd/features/onBoarding/model/on_boarding_page_model.dart';
import 'package:kotgltd/features/onBoarding/onBoardingPages.dart';
import 'package:kotgltd/features/onBoarding/providers/onBoardingPageProviders.dart';
import 'package:kotgltd/packages/dependencies.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends ConsumerWidget {
  OnboardingPage({Key? key, required List<OnboardingPageModel> pages})
      : super(key: key);

  final pages = <OnboardingPageModel>[...onBoardingPages];

  // Define a controller for the pageview
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context, ref) {
    // Store the currently visible page
    final _currentPage = ref.watch(onBoardingPageProvider.state).state;

    void updatePage(int page) {
      ref.read(onBoardingPageProvider.state).state = page;
    }

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: pages[_currentPage].bgColor,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                // Pageview to render each page
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (idx) => updatePage(idx),
                  itemBuilder: (context, idx) {
                    final _item = pages[idx];
                    return Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: _item.image,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(_item.title,
                                    style: GoogleFonts.sarala(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                    )),
                              ),
                              Container(
                                constraints: BoxConstraints(maxWidth: 280),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 8.0),
                                child: Text(_item.description,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.sarala(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10.sp,
                                        color: Colors.grey)),
                              )
                            ]))
                      ],
                    );
                  },
                ),
              ),

              // Current page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pages
                    .map((item) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: _currentPage == pages.indexOf(item) ? 20 : 4,
                          height: 4,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                        ))
                    .toList(),
              ),

              // Bottom buttons
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(() => SignInPage());
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(color: Colors.white),
                        )),
                    TextButton(
                      onPressed: () {
                        if (_currentPage == pages.length - 1) {
                          Get.to(() => SignInPage());
                        } else {
                          _pageController.animateToPage(_currentPage + 1,
                              curve: Curves.easeInOutCubic,
                              duration: const Duration(milliseconds: 250));
                        }
                      },
                      child: Text(
                        _currentPage == pages.length - 1 ? "Finish" : "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
