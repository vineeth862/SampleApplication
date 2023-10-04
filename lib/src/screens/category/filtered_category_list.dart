// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_application/src/authentication/auth_validation/welcome_signin.dart';
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/explore/Search/Cards/filter-test-list.dart';
import 'package:sample_application/src/utils/Provider/search_provider.dart';
import 'package:sample_application/src/utils/helper_widgets/category_card.dart';

class FilterCategoryListPage extends StatefulWidget {
  final String? sexCategory;
  final String? ageGroup;
  final List? testList;
  const FilterCategoryListPage(
      {super.key, this.sexCategory, this.ageGroup, this.testList});

  @override
  State<FilterCategoryListPage> createState() => _FilterCategoryListPageState();
}

class _FilterCategoryListPageState extends State<FilterCategoryListPage> {
  List displayNames = [];

  getMaleCategory() async {
    if (widget.ageGroup != "all") {
      var pList = await FirebaseFirestore.instance
          .collection('packages/category/' + widget.sexCategory.toString())
          .doc(widget.ageGroup)
          .get();

      setState(() {
        displayNames = pList.data()!["testList"] as List;
      });
    } else {
      var pList = await FirebaseFirestore.instance
          .collection('packages/category/' + widget.sexCategory.toString())
          .get();
      pList.docs.forEach((element) {
        displayNames.add(element.data()['testList'][0]);
      });
      Set<String> uniqueDisplayNames = Set<String>.from(displayNames);
      setState(() {
        displayNames = uniqueDisplayNames.toList();
      });
    }
  }

  @override
  void initState() {
    if (widget.testList == null || widget.testList == []) {
      getMaleCategory();
    } else {
      setState(() {
        displayNames = widget.testList!.toList();
      });
    }
  }

  GlobalService globalservice = GlobalService();
  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchListState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sexCategory![0].toUpperCase() +
            widget.sexCategory!.substring(1) +
            " Category"),
      ),
      body: Container(
        child: ListView.builder(
          // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //   crossAxisCount: 3, // Number of columns
          // ),
          itemCount: displayNames.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () async {
                  await searchState.categoryClicked(
                      "displayName", displayNames[index]);
                  globalservice.navigate(
                      context,
                      FilteredTestCardlistPage(
                        title: displayNames[index],
                        category: displayNames[index],
                      ));
                },
                child: categoryCard(
                    displayName: displayNames[index], logo: "category")
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Container(
                //     //height: 80,
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //             color: Color.fromARGB(255, 213, 213, 213)
                //                 .withOpacity(0.3)),
                //         color: Theme.of(context).colorScheme.background,
                //         borderRadius: BorderRadius.only(
                //             // bottomLeft: Radius.circular(35.0),
                //             // topRight: Radius.circular(25.0),
                //             bottomLeft: Radius.circular(15.0),
                //             topRight: Radius.circular(15.0),
                //             topLeft: Radius.circular(15),
                //             bottomRight: Radius.circular(15))),
                //     child: Column(
                //       //crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             children: [
                //               ClipOval(
                //                 child: Container(
                //                   width: 20,
                //                   height: 30,
                //                   //color: Theme.of(context).colorScheme.tertiary,
                //                   // decoration: BoxDecoration(
                //                   //     border: Border.all(color: Colors.black)),
                //                   child: Image.asset(
                //                     "./assets/images/blood-test.png",
                //                     // scale: 1,
                //                     fit: BoxFit.fitWidth,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               Expanded(
                //                 child: Text(
                //                   displayNames[index],
                //                   style:
                //                       Theme.of(context).textTheme.headlineMedium,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Text(
                //           "About test",
                //           style: Theme.of(context).textTheme.headlineSmall,
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(4.0),
                //           child: Text(
                //             "RBC count is a blood test that measures how many red blood cells (RBCs) you have. RBCs contain hemoglobin , which carries oxygen. How much oxygen your body tissues get depends on how many RBCs you have and how well they work.",
                //             style: Theme.of(context).textTheme.bodyMedium,
                //             maxLines: 3,
                //             softWrap: true,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //         ),
                //         Divider(
                //           thickness: 1,
                //         ),
                //         Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.only(
                //                 bottomLeft: Radius.circular(10),
                //                 bottomRight: Radius.circular(10)),
                //             color: Color.fromARGB(223, 252, 245, 226),
                //           ),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.only(right: 12.0),
                //                 child: Container(
                //                   width: 80,
                //                   child: ElevatedButton(
                //                     onPressed: () async {
                //                       String userKey =
                //                           globalservice.getCurrentUserKey();

                //                       if (userKey != "null") {
                //                         searchState.categoryClicked(
                //                             "displayName", displayNames[index]);
                //                         globalservice.navigate(
                //                             context,
                //                             FilteredTestCardlistPage(
                //                               title: displayNames[index],
                //                               category: displayNames[index],
                //                             ));
                //                         ;
                //                       } else {
                //                         showDialog(
                //                             context: context,
                //                             builder: (BuildContext context) {
                //                               return AlertDialog(
                //                                 //icon: Icon(Icons.time_to_leave),
                //                                 alignment:
                //                                     const AlignmentDirectional(
                //                                         1, 0),
                //                                 shape: RoundedRectangleBorder(
                //                                     borderRadius:
                //                                         BorderRadius.circular(
                //                                             10)),
                //                                 title: Text("Please Login",
                //                                     style: Theme.of(context)
                //                                         .textTheme
                //                                         .headlineMedium!
                //                                         .copyWith(
                //                                             color:
                //                                                 Theme.of(context)
                //                                                     .colorScheme
                //                                                     .primary)),
                //                                 content: Text(
                //                                   "Please Login to book test",
                //                                   style: Theme.of(context)
                //                                       .textTheme
                //                                       .headlineMedium!,
                //                                 ),
                //                                 actions: [
                //                                   // Define buttons for the AlertDialog
                //                                   ElevatedButton(
                //                                     style: ButtonStyle(
                //                                       minimumSize:
                //                                           MaterialStateProperty
                //                                               .all(const Size(80,
                //                                                   25)), // Set the desired size
                //                                     ),
                //                                     child: const Text("Login"),
                //                                     onPressed: () {
                //                                       globalservice.navigate(
                //                                           context,
                //                                           const Welcomesignin()); // Close the AlertDialog
                //                                     },
                //                                   ),
                //                                 ],
                //                                 actionsAlignment:
                //                                     MainAxisAlignment.end,
                //                               );
                //                             });
                //                       }
                //                     },
                //                     // icon: const Icon(
                //                     //   Icons.add,
                //                     //   size: 20,
                //                     // ),
                //                     child: Text("Select Lab",
                //                         style: TextStyle(
                //                             fontSize: 12,
                //                             fontWeight: FontWeight.w500)),

                //                     style: ElevatedButton.styleFrom(
                //                       // fixedSize: Size(10, 10),
                //                       // maximumSize: Size(10, 10),
                //                       padding: EdgeInsets.all(0),
                //                       foregroundColor:
                //                           Theme.of(context).colorScheme.tertiary,
                //                       backgroundColor:
                //                           Theme.of(context).colorScheme.onPrimary,
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(
                //                             6.0), // Adjust the border radius as needed
                //                         side: BorderSide(
                //                             color: Theme.of(context)
                //                                 .colorScheme
                //                                 .tertiary), // Set the outline color
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                );
          },
        ),
      ),
    );
  }
}
