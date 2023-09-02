import 'package:flutter/material.dart';

class LabTestCategoryCard extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;

  LabTestCategoryCard(this.title, this.content, this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.10,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.025,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
