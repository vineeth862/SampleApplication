import 'package:flutter/material.dart';

class LabCardWidget extends StatelessWidget {
  final String title;
  final String description;

  late Function(Object card) onTap;

  LabCardWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          onTap({title: title, description: description});
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
                      onPressed: () {},
                      // icon: const Icon(
                      //   Icons.add,
                      //   size: 20,
                      // ),
                      child: const Text("BOOK"),

                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
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
