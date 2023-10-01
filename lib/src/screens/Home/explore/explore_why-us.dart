import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  final List<String> imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/why-us%2Fwhy1.png?alt=media&token=7828f712-5515-4d22-8a8e-88a52e0d2512',
    'https://firebasestorage.googleapis.com/v0/b/experimentdatabase-87de1.appspot.com/o/why-us%2Fwhy2.png?alt=media&token=735fb633-0ddb-4353-9454-ede6167f90b5',
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
