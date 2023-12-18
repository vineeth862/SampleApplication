import 'package:flutter/material.dart';

import '../../Home/profile/profile_home.dart';
import '../globalServices/global_service.dart';

class NoOrdersFoundCard extends StatelessWidget {
  GlobalService globalservice = GlobalService();
  final String title;
  NoOrdersFoundCard({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/empty-cart.jpeg',
            height: 150,
            color: Color.fromARGB(255, 54, 138, 235),
            colorBlendMode: BlendMode.color,
          ),
          // SizedBox(height: 16.0),
          GestureDetector(
            onTap: () {
              globalservice.navigate(context, ProfileScreen());
            },
            child: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: Color.fromARGB(213, 246, 76, 76)),
              ),
            ),
          ),

          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
