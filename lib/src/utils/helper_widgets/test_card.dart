import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/utils/helper_widgets/link.dart';
import '../../screens/Home/explore/Search/Cards/card_detail_page.dart';
import '../../screens/Home/models/test/test.dart';

class TestCardWidget extends StatelessWidget {
  final String title;
  final bool isTest;
  final Test test;
  final bool isTestSelected;
  final String cardName;
  late Function(Object card) tapOnCard;
  late Function(String test) tapOnButton;
  final String price;

  TestCardWidget(
      {super.key,
      required this.title,
      required this.test,
      required this.tapOnCard,
      required this.tapOnButton,
      required this.isTestSelected,
      required this.cardName,
      required this.price,
      required this.isTest});

  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String getReportDate(Test testObj) {
      // if (testObj.testProcessingDays == '') {
      //   int totalHour;

      //   int tat = int.tryParse(testObj.tat)!;

      //   int sampleDeliveringHour = date.hour >= testObj.labOpeningTime &&
      //           date.hour < testObj.labClosingTime
      //       ? date.hour + 2
      //       : testObj.labOpeningTime + 2;

      //   if (testObj.labClosingTime > (sampleDeliveringHour + tat)) {
      //     totalHour = tat;
      //   } else {
      //     totalHour = (24 - date.hour) + testObj.labOpeningTime + tat;
      //   }
      //   int totalDays = (totalHour / 24).remainder(1) != 0
      //       ? (totalHour / 24).toInt() + 1
      //       : (totalHour / 24).toInt();
      //   if (!testObj.daily) {
      //     if ((5 - (date.weekday + totalDays)) >= 0) {
      //       totalDays += 2;
      //     }
      //   }
      //   if (totalHour < 24) {
      //     return "Reports Within $totalHour hours";
      //   }
      //   return "Reports Within $totalDays Days";
      // }
      return "Report Within ${testObj.tat} Active hours";
    }

    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          tapOnCard({title: title, test: test});
        },
        child: Container(
          // shape: Theme.of(context).cardTheme.shape,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 213, 213, 213).withOpacity(0.3)),
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.only(
                  // bottomLeft: Radius.circular(35.0),
                  // topRight: Radius.circular(25.0),
                  bottomLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          // color: Theme.of(context).cardTheme.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 20,
                        height: 30,
                        //color: Theme.of(context).colorScheme.tertiary,
                        // decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black)),
                        child: Image.asset(
                          "./assets/images/blood-test.png",
                          // scale: 1,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          isTest
                              ? Text("NABL",
                                  style: Theme.of(context).textTheme.bodyMedium)
                              : Container()
                        ],
                      ),
                    )
                    // const Spacer(),
                  ],
                ),
              ),
              // Divider(),
              // const SizedBox(height: 16.0),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          isTest ? "Test :" : "Lab :",
                          style: Theme.of(context).textTheme.headlineSmall,
                        )
                      ],
                    ),
                    Text(
                      cardName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
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
                      size: 14,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      getReportDate(test),
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    // const Spacer(),
                    // Container(
                    //   child: Row(
                    //     children: [
                    //       Icon(
                    //         Icons.currency_rupee_outlined,
                    //         size: 14,
                    //         weight: 50,
                    //         color: const Color.fromARGB(255, 106, 105, 105),
                    //       ),
                    //       Text(price),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // Divider(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Color.fromARGB(223, 252, 245, 226),
                ),
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                height: 45,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Define the action you want to perform when the link is tapped.
                        // You can navigate to a new screen or trigger some other action.
                      },
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: [
                                Text("₹${test.price}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (double.parse(test.price) * 1.25).toString(),
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 10),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("25%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium!
                                        .copyWith(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .error)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   width: 15,
                    // ),
                    Spacer(),
                    Link(
                      text: "Details",
                      navigate: CardDetailPage(test: test),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () async {
                          String userKey = globalservice.getCurrentUserKey();

                          if (userKey != "null") {
                            tapOnButton("");
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    //icon: Icon(Icons.time_to_leave),
                                    alignment: const AlignmentDirectional(1, 0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text("Please Login",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                    content: Text(
                                      "Please Login to book test",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium!,
                                    ),
                                    actions: [
                                      // Define buttons for the AlertDialog
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          minimumSize: MaterialStateProperty
                                              .all(const Size(80,
                                                  25)), // Set the desired size
                                        ),
                                        child: const Text("Login"),
                                        onPressed: () {
                                          globalservice.navigate(context,
                                              const Welcomesignin()); // Close the AlertDialog
                                        },
                                      ),
                                    ],
                                    actionsAlignment: MainAxisAlignment.end,
                                  );
                                });
                          }
                        },
                        // icon: const Icon(
                        //   Icons.add,
                        //   size: 20,
                        // ),
                        child: isTestSelected
                            ? Text(
                                "BOOKED",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              )
                            : Text(
                                "BOOK",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500),
                              ),

                        style: ElevatedButton.styleFrom(
                          // fixedSize: Size(10, 10),
                          // maximumSize: Size(10, 10),
                          padding: EdgeInsets.all(0),
                          foregroundColor: isTestSelected
                              ? Theme.of(context).colorScheme.background
                              : Theme.of(context).colorScheme.primary,
                          backgroundColor: isTestSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                6.0), // Adjust the border radius as needed
                            side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary), // Set the outline color
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
              // Container(
              //   alignment: Alignment.center,
              //   transformAlignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       color: Color.fromARGB(255, 255, 181, 71),
              //       borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(25.0),
              //         topRight: Radius.circular(25.0),
              //       )),

              //   child: Text(
              //     "View More Details",
              //     style: Theme.of(context)
              //         .textTheme
              //         .labelLarge!
              //         .copyWith(color: Colors.white),
              //   ),
              //   height: 50,
              //   // color: Color.fromARGB(255, 255, 181, 71),
              // ),

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
