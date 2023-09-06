import 'package:flutter/material.dart';

class HowItWorks extends StatelessWidget {
  final String? heading;
  final String? description;
  //Recieve image aswell
  const HowItWorks({super.key, this.heading, this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight: 100, minHeight: 50, maxWidth: 100, minWidth: 20),
              child: Container(
                child: Image.asset('./assets/images/Lab_two_people.jpg',
                    height: 70, fit: BoxFit.fitWidth),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topLeft,
                child: ListTile(
                  title: Text(heading.toString(),
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      //"Find a Health Test you are looking for from your desired diagnostics.",
                      description.toString(),
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  minVerticalPadding: 10,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
