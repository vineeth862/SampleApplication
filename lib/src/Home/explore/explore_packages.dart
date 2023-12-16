import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/Home/explore/explore.service.dart';

import '../../core/globalServices/global_service.dart';
import '../models/package/packageSliderCard.dart';
import '../package/package-suggetion-list.dart';

class PackageSlider extends StatefulWidget {
  const PackageSlider({super.key});

  @override
  State<PackageSlider> createState() => _PackageSliderState();
}

class _PackageSliderState extends State<PackageSlider> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();
  GlobalService globalservice = GlobalService();
  ExploreService exploreService = ExploreService();
  List<PackageSliderCard> cardList = [];

  void initState() {
    loadData();
  }

  loadData() async {
    cardList = await exploreService.fetchPackageCardsList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: cardList.map((PackageSliderCard card) {
            return Builder(
              builder: (BuildContext context) {
                return InkWell(
                  onTap: () {
                    globalservice.navigate(
                        context,
                        PackageSuggetionList(
                          title: card.title!,
                          labCode: "",
                        ));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.memory(
                      globalservice.getImageByteCode(card.image),
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            aspectRatio: 13 / 6,
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
        ),
        cardList.length > 0
            ? CarouselIndicator(
                count: cardList.length,
                index: _currentIndex,
                color: const Color.fromARGB(255, 170, 170, 170),
                activeColor: Theme.of(context).colorScheme.primary,
                height: 8,
                width: 8,
                space: 5,
              )
            : Card(),
        const SizedBox(
          height: 5,
        ),
        TextButton.icon(
          label: const Text("View all packages"),
          icon: const Icon(Icons.arrow_circle_right_sharp),
          onPressed: () {
            globalservice.navigate(
                context,
                PackageSuggetionList(
                  title: "",
                  labCode: "",
                ));
          },
        )
      ],
    );
  }
}
