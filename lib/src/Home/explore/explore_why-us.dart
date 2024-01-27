import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/Home/explore/explore.service.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';

ExploreService exploreService = ExploreService();
GlobalService globalservice = GlobalService();

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  List<String> imageUrls = [];
  //ExploreService exploreService = ExploreService();
  //GlobalService globalservice = GlobalService();
  loadSlider() async {
    var imageUrlsLoaded = await exploreService.fetchSliderCards("about-us");
    setState(() {
      imageUrls = imageUrlsLoaded;
    });
  }

  //List<String> imageUrls = exploreService.fetchSliderCards();
  @override
  void initState() {
    loadSlider();
  }

  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        imageUrls.length > 0
            ? CarouselSlider(
                items: imageUrls.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the border radius as needed
                    child: Image.memory(
                      globalservice.getImageByteCode(url),
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  aspectRatio: 16 / 4,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  autoPlay: true, // Enable auto-playing of slides
                  autoPlayInterval: const Duration(
                      seconds:
                          5), // Set the duration between auto-playing slides
                  autoPlayAnimationDuration: const Duration(microseconds: 150),
                  autoPlayCurve: Curves.easeIn,
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
              )
            : Container(),
        const SizedBox(
          height: 5,
        ),
        imageUrls.length > 0
            ? CarouselIndicator(
                count: imageUrls.length,
                index: _currentIndex,
                color: const Color.fromARGB(255, 170, 170, 170),
                activeColor: Theme.of(context).colorScheme.primary,
                height: 8,
                width: 8,
                space: 5,
              )
            : CarouselIndicator(
                count: 4,
                index: _currentIndex,
                color: const Color.fromARGB(255, 170, 170, 170),
                activeColor: Theme.of(context).colorScheme.primary,
                height: 8,
                width: 8,
                space: 5,
              )
      ],
    );
  }
}
