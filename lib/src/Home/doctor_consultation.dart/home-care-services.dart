import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeCareServices extends StatefulWidget {
  const HomeCareServices({Key? key}) : super(key: key);

  @override
  State<HomeCareServices> createState() => _HomeCareServicesState();
}

class _HomeCareServicesState extends State<HomeCareServices> {
  int index = 0;
  final onboardingController = PageController(initialPage: 0);

  // Method to change the index of the selected page
  void changePageIndex(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(193, 255, 245, 236),
        body: Column(
          children: [
            Container(
                // margin: EdgeInsets.only(top: 10),
                alignment: Alignment.bottomCenter,
                width: 350.0,
                height: MediaQuery.of(context).size.height * 0.16,
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 25.0,
                    fontFamily: 'Agne',
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    isRepeatingAnimation: false,
                    repeatForever: false,
                    animatedTexts: [
                      TypewriterAnimatedText(
                          "We're Expanding! Look Forward To New Medical Services.",
                          textAlign: TextAlign.center,
                          textStyle: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontSize: 25,
                                  color:
                                      Theme.of(context).colorScheme.primary)),
                    ],
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                )),
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: onboardingController,
                    allowImplicitScrolling: true,
                    onPageChanged: (value) {
                      changePageIndex(value);
                    },
                    children: [
                      OnBoardingPage(
                        image: "assets/images/home-nurse-care.png",
                        title: "Nurse Care @ Home",
                        subtitle:
                            "Bringing healthcare to your doorstep. Our dedicated nurses provide professional and compassionate care at home, ensuring your comfort and well-being.",
                      ),
                      OnBoardingPage(
                        image: "assets/images/home-doctor-visit.png",
                        title: "Doctor Home Visit",
                        subtitle:
                            "Skip the wait, get timely medical attention with our Doctor Home Visit service.",
                      ),
                      OnBoardingPage(
                        image: "assets/images/home-physiotherapy-care.png",
                        title: "Physiotherapy @ Home",
                        subtitle:
                            "Stay comfortable while working towards recovery with our Physiotherapy at Home.",
                      ),
                    ],
                  ),
                  OnBoardingNavigation(
                    onboardingController: onboardingController,
                    pageCount: 3,
                    currentIndex: index,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({
    Key? key,
    required this.onboardingController,
    required this.pageCount,
    required this.currentIndex,
  }) : super(key: key);

  final PageController onboardingController;
  final int pageCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 40),
      child: SmoothPageIndicator(
        controller: onboardingController,
        count: pageCount,
        effect: ExpandingDotsEffect(
          activeDotColor: Theme.of(context).colorScheme.primary,
          dotWidth: 5,
          radius: 5,
          dotHeight: 5,
        ),
        onDotClicked: (index) {
          onboardingController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage(
      {Key? key,
      required this.image,
      required this.title,
      required this.subtitle})
      : super(key: key);

  String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                image,
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 1,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ])));
  }
}
