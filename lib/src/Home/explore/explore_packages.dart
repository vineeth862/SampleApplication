import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sample_application/src/Home/explore/category/explore_category.dart';
import '../../core/globalServices/global_service.dart';
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
  final List<labPackageCard> cardList = [
    labPackageCard(
      pacName: "MASTER HEALTH PACKAGE 2",
      pacDes: "Measure Vitamin D & B12 levels and others",
      pacPrice: "1999",
      pacFullPrice: "2599",
      pacDiscount: "20%",
      pacLab: "Apollo Diagnostics",
    ),
    labPackageCard(
      pacName: "Basic General Health Checkup 2",
      pacDes: "Measure Vitamin D & B12 levels and others",
      pacPrice: "2999",
      pacFullPrice: "3599",
      pacDiscount: "20%",
      pacLab: "Dr Lal Path Labs",
    ),
    labPackageCard(
      pacName: "Basic General Health Checkup-3",
      pacDes: "Measure Vitamin D & B12 levels and others",
      pacPrice: "4999",
      pacFullPrice: "5599",
      pacDiscount: "30%",
      pacLab: "RV Metropolis Diagnostic and Healthcare center Pvt.Ltd",
    ),
    labPackageCard(
      pacName: "MASTER HEALTH PACKAGE1 ",
      pacDes: "Measure Vitamin D & B12 levels and others",
      pacPrice: "6999",
      pacFullPrice: "7599",
      pacDiscount: "10%",
      pacLab: "Apollo Diagnostics",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: cardList.map((labPackageCard card) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: card,
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
        CarouselIndicator(
          count: cardList.length,
          index: _currentIndex,
          color: const Color.fromARGB(255, 170, 170, 170),
          activeColor: Theme.of(context).colorScheme.primary,
          height: 8,
          width: 8,
          space: 5,
        ),
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
                  labCode: "",
                ));
          },
        )
      ],
    );
  }
}
