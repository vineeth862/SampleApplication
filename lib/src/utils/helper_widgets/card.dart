import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String description;

  CardWidget({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Card(
        elevation: 2.0,
        shape: Theme.of(context).cardTheme.shape,
        color: Theme.of(context).cardTheme.color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              Text(
                description,
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
