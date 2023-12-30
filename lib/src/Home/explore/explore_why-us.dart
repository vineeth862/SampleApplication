import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  final List<String> imageUrls = [
    //'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/why-us%2Fwhy1.png?alt=media&token=7828f712-5515-4d22-8a8e-88a52e0d2512',
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/Designer.png?alt=media&token=964f2b67-e165-4cf9-b07e-7eea7bbb449a',
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/Designer%20(1).png?alt=media&token=c69af3d3-1195-4755-a3d1-7b7dbf84c4c4',
    //'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/why-us%2Fwhy2.png?alt=media&token=735fb633-0ddb-4353-9454-ede6167f90b5',
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/why-us%2Fwhy3.png?alt=media&token=6f4ee468-3ca4-460c-bbc1-b959ca44b0b9',
    // './assets/images/why-us4.png',
  ];

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageUrls.map((url) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(
                    10), // Adjust the border radius as needed
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ));
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 16 / 4,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            autoPlay: true, // Enable auto-playing of slides
            autoPlayInterval: const Duration(
                seconds: 5), // Set the duration between auto-playing slides
            autoPlayAnimationDuration: const Duration(microseconds: 1),
            autoPlayCurve: Curves.easeInOutQuart,
            enlargeCenterPage: true,
            pauseAutoPlayOnTouch: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // CarouselOptions(
          //   aspectRatio: 2.0,
          //   autoPlayAnimationDuration: Duration(milliseconds: 10),
          //   autoPlayInterval: Duration(seconds: 10),
          //   height: 100,
          //   autoPlay: true,
          //   enlargeCenterPage: true,
          // ),
          carouselController: _carouselController,
        ),
        SizedBox(
          height: 5,
        ),
        CarouselIndicator(
          count: imageUrls.length,
          index: _currentIndex,
          color: Color.fromARGB(255, 170, 170, 170),
          activeColor: Theme.of(context).colorScheme.primary,
          height: 8,
          width: 8,
          space: 5,
        ),
      ],
    );
  }
}

class MySliderTest extends StatefulWidget {
  const MySliderTest({super.key});

  @override
  State<MySliderTest> createState() => _MySliderTestState();
}

class _MySliderTestState extends State<MySliderTest> {
  final List<String> imageUrls = [
    //'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/why-us%2Fwhy1.png?alt=media&token=7828f712-5515-4d22-8a8e-88a52e0d2512',
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/Lipid-Profile-Test-in-Udaipur-.jpg?alt=media&token=86189b74-0750-4b64-b8a5-c7fd91b59ee5',
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/48.png?alt=media&token=a12a5cf8-748f-444e-b9e6-537f3d005533',
    //'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/why-us%2Fwhy2.png?alt=media&token=735fb633-0ddb-4353-9454-ede6167f90b5',
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/hq720.jpg?alt=media&token=b4654421-456d-4fe9-aac4-45b753cc872e',
    // './assets/images/why-us4.png',
  ];

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imageUrls.map((url) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(
                    10), // Adjust the border radius as needed
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ));
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 16 / 6,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            autoPlay: true, // Enable auto-playing of slides
            autoPlayInterval: const Duration(
                seconds: 5), // Set the duration between auto-playing slides
            autoPlayAnimationDuration: const Duration(microseconds: 1),
            autoPlayCurve: Curves.easeInOutQuart,
            enlargeCenterPage: true,
            pauseAutoPlayOnTouch: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          // CarouselOptions(
          //   aspectRatio: 2.0,
          //   autoPlayAnimationDuration: Duration(milliseconds: 10),
          //   autoPlayInterval: Duration(seconds: 10),
          //   height: 100,
          //   autoPlay: true,
          //   enlargeCenterPage: true,
          // ),
          carouselController: _carouselController,
        ),
        SizedBox(
          height: 5,
        ),
        CarouselIndicator(
          count: imageUrls.length,
          index: _currentIndex,
          color: Color.fromARGB(255, 170, 170, 170),
          activeColor: Theme.of(context).colorScheme.primary,
          height: 8,
          width: 8,
          space: 5,
        ),
      ],
    );
  }
}
