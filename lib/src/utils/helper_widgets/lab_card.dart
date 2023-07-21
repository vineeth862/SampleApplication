import 'package:flutter/material.dart';

class LabCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool isTestSelected;
  late Function(Object card) tapOnCard;
  late Function(String test) tapOnButton;

  LabCardWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.tapOnCard,
      required this.tapOnButton,
      required this.isTestSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          tapOnCard({title: title, description: description});
        },
        child: Card(
          elevation: 2.0,
          shape: Theme.of(context).cardTheme.shape,
          color: Theme.of(context).cardTheme.color,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        tapOnButton("");
                      },
                      // icon: const Icon(
                      //   Icons.add,
                      //   size: 20,
                      // ),
                      child: isTestSelected ? Text("BOOK") : Text("BOOKED"),

                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: isTestSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background,
                        backgroundColor: isTestSelected
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Adjust the border radius as needed
                          side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary), // Set the outline color
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(description),
                    const Spacer(),
                    Container(
                      child: const Text("price"),
                    )
                    // ListTile(
                    //   leading: Icon(Icons.lock_clock_outlined),
                    // )
                  ],
                ),
                const ListTile(
                  enabled: true,
                  contentPadding: EdgeInsets.all(0),
                  title: Text("view more details"),
                  textColor: Color.fromARGB(255, 255, 181, 71),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
