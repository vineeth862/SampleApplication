import 'package:flutter/material.dart';

class OrderTrackerHome extends StatefulWidget {
  const OrderTrackerHome({super.key});

  @override
  State<OrderTrackerHome> createState() => _OrderTrackerHomeState();
}

class _OrderTrackerHomeState extends State<OrderTrackerHome> {
  var sBoxHeight;
  List<String> items = List.generate(3, (index) => 'Thyroid');
  @override
  Widget build(BuildContext context) {
    //CHNAGE THIS LOGIC IN FUTURE
    if (items.length > 1) {
      sBoxHeight = 0.15;
    } else {
      sBoxHeight = 0.07;
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    "|",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "Your Bookings",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.75, //DONT CHANGE THIS HEIGHT VALUE NEED TO TEST
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                itemCount:
                    8, //GET THE COUNT OF BOOKING DONE BY USER AND UPDATE HERE
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.2),
                            width: 2.0,
                          ),
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey.shade50,
                                Colors.grey.shade100,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.4),
                                  Theme.of(context).colorScheme.primary
                                ]),
                                // borderRadius: BorderRadius.only(
                                //   bottomLeft: Radius.circular(20.0),
                                //   bottomRight: Radius.circular(20.0),
                                // ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Anand Diagnostics", //CHANGE THE NAME TO PARTICULAR LAB NAME
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    Expanded(
                                      child: TextButton.icon(
                                        // icon: Icon(
                                        //   Icons.wifi_protected_setup_sharp,
                                        //   size: 15,
                                        // ),
                                        icon: const Icon(
                                          Icons.done_all_rounded,
                                          size: 15,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {},
                                        label: Text(
                                          "Completed",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(color: Colors.black),
                                        ), //UYPDATE COLOR OF THE BUTTON AND STATUS BASED ON THE ORDER STATUS
                                        // style: OutlinedButton.styleFrom(
                                        //   //minimumSize: Size(10, 30),
                                        //   shape: RoundedRectangleBorder(
                                        //     borderRadius:
                                        //         BorderRadius.circular(10.0),
                                        //   ),
                                        //   backgroundColor:
                                        //       Color.fromARGB(255, 169, 208, 172),
                                        // ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            // Divider(
                            //   height: 5,
                            //   thickness: 1,
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Booked Test",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height *
                            //       sBoxHeight,
                            //   width: MediaQuery.of(context).size.width * 0.9,
                            //   child: ListView.builder(
                            //     //itemExtent: 40,
                            //     itemCount: items
                            //         .length, //ITEMS MEANS TEST PRESENT INSIDE A ORDER
                            //     itemBuilder: (context, index) {
                            //       return Row(
                            //         children: [
                            //           Expanded(
                            //             child: ListTile(
                            //               title: Text(
                            //                 items[index],
                            //                 style: Theme.of(context)
                            //                     .textTheme
                            //                     .bodySmall,
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       );
                            //     },
                            //   ),
                            // ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text("Thyroid"),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text("Thyroid"),
                            ),
                            const Divider(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "27-10-1999 11:45:00",
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                                const SizedBox(width: 70),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("Track Order"),
                                      style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(10, 30),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
