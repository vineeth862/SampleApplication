import 'package:flutter/material.dart';
import 'package:sample_application/src/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import '../../screens/Home/models/package/package-detailPage.dart';
import '../../screens/Home/models/package/package.dart';

class PackageCardWidget extends StatelessWidget {
  final String title;
  final Package package;
  final bool isTestSelected;
  final String testList;
  late Function(Object card) tapOnCard;
  late Function(String test) tapOnButton;
  final String price;

  PackageCardWidget(
      {super.key,
      required this.title,
      required this.package,
      required this.tapOnCard,
      required this.tapOnButton,
      required this.isTestSelected,
      required this.testList,
      required this.price});

  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    String getReportDate(Package testObj) {
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
          tapOnCard({title: title, package: package});
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
                                      borderRadius: BorderRadius.circular(10)),
                                  title: Text("Please Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)),
                                  content: Text(
                                    "Please Login to book test",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!,
                                  ),
                                  actions: [
                                    // Define buttons for the AlertDialog
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            const Size(80,
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
                  testList,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontSize: 10),
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
                      getReportDate(package),
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
              GestureDetector(
                onTap: () {
                  globalservice.navigate(
                      context, PackageDetailPage(package: package));
                },
                child: Container(
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
