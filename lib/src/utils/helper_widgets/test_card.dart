import 'package:flutter/material.dart';

class TestCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool isTestSelected;
  final String labName;
  late Function(Object card) tapOnCard;
  late Function(String test) tapOnButton;
  final String price;

  TestCardWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.tapOnCard,
      required this.tapOnButton,
      required this.isTestSelected,
      required this.labName,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          tapOnCard({title: title, description: description});
        },
        child: Container(
          // shape: Theme.of(context).cardTheme.shape,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 213, 213, 213).withOpacity(0.3)),

              // color: Color.fromARGB(255, 255, 181, 71),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35.0),
                topRight: Radius.circular(25.0),
              )),
          // color: Theme.of(context).cardTheme.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleLarge,
                    )),
                    // const Spacer(),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        tapOnButton("");
                      },
                      // icon: const Icon(
                      //   Icons.add,
                      //   size: 20,
                      // ),
                      child: isTestSelected ? Text("BOOKED") : Text("BOOK"),

                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        foregroundColor: isTestSelected
                            ? Theme.of(context).colorScheme.background
                            : Theme.of(context).colorScheme.primary,
                        backgroundColor: isTestSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onPrimary,
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
              ),
              // const SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  labName,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      description,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.currency_rupee_outlined,
                            size: 14,
                            weight: 50,
                            color: const Color.fromARGB(255, 106, 105, 105),
                          ),
                          Text(price),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                alignment: Alignment.center,
                transformAlignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 181, 71),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    )),

                child: Text(
                  "View More Details",
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: Colors.white),
                ),
                height: 50,
                // color: Color.fromARGB(255, 255, 181, 71),
              ),
              // const ListTile(
              //   enabled: true,
              //   contentPadding: EdgeInsets.all(0),
              //   title: Text("view more details"),
              //   textColor: Color.fromARGB(255, 255, 181, 71),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
