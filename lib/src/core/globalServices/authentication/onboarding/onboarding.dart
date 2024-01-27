import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample_application/src/Home/explore/explore_why-us.dart';
import 'package:sample_application/src/Home/home.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/core/globalServices/authentication/onboarding/onboardingController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get_storage/get_storage.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(onBoardingController());
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndex,
            children: [
              const onBoardingPage(
                  image: "assets/images/search_lab_test.gif",
                  title: "Choose Test and Lab",
                  subtitle:
                      "Opt for a test at an NABL-accredited lab for quality assurance"),
              const onBoardingPage(
                  image: "assets/images/bookyourslot.gif",
                  title: "Schedule a doorstep test at your preferred time",
                  subtitle:
                      "Arrange a convenient doorstep test appointment at your preferred time."),
              const onBoardingPage(
                  image: "assets/images/getReport.gif",
                  title: "Genuine Report",
                  subtitle:
                      "Ensure accuracy with our commitment to delivering genuine and reliable reports."),
            ],
          ),
          const onBoardingSkip(),
          const onBoardingNavigation(),
          onBoardingNextButton()
        ],
      )),
    );
  }
}

class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 40,
        right: 20,
        child: ElevatedButton(
          child: Icon(
            Icons.arrow_forward_ios,
            size: 20,
          ),
          onPressed: () {
            onBoardingController.instance.nextPage();
          },
          style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.tertiary),
        ));
  }
}

class onBoardingNavigation extends StatelessWidget {
  const onBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final onboardingcontroller = onBoardingController.instance;

    return Positioned(
        bottom: 60,
        left: 20,
        child: SmoothPageIndicator(
          controller: onboardingcontroller.pageController,
          count: 3,
          effect: ExpandingDotsEffect(
              activeDotColor: Theme.of(context).colorScheme.primary,
              dotWidth: 10,
              dotHeight: 4),
        ));
  }
}

class onBoardingSkip extends StatelessWidget {
  const onBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        right: MediaQuery.of(context).size.width * 0.03,
        child: TextButton(
          child: Text(
            "Skip",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          onPressed: () {
            final storage = GetStorage();
            storage.write("isFirstTime", false);
            globalservice.navigate(context, Welcomesignin());
          },
        ));
  }
}

class onBoardingPage extends StatelessWidget {
  const onBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image, title, subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              image,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.height * 0.9,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 25),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                subtitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
