import "package:flutter/material.dart";
import 'package:sample_application/src/global_service/global_service.dart';
import 'package:sample_application/src/screens/Home/home.dart';

class OrderTrackingScreen extends StatefulWidget {
  @override
  _OrderTrackingScreenState createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  GlobalService globalservice = GlobalService();
  String currentStatus = 'Collection Scheduled'; // Initial status
  String orderPlacedTime = "27/10/1999 10:57 AM";
  String samplePickupTime = "27/10/1999 10:57 AM";
  final List<String> trackingStatus = [
    'Order Placed',
    'Collection Scheduled',
    'Delivering Sample to Lab',
    'Processing Sample',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Order Tracking'),
        // ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 20, 104, 23),
                  Color.fromARGB(255, 17, 137, 21)
                ]),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        "Thanks For Choosing",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Health Fine",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "OrderID:123456",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildProgressLine(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: trackingStatus.length,
                      itemBuilder: (context, index) {
                        if (index == 1) {
                          // "Collection Scheduled" step
                          return _buildCollectionScheduledContainer(
                              trackingStatus.indexOf(currentStatus));
                        } else {
                          // Other steps
                          return Column(
                            children: [
                              ListTile(
                                // leading: Icon(
                                //   index <= trackingStatus.indexOf(currentStatus)
                                //       ? Icons.check_circle
                                //       : Icons.radio_button_unchecked,
                                //   color: index <= trackingStatus.indexOf(currentStatus)
                                //       ? Colors.green
                                //       : Colors.grey,
                                // ),
                                title: Text(
                                  trackingStatus[index],
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                subtitle: index == 0
                                    ? Text(
                                        'Order placed time: $orderPlacedTime')
                                    : null,
                                trailing: index ==
                                        trackingStatus.indexOf(currentStatus)
                                    ? Icon(Icons.chevron_right)
                                    : null,
                                onTap: () {
                                  // setState(() {
                                  //   currentStatus = trackingStatus[index];
                                  // });
                                },
                              ),
                              if (index < trackingStatus.length - 1)
                                Divider(
                                  thickness: 2.0,
                                  indent: 16.0,
                                  endIndent: 16.0,
                                ),
                              // ElevatedButton(
                              //   onPressed: sendWhatsAppMessage,
                              //   child: Text('Send WhatsApp Message'),
                              // ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            //OutlinedButton(onPressed: () {}, child: HomePage())
            Divider(
              thickness: 2,
            ),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      globalservice.navigate(context, HomePage());
                    },
                    child: Text("Return to Homepage"))),
            Divider(
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }

  //
  Widget _buildProgressLine() {
    return Container(
      width: 40.0,
      //color: Colors.grey,
      child: Column(
        children: List.generate(
          trackingStatus.length,
          (index) => Column(
            children: [
              SizedBox(height: 20.0), // Increase this spacing as needed
              Icon(
                index <= trackingStatus.indexOf(currentStatus)
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: index <= trackingStatus.indexOf(currentStatus)
                    ? Colors.green
                    : Colors.grey,
              ),
              if (index < trackingStatus.length - 1)
                if (index == 1 && currentStatus == "Collection Scheduled")
                  Container(
                    width: 2.0,
                    height: 40.0, // Increase this spacing as needed
                    color: Colors.grey,
                  ),
              if (index < trackingStatus.length - 1)
                Container(
                  width: 2.0,
                  height: 38.0, // Increase this spacing as needed
                  color: Colors.grey,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCollectionScheduledContainer(int index) {
    print(index);
    final isCancelable =
        index < trackingStatus.indexOf('Delivering Sample to Lab');

    return Container(
      width: 150.0, // Customize the width as needed
      color: Colors.grey[200],
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trackingStatus[1],
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 8.0),
          Text('Sample Pickup Time: $samplePickupTime'),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isCancelable)
                TextButton(
                  onPressed: () {
                    // Implement cancel order functionality
                  },
                  child: Text('Cancel Order'),
                )

              // Icon(
              //   index <= trackingStatus.indexOf(currentStatus)
              //       ? Icons.check_circle
              //       : Icons.radio_button_unchecked,
              //   color: index <= trackingStatus.indexOf(currentStatus)
              //       ? Colors.green
              //       : Colors.grey,
              // ),
            ],
          ),
        ],
      ),
    );
  }

  // void sendWhatsAppMessage() async {
  //   final phoneNumber =
  //       '9611339741'; // Replace with the recipient's phone number
  //   final message =
  //       'Hello, this is a WhatsApp message!'; // Replace with your message

  //

  //   var whatsappUrl = "whatsapp://send?phone= '91' + $phoneNumber" +
  //       "&text=${Uri.encodeComponent(message)}";
  //   Uri whatsappUrl1 = Uri.parse(whatsappUrl);
  //   try {
  //     await launchUrl(whatsappUrl1);
  //   } catch (e) {
  //     print(e);
  //     throw 'Could not launch WhatsApp.';
  //   }
  // }
}
