import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/core/globalServices/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';
import 'package:sample_application/src/core/Provider/search_provider.dart';

import '../../Home/explore/Search/Cards/filter-test-list.dart';
import '../../Home/explore/explore_why-us.dart';
import '../../Home/package/package-card-list.dart';

class categoryCard extends StatefulWidget {
  final String? displayName;
  final String? logo;
  categoryCard({super.key, required this.displayName, required this.logo});

  @override
  State<categoryCard> createState() => _categoryCardState();
}

class _categoryCardState extends State<categoryCard> {
  GlobalService globalservice = GlobalService();
  var test_des = "";

  // @override
  getTestdescription(title) async {
    var test_des_list =
        await exploreService.fetchTestDescription(widget.displayName);
    setState(() {
      test_des = test_des_list[0];
    });
  }

  @override
  void initState() {
    getTestdescription(widget.displayName);
  }

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        //height: 80,
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
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 20,
                      height: 30,
                      //color: Theme.of(context).colorScheme.tertiary,
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.black)),
                      child: widget.logo == "category"
                          ? Image.asset(
                              "./assets/images/blood-test.png",
                              // scale: 1,
                              fit: BoxFit.fitWidth,
                            )
                          : Image.asset(
                              "./assets/images/blood-tube.png",
                              // scale: 1,
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.displayName.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "About test",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                //"RBC count is a blood test that measures how many red blood cells (RBCs) you have. RBCs contain hemoglobin , which carries oxygen. How much oxygen your body tissues get depends on how many RBCs you have and how well they work.",
                test_des,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Color.fromARGB(223, 252, 245, 226),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Container(
                      width: 80,
                      child: ElevatedButton(
                        onPressed: () async {
                          // globalservice.navigate(
                          //     context,
                          //     PackageCardlistPage(
                          //       category: displayName.toString(),
                          //       title: displayName.toString(),
                          //     ));
                          String userKey = globalservice.getCurrentUserKey();

                          if (userKey != "null") {
                            searchState.categoryClicked(
                                "displayName", widget.displayName.toString());
                            globalservice.navigate(
                                context,
                                FilteredTestCardlistPage(
                                  title: widget.displayName.toString(),
                                  category: widget.displayName.toString(),
                                ));
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
                        child: Text("Select Lab",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w500)),

                        style: ElevatedButton.styleFrom(
                          // fixedSize: Size(10, 10),
                          // maximumSize: Size(10, 10),
                          padding: EdgeInsets.all(0),
                          foregroundColor:
                              Theme.of(context).colorScheme.tertiary,
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                6.0), // Adjust the border radius as needed
                            side: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiary), // Set the outline color
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
