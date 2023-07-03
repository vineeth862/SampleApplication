import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AutoChangeImagesDemo extends StatefulWidget {
  @override
  _AutoChangeImagesDemoState createState() => _AutoChangeImagesDemoState();
}

class _AutoChangeImagesDemoState extends State<AutoChangeImagesDemo> {
  List<String> imagePaths = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  int currentIndex = 0;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    startImageTimer();
  }

  void startImageTimer() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % imagePaths.length;
          carouselController.animateToPage(
            currentIndex,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Auto Change Images Demo'),
        ),
        body: CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            scrollPhysics: NeverScrollableScrollPhysics(),
            height: 200,
            aspectRatio: 16 / 9,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          items: imagePaths.map((path) {
            return Builder(
              builder: (BuildContext context) {
                return Image.network(
                  path,
                  fit: BoxFit.cover,
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
