import 'package:flutter/material.dart';
import 'package:sample_application/src/screens/Home/explore/explore_category.dart';
import 'package:sample_application/src/screens/category/filtered_category_list.dart';

class Radiology extends StatelessWidget {
  const Radiology({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          title: Text("Radiology",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            // padding: const EdgeInsets.only(
            //   top: 8.0,
            //   left: 8,
            // ),
            child: Text(
              "Thanks for reaching out",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          Center(
            // const EdgeInsets.only(bottom: 8.0, left: 8),
            child: Text(
              "We are Coming Soon.....!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                // decoration: const BoxDecoration(
                //     gradient: LinearGradient(colors: [
                //   Color.fromARGB(255, 231, 243, 253),
                //   Color.fromARGB(255, 231, 243, 253),
                // ])),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio:
                      1.2, // Adjust the aspect ratio to control the card height
                  children: [
                    const MaleFemaleCategory(
                      name: "MRI",
                    ),
                    const MaleFemaleCategory(
                      name: "X-Ray",
                    ),
                    const MaleFemaleCategory(
                      name: "X-Ray",
                    ),
                    const MaleFemaleCategory(
                      name: "X-Ray",
                    ),
                    const MaleFemaleCategory(
                      name: "X-Ray",
                    ),
                    const MaleFemaleCategory(
                      name: "X-Ray",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
