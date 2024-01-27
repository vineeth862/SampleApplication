import 'package:flutter/material.dart';

import '../../Home/profile/profile_home.dart';
import '../globalServices/global_service.dart';

class NoResultFoundCard extends StatelessWidget {
  GlobalService globalservice = GlobalService();
  final String title;
  NoResultFoundCard({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 80.0,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16.0),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8.0),
          Text(
            'Sorry, no results were found',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          GestureDetector(
            onTap: () {
              globalservice.navigate(context, const ProfileScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Please contact our customer service!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
