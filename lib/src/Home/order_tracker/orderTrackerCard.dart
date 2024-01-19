import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample_application/src/Home/models/order/order.dart';
import 'package:sample_application/src/Home/models/package/package.dart';
import 'package:sample_application/src/Home/models/test/test.dart';
import 'package:sample_application/src/Home/order_tracker/order-summary/orderTrackerDailog.dart';
import 'package:sample_application/src/Home/order_tracker/orderTracker_progress.dart';
import 'package:sample_application/src/core/globalServices/global_service.dart';

class orderTrackerCard extends StatefulWidget {
  Order order;

  orderTrackerCard({super.key, required this.order});

  @override
  State<orderTrackerCard> createState() => _orderTrackerCardState();
}

class _orderTrackerCardState extends State<orderTrackerCard> {
  List<Order> orders = [];
  GlobalService globalservice = GlobalService();
  List<Widget> list1 = [];

  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  void navigate(Order order, context) {
    if (order.statusCode == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return OrderTrackerDialog(
            order: order,
          ); // Custom widget for the dialog content
        },
      );
    } else {
      this.globalservice.navigate(
          context,
          OrderTrackingScreen(
            order: order,
          ));
      // orderTraExp());
    }
  }

  getBookedItems(i) {
    final list = [];

    i.tests?.forEach((Test item) => list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text("Test -" + item.testName),
          ),
        )));

    i.packages?.forEach((Package item) => list.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text("Package -" + item.packageName),
          ),
        )));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    var list1 = getBookedItems(widget.order);
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 8),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        //color: Theme.of(context).colorScheme.tertiary,
        //height: 260,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
                title: Text(
                  "Test/Packages",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                subtitle: Text(DateFormat('y-MMM-dd hh:mm a').format(
                    DateTime.parse((widget.order.createdDate.toString())))),
                //subtitle: Text(order.createdDate.toString().substring(0, 16)),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                      height: 30,
                      child: Image.asset("assets/images/blood-test.png")),
                ),
                trailing: widget.order.statusCode! > 1
                    ? Container(
                        height: 30,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Center(
                          child: Text(
                            "Paid: ₹${widget.order.totalPrice}",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                      )
                    : Card()),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: ListTile(
                      title: Text(
                        'Home',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subtitle: Text(
                        widget.order.address!.fullAddress.toString(),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 10, bottom: 10),
                          child: Image.asset(
                            "assets/images/home.png",
                            width: 40,
                          )),
                      contentPadding: EdgeInsets.only(left: 0),
                    ),
                  ),
                ),
                Container(
                  height: 40.0, // Adjust the height as needed
                  width: 1.0,
                  color: Colors.black,
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                Expanded(
                  child: Center(
                    child: ListTile(
                      title: Text(
                        'Lab',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      subtitle: Text(
                        widget.order.labName.toString(),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: Padding(
                          padding: const EdgeInsets.only(
                              top: 0.0, left: 5, bottom: 10),
                          child: Image.asset(
                            "assets/images/lab.png",
                            width: 40,
                          )),
                      contentPadding: EdgeInsets.only(right: 10),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: Text(
                "Booked Test/Packages",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              height: 40,
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: list1.length,
                  itemBuilder: (context, index) {
                    return list1[index];
                  },
                ),
              ),
            ),
            //...getBookedItems(order),
            SizedBox(
              height: 5,
            ),
            Divider(),
            Row(
              children: [
                widget.order.statusCode! >= 11
                    ? Icon(
                        Icons.check_circle,
                        size: 15,
                        color: Theme.of(context).colorScheme.tertiary,
                      )
                    : Icon(Icons.pending_outlined,
                        size: 15, color: Color.fromARGB(255, 4, 61, 6)),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    widget.order.statusLabel.toString(),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: widget.order.statusCode! >= 11
                            ? Color.fromARGB(255, 11, 114, 14)
                            : Theme.of(context).colorScheme.primary),
                  ),
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () {
                    navigate(widget.order, context);
                  },
                  child: Text(widget.order.statusCode! > 1
                      ? "View Details"
                      : "Procced"),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Set the border radius value
                    ),
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
