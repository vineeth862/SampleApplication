// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/card_detail_page.dart';
import 'package:sample_application/src/screens/Home/explore/Search/search_field.dart';
import 'package:sample_application/src/utils/helper_widgets/lab_card.dart';
import '../../../global_service/global_service.dart';
import 'Search/Provider/search_provider.dart';
import 'explore.service.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  ExploreService exploreService = ExploreService();
  GlobalService globalservice = GlobalService();

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     exploreService.filterCardList([], null);
  //   });
  // }

  final List<String> imgList = [
    // 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    // 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    // 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    // 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    // 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    // 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  late List<Widget> imageSliders = [];
  loadList() {
    imageSliders = imgList
        .map((item) => Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ))
        .toList();
  }

  @override
  build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    loadList();
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            alignment: Alignment.center,
            decoration: BoxDecoration(),
            child: GestureDetector(
              onTap: () {
                globalservice.navigate(context, const SearchBarPage());
              },
              child: TextField(
                decoration: InputDecoration(
                  enabled: false,
                  hintText: 'Search for Lab/Tests',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  contentPadding: EdgeInsets.all(16),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ),
            ),
          ),
          CarouselSlider(
            disableGesture: true,
            options: CarouselOptions(
              height: 100,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              autoPlay: true, // Enable auto-playing of slides
              autoPlayInterval: const Duration(
                  seconds: 5), // Set the duration between auto-playing slides
              autoPlayAnimationDuration: const Duration(microseconds: 1),
              autoPlayCurve: Curves.easeInOutQuart,
              enlargeCenterPage: true,
              pauseAutoPlayOnTouch: true,
            ),
            items: imageSliders,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: searchState.labList.length,
              itemBuilder: (BuildContext context, int index) {
                return LabCardWidget(
                    title: searchState.labList[index].name,
                    description: searchState.labList[index].test.toString(),
                    onTap: (value) {
                      globalservice.navigate(context, CardDetailPage());
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
