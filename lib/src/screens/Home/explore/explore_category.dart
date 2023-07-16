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
        children: [
          Padding(
            padding: EdgeInsets.all(3),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),

      // subtitle: Text("jsjvjvj"),
      // title: Text(title),
      // subtitle: Text('Card Subtitle'),
      // ),
    );
    // return ClipRRect(
    //     borderRadius: BorderRadius.circular(50),
    //     child: Card(
    //       child: Column(
    //         children: [
    //           Container(
    //             width: 60,
    //             height: 60,
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(50),
    //               child: Image.asset(
    //                 imagePath,
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.all(8),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   title,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 10,
    //                   ),
    //                 ),
    //                 // SizedBox(height: 4),
    //                 // Text(
    //                 //   content,
    //                 //   style: TextStyle(
    //                 //     fontSize: 14,
    //                 //   ),
    //                 // ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
  }
}
