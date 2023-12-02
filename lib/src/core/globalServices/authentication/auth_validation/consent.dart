import 'package:flutter/material.dart';

class ConsentScreen extends StatelessWidget {
  const ConsentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "./assets/images/Lab_two_people.jpg",
          width: double.infinity,
          height: 250,
        ),
        Container()
      ],
    );
  }
}
