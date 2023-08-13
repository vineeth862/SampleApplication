import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_application/src/screens/userAdress/address_operation.dart';
import 'package:sample_application/src/screens/userAdress/address_operation_step2.dart';
import '../../../../global_service/global_service.dart';
import '../../../userAdress/add_address.dart';

class StepTwoScreen extends StatefulWidget {
  @override
  _StepTwoScreenState createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  GlobalService globalservice = GlobalService();
  List<String> items = List.generate(18,
      (index) => '4/5, 1st cross road, Byrappa Layout, whitefield, Bangalore');

  int visibleItemCount = 5;

  void _loadMoreItems() {
    setState(() {
      if (visibleItemCount < items.length) {
        visibleItemCount += 5;
      } else {
        visibleItemCount = visibleItemCount;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = false;
    bool isItemsNotPresent = false;
    if (items.length == 0) {
      isItemsNotPresent = true;
    }
    if (items.length < visibleItemCount) {
      visibleItemCount = items.length;
    }
    if (visibleItemCount < items.length) {
      isButtonEnabled = true;
    }
    return addressOperationStepTwo(
      routeDetails: StepTwoScreen(),
    );
  }
}
    // return SafeArea(
    //   child: Scaffold(
    //     body: SingleChildScrollView(
    //       child: Column(
    //         children: [
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Divider(
    //             height: 3,
    //           ),
    //           InkWell(
    //             onTap: () {
    //               Navigator.pop(context);
    //             },
    //             child: Container(
    //               alignment: Alignment.bottomLeft,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(15.0),
    //                 child: Row(
    //                   children: [
    //                     Icon(
    //                       Icons.gps_fixed,
    //                       color: Theme.of(context).colorScheme.primary,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Expanded(
    //                         child: Text(
    //                       "Use Current Location",
    //                       style: Theme.of(context)
    //                           .textTheme
    //                           .bodyLarge!
    //                           .copyWith(
    //                               color: Theme.of(context).colorScheme.primary),
    //                     )),
    //                     Icon(
    //                       Icons.arrow_forward_ios_rounded,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Divider(
    //             height: 5,
    //           ),
    //           addressOperation(
    //             routeDetails: StepTwoScreen(),
    //           )
              // InkWell(
              //   onTap: () {
              //     globalservice.navigate(
              //         context,
              //         AddAdress(
              //           routeInfo: StepTwoScreen(),
              //         ));
              //   },
              //   child: Container(
              //     alignment: Alignment.bottomLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Row(
              //         children: [
              //           Icon(
              //             Icons.add,
              //             color: Theme.of(context).colorScheme.primary,
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Expanded(
              //               child: Text(
              //             "Add Address",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodyLarge!
              //                 .copyWith(
              //                     color: Theme.of(context).colorScheme.primary),
              //           )),
              //           Icon(
              //             Icons.arrow_forward_ios_rounded,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Divider(
              //   height: 5,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //     child: Text(
              //       "Saved addresses",
              //       style: Theme.of(context)
              //           .textTheme
              //           .titleLarge!
              //           .copyWith(fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // isItemsNotPresent
              //     ? Column(
              //         children: [
              //           SizedBox(
              //             height: 10,
              //           ),
              //           Text(
              //             "No Saved Address",
              //             style: Theme.of(context).textTheme.titleLarge,
              //           ),
              //           Divider(
              //             height: 20,
              //           )
              //         ],
              //       )
              //     : SizedBox(
              //         height: MediaQuery.of(context).size.height * 0.6,
              //         width: MediaQuery.of(context).size.width * 0.9,
              //         child: ListView.builder(
              //           itemCount: visibleItemCount +
              //               1, // Add 1 for the "Load More" button
              //           itemBuilder: (context, index) {
              //             if (index < visibleItemCount) {
              //               return InkWell(
              //                 onTap: () {},
              //                 child: Container(
              //                   child: Column(
              //                     children: [
              //                       Row(
              //                         children: [
              //                           SizedBox(width: 10),
              //                           Icon(
              //                             Icons.home,
              //                             color: Theme.of(context)
              //                                 .colorScheme
              //                                 .primary,
              //                           ),
              //                           SizedBox(
              //                             width: 10,
              //                           ),
              //                           Expanded(
              //                             child: ListTile(
              //                               title: Text(items[index]),
              //                             ),
              //                           ),
              //                         ],
              //                       ),
              //                       Divider(
              //                         height: 10,
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             } else {
              //               return isButtonEnabled
              //                   ? ElevatedButton(
              //                       onPressed: _loadMoreItems,
              //                       child: Text('Load More'),
              //                     )
              //                   : null;
              //             }
              //           },
              //         ),
              //       )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
